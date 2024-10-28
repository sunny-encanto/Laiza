import 'package:laiza/presentation/influencer/edit_profile/bloc/edit_profile_bloc.dart';

import '../../../../core/app_export.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

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
        child: Column(
          children: [
            CustomImageView(
              width: SizeUtils.width,
              height: 150.v,
              imagePath: ImageConstant.profileBg,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    _buildProfileCard(context),
                    SizedBox(height: 24.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Full Name',
                        style: textTheme.titleMedium,
                      ),
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
                    SizedBox(height: 108.v),
                  ],
                ),
              ),
            )
          ],
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
                if (!_formkey.currentState!.validate()) {
                  return;
                } else {
                  FocusScope.of(context).unfocus();
                  context.read<EditProfileBloc>().add(ProfileUpdateEvent());
                }
              },
            );
          },
        ),
      ),
    );
  }

  Row _buildProfileCard(BuildContext context) {
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
                    imagePath:
                        'https://as2.ftcdn.net/v2/jpg/03/83/25/83/1000_F_383258331_D8imaEMl8Q3lf7EKU2Pi78Cn0R7KkW9o.jpg',
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
