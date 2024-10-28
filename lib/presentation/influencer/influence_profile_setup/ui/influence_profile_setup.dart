// ignore_for_file: must_be_immutable

import 'package:laiza/core/app_export.dart';

class InfluenceProfileSetupScreen extends StatelessWidget {
  InfluenceProfileSetupScreen({super.key});
  final _bioController = TextEditingController();
  String _imagePath = '';
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            children: [
              SizedBox(height: 50.v),
              CustomImageView(width: 143.h, imagePath: ImageConstant.logo),
              SizedBox(height: 16.v),
              Text(
                'Set Up Your Influencer Profile',
                style: textTheme.titleLarge,
              ),
              SizedBox(height: 16.v),
              Text(
                'Complete your profile to showcase your personality and connect with brands and followers.',
                style: textTheme.bodySmall,
              ),
              SizedBox(height: 28.v),
              BlocConsumer<InfluenceProfileSetupBloc,
                  InfluenceProfileSetupState>(
                listener: (context, state) {
                  if (state is InfluenceImageUploadedState) {
                    _imagePath = state.imagePath;
                  }
                },
                builder: (context, state) {
                  return Container(
                    padding: EdgeInsets.all(20.h),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColor.offWhite),
                    child: CustomImageView(
                      onTap: () {
                        context
                            .read<InfluenceProfileSetupBloc>()
                            .add(InfluencerImageUploadEvent());
                      },
                      width: 75.h,
                      height: 75.h,
                      imagePath: _imagePath.isEmpty
                          ? ImageConstant.uploadImage
                          : _imagePath,
                    ),
                  );
                },
              ),
              SizedBox(height: 8.v),
              Text(
                'Upload Image',
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 32.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Add Short Bio',
                  style: textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 24.v),
              CustomTextFormField(
                controller: _bioController,
                maxLines: 10,
                hintText:
                    'Write a brief bio introducing yourself, your style, and what you’re passionate about',
              ),
              SizedBox(height: 80.v)
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(20.h),
        child:
            BlocConsumer<InfluenceProfileSetupBloc, InfluenceProfileSetupState>(
          listener: (context, state) {
            if (state is InfluenceProfileSetupError) {
              context.showSnackBar(state.message);
            }
          },
          builder: (context, state) {
            return CustomElevatedButton(
                isLoading: state is InfluenceProfileSetupLoading,
                onPressed: () {
                  context.read<InfluenceProfileSetupBloc>().add(
                      InfluencerProfileSetupSubmitRequest(
                          imagePath: _imagePath, bio: _bioController.text));
                },
                text: 'Continue');
          },
        ),
      ),
    );
  }
}
