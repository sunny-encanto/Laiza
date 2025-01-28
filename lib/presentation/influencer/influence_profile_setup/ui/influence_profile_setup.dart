// ignore_for_file: must_be_immutable

import 'package:laiza/core/app_export.dart';

import '../../../../data/blocs/category_bloc/category_bloc.dart';
import '../../../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../../../../widgets/custom_drop_down.dart';

class InfluenceProfileSetupScreen extends StatelessWidget {
  InfluenceProfileSetupScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _xController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _snapChatController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _imagePath = '';
  SelectionPopupModel? selectedCategory;

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
                listener:
                    (BuildContext context, InfluenceProfileSetupState state) {
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
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      create: (context) =>
                          CategoryBloc(context.read<CategoryRepository>()),
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
              )

              // SizedBox(height: 80.v)
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
