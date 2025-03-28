import 'package:laiza/core/app_export.dart';
import 'package:laiza/presentation/profile/bloc/profile_bloc.dart';

import '../../../data/models/user/user_model.dart';

class UserEditProfileScreen extends StatelessWidget {
  UserEditProfileScreen({super.key});

  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  String _selectedBgImage = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UserModel? _userModel;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: BlocProvider(
        create: (context) => ProfileBloc(context.read<UserRepository>()),
        child: SingleChildScrollView(
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileInitial) {
                context.read<ProfileBloc>().add(FetchProfile());
              } else if (state is ProfileInitial) {
                return const SizedBox.shrink();
              } else if (state is ProfileError) {
                return Center(child: Text(state.message));
              } else if (state is ProfileLoaded) {
                _nameController.text = state.userModel.name ?? '';
                _emailController.text = state.userModel.email ?? '';
                _phoneNumberController.text = state.userModel.phoneNumber ?? '';
                _selectedBgImage = state.userModel.profileImg ?? '';
                _userModel = state.userModel;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.h),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///Image
                        BlocBuilder<EditProfileBloc, EditProfileState>(
                          buildWhen: (EditProfileState previous,
                                  EditProfileState current) =>
                              current is BgPhotoChangedState,
                          builder:
                              (BuildContext context, EditProfileState state) {
                            if (state is BgPhotoChangedState) {
                              _selectedBgImage = state.imagePath;
                              return Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CustomImageView(
                                    width: SizeUtils.width,
                                    height: 250.v,
                                    imagePath: state.imagePath,
                                    radius: BorderRadius.only(
                                      bottomLeft: Radius.circular(12.h),
                                      bottomRight: Radius.circular(12.h),
                                    ),
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
                                          borderRadius:
                                              BorderRadius.circular(5.h),
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
                                  height: 250.v,
                                  imagePath: _selectedBgImage.isEmpty
                                      ? ImageConstant.profileBg
                                      : _selectedBgImage,
                                  fit: BoxFit.fill,
                                  radius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12.h),
                                    bottomRight: Radius.circular(12.h),
                                  ),
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
                                        borderRadius:
                                            BorderRadius.circular(5.h),
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

                        ///From
                        SizedBox(height: 20.v),
                        Text(
                          "Name",
                          style: textTheme.titleMedium,
                        ),
                        SizedBox(height: 8.v),
                        CustomTextFormField(
                          controller: _nameController,
                          hintText: 'name',
                          validator: (String? value) {
                            return validateName(value!);
                          },
                        ),
                        SizedBox(height: 14.v),
                        Text(
                          "Email",
                          style: textTheme.titleMedium,
                        ),
                        SizedBox(height: 8.v),
                        CustomTextFormField(
                          readOnly: true,
                          controller: _emailController,
                          hintText: context.translate('example@gmail.com'),
                          validator: (String? value) {
                            return validateEmail(value!);
                          },
                        ),
                        SizedBox(height: 14.v),
                        Text(
                          "Phone",
                          style: textTheme.titleMedium,
                        ),
                        SizedBox(height: 8.v),
                        CustomTextFormField(
                          // readOnly: true,
                          controller: _phoneNumberController,
                          textInputType: TextInputType.number,
                          maxLength: 10,
                          counter: const Text(''),
                          hintText: 'phone',
                          // validator: (String? value) {
                          //   return validatePhoneNumber(value!);
                          // },
                        ),
                        SizedBox(height: 80.v),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(10.h),
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
                _userModel?.phoneNumber = _phoneNumberController.text;
                if (_selectedBgImage.isNotEmpty) {
                  _userModel?.profileImg = _selectedBgImage;
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
}
