// ignore_for_file: file_names

import 'package:laiza/core/app_export.dart';

import '../../../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../../../../widgets/custom_drop_down.dart';

class InfluencerFormScreen extends StatelessWidget {
  InfluencerFormScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final brandNameController = TextEditingController();
  final companyNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final instagramLinkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Form(
      key: _formKey,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0.h),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.v),
                Text(
                  context.translate('influenceWithPurpose'),
                  style: textTheme.titleLarge!.copyWith(
                      color: AppColor.lightTitleColor, fontSize: 18.fSize),
                ),
                SizedBox(height: 12.v),
                Text(
                  context.translate('joinUsNow'),
                  style: textTheme.titleLarge,
                ),
                SizedBox(height: 28.v),
                Text(
                  context.translate('fullNameField'),
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 8.v),
                CustomTextFormField(
                  controller: nameController,
                  hintText: context.translate('fullNamePlaceholder'),
                  validator: (value) {
                    return validateName(value!);
                  },
                ),
                SizedBox(height: 16.v),
                Text(
                  context.translate('instagramUsername'),
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 8.v),
                CustomTextFormField(
                  controller: brandNameController,
                  hintText: 'Eg. abc_xyz',
                  validator: (value) {
                    return validateField(
                        value: value!, title: ' instagram username');
                  },
                ),
                SizedBox(height: 16.v),
                Text(
                  context.translate('email'),
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 8.v),
                CustomTextFormField(
                  controller: emailController,
                  hintText: 'Eg. example@gmail.com',
                  validator: (value) {
                    return validateEmail(value!);
                  },
                ),
                SizedBox(height: 16.v),
                Text(
                  context.translate('phoneField'),
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 8.v),
                CustomTextFormField(
                  controller: phoneNumberController,
                  textInputType: TextInputType.number,
                  hintText: 'Eg. 88xxxx565',
                  maxLength: 10,
                  counter: const Visibility(visible: false, child: Text('')),
                  validator: (value) {
                    return validatePhoneNumber(value!);
                  },
                ),
                SizedBox(height: 16.v),
                Text(
                  context.translate('stateField'),
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 8.v),
                CustomDropDown(
                  hintText: context.translate('statePlaceholder'),
                  items: [SelectionPopupModel(title: 'Maharashtra')],
                  validator: (value) {
                    return validateField(
                        value: value?.title ?? '', title: 'state');
                  },
                ),
                SizedBox(height: 16.v),
                Text(
                  context.translate('cityField'),
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 8.v),
                CustomDropDown(
                  hintText: context.translate('cityPlaceholder'),
                  items: [SelectionPopupModel(title: 'indore')],
                  validator: (value) {
                    return validateField(
                        value: value?.title ?? '', title: 'city');
                  },
                ),
                SizedBox(height: 16.v),
                Text(
                  context.translate('productCategoryField'),
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 8.v),
                CustomDropDown(
                  hintText: 'Eg.Maharashtra',
                  items: [SelectionPopupModel(title: 'Maharashtra')],
                  validator: (value) {
                    return validateField(
                        value: value?.title ?? '', title: 'product category');
                  },
                ),
                SizedBox(height: 16.v),
                Text(
                  context.translate('followersOnInstagramField'),
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 8.v),
                CustomDropDown(
                  hintText: 'Eg. 1 Million',
                  items: [SelectionPopupModel(title: '1 Million')],
                  validator: (value) {
                    return validateField(
                        value: value?.title ?? '',
                        title: 'followers on instagram');
                  },
                ),
                SizedBox(height: 16.v),
                Text(
                  context.translate('instagramProfileLinkField'),
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 8.v),
                CustomTextFormField(
                    controller: instagramLinkController,
                    hintText: 'Eg. instagram.com/username123',
                    validator: (value) {
                      return validateField(
                          value: value!,
                          title: 'followers on instagram profile link');
                    }),
                SizedBox(height: 108.v),
              ],
            ),
          ),
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.all(16.0.h),
          child: BlocConsumer<InfluencerFormBloc, InfluencerFormState>(
            listener: (BuildContext context, InfluencerFormState state) {
              if (state is InfluencerFormSuccessState) {
                Navigator.of(context).pushReplacementNamed(
                    AppRoutes.influenceProfileSetupScreen);
              }
            },
            builder: (context, state) {
              return CustomElevatedButton(
                isLoading: state is InfluencerFormLoadingState,
                text: context.translate('joinNowButton'),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (!_formKey.currentState!.validate()) {
                    return;
                  } else {
                    context
                        .read<InfluencerFormBloc>()
                        .add(InfluencerFormSubmitEvent());
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
