import 'package:laiza/core/app_export.dart';
import 'package:laiza/widgets/custom_drop_down.dart';

import '../../../../data/models/selectionPopupModel/selection_popup_model.dart';

class SellerFormScreen extends StatelessWidget {
  SellerFormScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _brandNameController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _instagramLinkController = TextEditingController();

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
                  context.translate('startSellingTitle'),
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
                  controller: _nameController,
                  hintText: context.translate('fullNamePlaceholder'),
                  validator: (value) {
                    return validateName(value!);
                  },
                ),
                SizedBox(height: 16.v),
                Text(
                  context.translate('brandNameField'),
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 8.v),
                CustomTextFormField(
                  controller: _brandNameController,
                  hintText: context.translate('brandNamePlaceholder'),
                  validator: (value) {
                    return validateField(value: value!, title: 'brand name');
                  },
                ),
                SizedBox(height: 16.v),
                Text(
                  context.translate('companyNameField'),
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 8.v),
                CustomTextFormField(
                  controller: _companyNameController,
                  hintText: context.translate('companyNamePlaceholder'),
                  validator: (value) {
                    return validateField(value: value!, title: 'company name');
                  },
                ),
                SizedBox(height: 16.v),
                Text(
                  context.translate('email'),
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 8.v),
                CustomTextFormField(
                  controller: _emailController,
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
                  controller: _phoneNumberController,
                  textInputType: TextInputType.number,
                  maxLength: 10,
                  counter: const Visibility(visible: false, child: Text('')),
                  hintText: 'Eg. 88xxxx565',
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
                    controller: _instagramLinkController,
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
          child: BlocConsumer<SellerFormBloc, SellerFormState>(
            listener: (BuildContext context, SellerFormState state) {
              if (state is SellerFormSuccessState) {
                Navigator.of(context).pushNamed(AppRoutes.influencerFormScreen);
              }
            },
            builder: (context, state) {
              return CustomElevatedButton(
                isLoading: state is SellerFormLoadingState,
                text: context.translate('joinNowButton'),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (!_formKey.currentState!.validate()) {
                    return;
                  } else {
                    context.read<SellerFormBloc>().add(SellerFormSubmitEvent());
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
