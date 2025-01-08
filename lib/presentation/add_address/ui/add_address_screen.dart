// ignore_for_file: must_be_immutable

import 'package:laiza/core/app_export.dart';

import '../../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../../../widgets/custom_drop_down.dart';

class AddAddressScreen extends StatelessWidget {
  AddAddressScreen({super.key});

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController flatHouseNumberController =
      TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController landMarkController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  bool _isDefault = false;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Delivery Address',
          style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter a new delivery address',
                  style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
                ),
                SizedBox(height: 20.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Name',
                    style: textTheme.titleMedium,
                  ),
                ),
                SizedBox(height: 8.v),
                CustomTextFormField(
                  controller: nameController,
                  hintText: 'Eg. John Deo',
                  validator: (value) {
                    return validateName(value!);
                  },
                ),
                SizedBox(height: 16.v),
                Text(
                  'Phone no.',
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
                  'Flat, House no., Building, Company, Apartment',
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 8.v),
                CustomTextFormField(
                  controller: flatHouseNumberController,
                  hintText: 'Eg. 108,  Shanti Vihar Appartment',
                  validator: (value) {
                    return validateField(value: value!, title: 'address');
                  },
                ),
                SizedBox(height: 16.v),
                Text(
                  'Area, Street, Sector, Village',
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 8.v),
                CustomTextFormField(
                  controller: areaController,
                  hintText: 'Eg. Clock tower square',
                  validator: (value) {
                    return validateField(value: value!, title: 'area');
                  },
                ),
                SizedBox(height: 16.v),
                Text(
                  'Landmark',
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 8.v),
                CustomTextFormField(
                  controller: landMarkController,
                  hintText: 'Eg. near IT park',
                  validator: (value) {
                    return validateField(value: value!, title: 'landmark');
                  },
                ),
                SizedBox(height: 16.v),
                Text(
                  'Pin Code',
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 8.v),
                CustomTextFormField(
                  controller: pinCodeController,
                  hintText: 'Eg.446584',
                  validator: (value) {
                    return validateField(value: value!, title: 'pin code');
                  },
                ),
                SizedBox(height: 16.v),
                Text(
                  'Town /City',
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 8.v),
                CustomTextFormField(
                  controller: cityController,
                  hintText: 'Eg. near IT park',
                  validator: (value) {
                    return validateField(value: value!, title: 'city');
                  },
                ),
                SizedBox(height: 16.v),
                Text(
                  'State',
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 8.v),
                CustomDropDown(
                  hintText: 'Eg. Maharashtra',
                  items: [SelectionPopupModel(title: 'Maharashtra')],
                  validator: (value) {
                    return validateField(
                        value: value?.title ?? '', title: 'state');
                  },
                ),
                SizedBox(height: 16.v),
                Row(
                  children: [
                    BlocConsumer<AddAddressBloc, AddAddressState>(
                      listener: (context, state) {
                        if (state is DefaultAddressToggleState) {
                          _isDefault = state.isDefault;
                        }
                      },
                      builder: (BuildContext context, AddAddressState state) {
                        return Checkbox(
                            activeColor: AppColor.primary,
                            value: _isDefault,
                            onChanged: (value) {
                              context.read<AddAddressBloc>().add(
                                    AddAddressSubmitEvent(
                                      address: 'address',
                                      isDefault: _isDefault,
                                    ),
                                  );
                              context
                                  .read<AddAddressBloc>()
                                  .add(DefaultAddressToggleEvent(value!));
                            });
                      },
                    ),
                    Text(
                      'Make this as my default address',
                      style: textTheme.bodySmall,
                    )
                  ],
                ),
                SizedBox(height: 116.v),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(16.0.h),
        child: BlocConsumer<AddAddressBloc, AddAddressState>(
          listener: (BuildContext context, AddAddressState state) {
            if (state is AddAddressSuccessState) {
              // Navigator.of(context)
              //     .pushReplacementNamed(AppRoutes.successScreen);
            }
          },
          builder: (context, state) {
            return CustomElevatedButton(
              isLoading: state is AddAddressLoadingState,
              text: 'Add Address',
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (!_formkey.currentState!.validate()) {
                  return;
                } else {
                  context.read<AddAddressBloc>().add(
                        AddAddressSubmitEvent(
                          address: 'address',
                          isDefault: _isDefault,
                        ),
                      );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
