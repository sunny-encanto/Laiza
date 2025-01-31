import 'package:laiza/data/models/user/user_model.dart';

import '../../../../core/app_export.dart';
import '../../../../data/blocs/category_bloc/category_bloc.dart';
import '../../../../data/models/category_model/Category.dart';
import '../../../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../../../../widgets/custom_drop_down.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _xController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _snapChatController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UserModel? _userModel;
  String _selectedImage = '';
  String _selectedBgImage = '';
  SelectionPopupModel? selectedCategory;
  List<Category> categories = <Category>[];

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<EditProfileBloc, EditProfileState>(
          buildWhen: (EditProfileState previous, EditProfileState current) =>
              current is ProfileFetchedState,
          builder: (BuildContext context, EditProfileState state) {
            if (state is EditProfileInitial) {
              context.read<EditProfileBloc>().add(FetchProfileEvent());
            } else if (state is ProfileFetchLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProfileFetchedState) {
              _nameController.text = state.user.name ?? "";
              _bioController.text = state.user.bio ?? "";
              _instagramController.text = state.user.instagramLink ?? '';
              _facebookController.text = state.user.facebookLink ?? '';
              _snapChatController.text = state.user.snapchatLink ?? '';
              _xController.text = state.user.xComLink ?? '';
              _bioController.text = state.user.bio ?? '';
              _selectedImage = state.user.profileImg ?? '';
              _userModel = state.user;
              return Column(
                children: [
                  BlocBuilder<EditProfileBloc, EditProfileState>(
                    buildWhen:
                        (EditProfileState previous, EditProfileState current) =>
                            current is BgPhotoChangedState,
                    builder: (BuildContext context, EditProfileState state) {
                      if (state is BgPhotoChangedState) {
                        _selectedBgImage = state.imagePath;
                        return Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CustomImageView(
                              width: SizeUtils.width,
                              height: 150.v,
                              imagePath: state.imagePath,
                            ),
                            InkWell(
                              onTap: () {
                                context
                                    .read<EditProfileBloc>()
                                    .add(BgPhotoChangeEvent());
                              },
                              child: Container(
                                margin: EdgeInsets.all(5.h),
                                padding: EdgeInsets.all(5.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.h),
                                    color: Colors.white),
                                child: CustomImageView(
                                  imagePath: ImageConstant.editIcon,
                                ),
                              ),
                            )
                          ],
                        );
                      }
                      return Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CustomImageView(
                            width: SizeUtils.width,
                            height: 150.v,
                            imagePath: _selectedBgImage.isEmpty
                                ? ImageConstant.profileBg
                                : _selectedBgImage,
                          ),
                          InkWell(
                            onTap: () {
                              context
                                  .read<EditProfileBloc>()
                                  .add(BgPhotoChangeEvent());
                            },
                            child: Container(
                              margin: EdgeInsets.all(5.h),
                              padding: EdgeInsets.all(5.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.h),
                                  color: Colors.white),
                              child: CustomImageView(
                                imagePath: ImageConstant.editIcon,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProfileCard(context, state.user),
                          SizedBox(height: 24.v),
                          Text(
                            'Full Name',
                            style: textTheme.titleMedium,
                          ),
                          SizedBox(height: 8.v),
                          CustomTextFormField(
                            controller: _nameController,
                            hintText: 'Carol Danvers',
                            validator: (value) {
                              return validateName(value!);
                            },
                          ),
                          SizedBox(height: 10.v),
                          Text(
                            context.translate('productCategoryField'),
                            style: textTheme.titleMedium,
                          ),
                          SizedBox(height: 8.v),
                          BlocProvider(
                            create: (context) => CategoryBloc(
                                context.read<CategoryRepository>()),
                            child: BlocBuilder<CategoryBloc, CategoryState>(
                              builder: (context, state) {
                                if (state is CategoryInitial) {
                                  context
                                      .read<CategoryBloc>()
                                      .add(CategoryLoadEvent());
                                  return const SizedBox.shrink();
                                } else if (state is CategoryLoading) {
                                  return const SizedBox.shrink();
                                } else if (state is CategoryLoaded) {
                                  categories.clear();
                                  categories.addAll(state.category);
                                  if (_userModel?.productCategory != null) {
                                    Category category = categories.firstWhere(
                                        (Category category) =>
                                            category.id ==
                                            _userModel?.productCategory!);
                                    selectedCategory = SelectionPopupModel(
                                        title: category.name ?? '',
                                        value: category.id);
                                  }
                                  return CustomDropDown(
                                    value: selectedCategory,
                                    hintText: 'Select Category',
                                    items: state.category
                                        .map((e) => SelectionPopupModel(
                                            value: e.id!.toInt(),
                                            title: e.name ?? ''))
                                        .toList(),
                                    validator: (value) {
                                      return validateField(
                                          value: value?.title ?? '',
                                          title: 'product category');
                                    },
                                    onChanged: (val) {
                                      selectedCategory = val;
                                    },
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 10.v),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Bio',
                              style: textTheme.titleMedium,
                            ),
                          ),
                          SizedBox(height: 8.v),
                          CustomTextFormField(
                            controller: _bioController,
                            maxLines: 10,
                            hintText: 'bio',
                            // validator: (value) {
                            //   return validateField(value: value!, title: 'bio');
                            // },
                          ),
                          SizedBox(height: 10.v),
                          Text(
                            'Instagram Account',
                            style: textTheme.titleMedium,
                          ),
                          SizedBox(height: 8.v),
                          CustomTextFormField(
                            controller: _instagramController,
                            hintText: 'Paste account link',
                            validator: (value) {
                              return validateName(value!);
                            },
                          ),
                          SizedBox(height: 10.v),
                          Text(
                            'X.com Account',
                            style: textTheme.titleMedium,
                          ),
                          SizedBox(height: 8.v),
                          CustomTextFormField(
                            controller: _xController,
                            hintText: 'Paste account link',
                            validator: (value) {
                              return validateName(value!);
                            },
                          ),
                          SizedBox(height: 10.v),
                          Text(
                            'Facebook Account ',
                            style: textTheme.titleMedium,
                          ),
                          SizedBox(height: 8.v),
                          CustomTextFormField(
                            controller: _facebookController,
                            hintText: 'Paste account link',
                            // validator: (value) {
                            //   return validateName(value!);
                            // },
                          ),
                          SizedBox(height: 10.v),
                          Text(
                            'Snapchat Account',
                            style: textTheme.titleMedium,
                          ),
                          SizedBox(height: 8.v),
                          CustomTextFormField(
                            controller: _snapChatController,
                            hintText: 'Paste account link',
                            // validator: (value) {
                            //   return validateName(value!);
                            // },
                          ),
                          SizedBox(height: 108.v),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(20.h),
        child: BlocConsumer<EditProfileBloc, EditProfileState>(
          listener: (context, state) {
            if (state is EditProfileSuccessState) {
              context.showSnackBar(state.message);
            } else if (state is EditProfileError) {
              context.showSnackBar(state.message);
            }
          },
          builder: (context, state) {
            return CustomElevatedButton(
              isLoading: state is EditProfileLoadingState,
              text: 'Update',
              onPressed: () {
                _userModel?.name = _nameController.text;
                _userModel?.productCategory = selectedCategory?.value ?? 0;
                _userModel?.instagramLink = _instagramController.text;
                _userModel?.xComLink = _xController.text;
                _userModel?.facebookLink = _facebookController.text;
                _userModel?.snapchatLink = _snapChatController.text;
                _userModel?.bio = _bioController.text;
                if (_selectedImage.isNotEmpty) {
                  _userModel?.profileImg = _selectedImage;
                }
                if (!_formKey.currentState!.validate()) {
                  return;
                } else {
                  FocusScope.of(context).unfocus();
                  context
                      .read<EditProfileBloc>()
                      .add(ProfileUpdateEvent(_userModel!));
                }
              },
            );
          },
        ),
      ),
    );
  }

  Row _buildProfileCard(BuildContext context, UserModel user) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            BlocBuilder<EditProfileBloc, EditProfileState>(
              buildWhen:
                  (EditProfileState previous, EditProfileState current) =>
                      current is ProfilePhotoChangedState,
              builder: (BuildContext context, EditProfileState state) {
                if (state is ProfilePhotoChangedState) {
                  _selectedImage = state.imagePath;
                  return Container(
                    padding: EdgeInsets.all(5.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(100.h),
                    ),
                    child: CustomImageView(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewImageWidget(
                            url: _selectedImage,
                            isFilePath: true,
                          ),
                        ));
                      },
                      radius: BorderRadius.circular(100.h),
                      width: 90.v,
                      height: 90.v,
                      fit: BoxFit.fill,
                      imagePath: state.imagePath,
                    ),
                  );
                }
                return Container(
                  padding: EdgeInsets.all(5.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(100.h),
                  ),
                  child: CustomImageView(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ViewImageWidget(url: user.profileImg ?? ''),
                      ));
                    },
                    radius: BorderRadius.circular(100.h),
                    width: 90.v,
                    height: 90.v,
                    fit: BoxFit.fill,
                    imagePath: user.profileImg,
                  ),
                );
              },
            ),
            SizedBox(width: 12.h),
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.username ?? '',
                      style:
                          textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            Container(
              height: 48.h,
              width: 48.h,
              padding: EdgeInsets.all(10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.h),
                border: Border.all(color: Colors.grey),
              ),
              child: CustomImageView(
                onTap: () {
                  context
                      .read<EditProfileBloc>()
                      .add(ProfilePhotoChangeEvent());
                },
                imagePath: ImageConstant.uploadIcon,
              ),
            ),
            SizedBox(height: 8.v),
            Text(
              'Profile Photo',
              style: textTheme.bodySmall,
            )
          ],
        ),
      ],
    );
  }
}
