import 'package:laiza/data/models/user/user_model.dart';

import '../../../../core/app_export.dart';
import '../../../../data/blocs/category_bloc/category_bloc.dart';
import '../../../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../../../../data/repositories/category_repository/category_repository.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../bloc/edit_profile_bloc.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _instagramController = TextEditingController();
  final _xController = TextEditingController();
  final _facebookController = TextEditingController();
  final _snapChatController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  UserModel? _userModel;
  String _selectedImage = '';
  SelectionPopupModel? selectedCategory;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: BlocBuilder<EditProfileBloc, EditProfileState>(
          buildWhen: (previous, current) => current is ProfileFetchedState,
          builder: (context, state) {
            if (state is EditProfileInitial) {
              context.read<EditProfileBloc>().add(FetchProfileEvent());
            } else if (state is ProfileFetchLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProfileFetchedState) {
              _nameController.text = state.user.name ?? "";
              _userModel = state.user;
              return Column(
                children: [
                  CustomImageView(
                    width: SizeUtils.width,
                    height: 150.v,
                    imagePath: ImageConstant.profileBg,
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
                                  return CustomDropDown(
                                    value: selectedCategory,
                                    hintText: 'Select Category',
                                    items: state.category
                                        .map((e) => SelectionPopupModel(
                                            value: e.id!.toInt(),
                                            title: e.categoryName ?? ''))
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
                            validator: (value) {
                              return validateField(value: value!, title: 'bio');
                            },
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
                            validator: (value) {
                              return validateName(value!);
                            },
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
                            validator: (value) {
                              return validateName(value!);
                            },
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
        child: BlocBuilder<EditProfileBloc, EditProfileState>(
          builder: (context, state) {
            return CustomElevatedButton(
              isLoading: state is EditProfileLoadingState,
              text: 'Update',
              onPressed: () {
                _userModel?.name = _nameController.text;
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
              buildWhen: (previous, current) =>
                  current is ProfilePhotoChangedState,
              builder: (context, state) {
                if (state is ProfilePhotoChangedState) {
                  _selectedImage = state.imagePath;
                  return Container(
                    padding: EdgeInsets.all(5.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(100.h),
                    ),
                    child: CustomImageView(
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
                      'Carol Danvers',
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
