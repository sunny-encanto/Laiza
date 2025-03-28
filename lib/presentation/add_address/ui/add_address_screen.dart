// ignore_for_file: must_be_immutable

import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/address_model/address_model.dart';

import '../../../data/blocs/city_bloc/city_bloc.dart';
import '../../../data/blocs/country_bloc/country_bloc.dart';
import '../../../data/blocs/state_bloc/state_bloc.dart';
import '../../../data/models/city_model/city.dart';
import '../../../data/models/countries/country.dart';
import '../../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../../../widgets/custom_drop_down.dart';

class AddAddressScreen extends StatelessWidget {
  final Address? address;

  AddAddressScreen({super.key, this.address});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController flatHouseNumberController =
      TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController landMarkController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  bool _isDefault = false;
  SelectionPopupModel? selectedCountry;
  SelectionPopupModel? selectedCategory;
  SelectionPopupModel? selectedState;
  SelectionPopupModel? selectedCity;
  SelectionPopupModel? selectedAddressType;
  List<SelectionPopupModel> addressTypeList = <SelectionPopupModel>[
    SelectionPopupModel(title: 'Home', value: 'Home'),
    SelectionPopupModel(title: 'Office', value: 'Office'),
    SelectionPopupModel(title: 'Other', value: 'Other'),
  ];

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    if (address != null) {
      nameController.text = address?.addressType ?? '';
      flatHouseNumberController.text = address?.houseNo ?? '';
      areaController.text = address?.areaStreet ?? '';
      landMarkController.text = address?.landmark ?? '';
      pinCodeController.text = address?.pinCode ?? '';
      _isDefault = address?.makeDefaultAddress == 1 ? true : false;
      selectedAddressType = SelectionPopupModel(
          title: address?.addressType ?? '', value: address?.addressType ?? "");
    }
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
            key: _formKey,
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
                CustomDropDown(
                  hintText: 'Select address Type',
                  value: selectedAddressType,
                  items: addressTypeList,
                  onChanged: (val) {
                    selectedAddressType = val;
                  },
                ),
                // BlocProvider(
                //   create: (context) =>
                //       AddressTypeBloc(context.read<AddressRepository>()),
                //   child: BlocBuilder<AddressTypeBloc, AddressTypeState>(
                //     builder: (context, state) {
                //       if (state is AddressTypeInitial) {
                //         context
                //             .read<AddressTypeBloc>()
                //             .add(FetchAddressTypeEvent());
                //       } else if (state is AddressTypeLoaded) {
                //         if (address != null) {
                //           var pAddressType = state.addressType.firstWhere(
                //               (item) =>
                //                   item.name.toLowerCase() ==
                //                   (address?.addressType?.toLowerCase() ?? ''));
                //           selectedAddressType = SelectionPopupModel(
                //               title: pAddressType.name, value: pAddressType.id);
                //         }
                //         return CustomDropDown(
                //           hintText: 'Select address Type',
                //           value: selectedAddressType,
                //           items: state.addressType
                //               .map((item) => SelectionPopupModel(
                //                   title: item.name, value: item.id))
                //               .toList(),
                //           onChanged: (val) {
                //             selectedAddressType = val;
                //           },
                //         );
                //       }
                //       return const SizedBox.shrink();
                //     },
                //   ),
                // ),
                // CustomTextFormField(
                //   controller: nameController,
                //   hintText: 'Eg. John Deo',
                //   validator: (value) {
                //     return validateName(value!);
                //   },
                // ),
                // SizedBox(height: 16.v),
                // Text(
                //   'Phone no.',
                //   style: textTheme.titleMedium,
                // ),
                // SizedBox(height: 8.v),
                // CustomTextFormField(
                //   controller: phoneNumberController,
                //   textInputType: TextInputType.number,
                //   hintText: 'Eg. 88xxxx565',
                //   maxLength: 10,
                //   counter: const Visibility(visible: false, child: Text('')),
                //   validator: (value) {
                //     return validatePhoneNumber(value!);
                //   },
                // ),
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
                  maxLength: 6,
                  counter: const Text(''),
                  textInputType: TextInputType.number,
                  validator: (value) {
                    return validateField(value: value!, title: 'pin code');
                  },
                ),

                SizedBox(height: 8.v),
                // GooglePlacesAutoCompleteTextFormField(
                //     decoration: InputDecoration(
                //       fillColor: AppColor.offWhite,
                //       errorBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10.h),
                //         borderSide: BorderSide(
                //           color: AppColor.offWhite,
                //           width: 1,
                //         ),
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10.h),
                //         borderSide: BorderSide(
                //           color: AppColor.offWhite,
                //           width: 1,
                //         ),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10.h),
                //         borderSide: BorderSide(
                //           color: AppColor.offWhite,
                //           width: 1,
                //         ),
                //       ),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(10.h),
                //         borderSide: BorderSide(
                //           color: AppColor.offWhite,
                //           width: 1,
                //         ),
                //       ),
                //     ),
                //     textEditingController: addressController,
                //     googleAPIKey: "AIzaSyAK1XCshXNXCZcur8HpTbyCC6QCcktaGJs",
                //     // googleAPIKey: "AIzaSyCpqoRKJ3CM7GGiFWTEY0qCKYYRh00ULF0",
                //
                //     debounceTime: 400,
                //     countries: ["in"],
                //     fetchCoordinates: true,
                //     onPlaceDetailsWithCoordinatesReceived: (prediction) {
                //       print(
                //           "Coordinates: (${prediction.lat},${prediction.lng})");
                //     },
                //     onSuggestionClicked: (prediction) {
                //       addressController.text = prediction.description ?? '';
                //       addressController.selection = TextSelection.fromPosition(
                //           TextPosition(
                //               offset: prediction.description?.length ?? 0));
                //     }),
                // SizedBox(height: 16.v),

                Text(
                  'Country',
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 8.v),
                BlocBuilder<CountryBloc, CountryState>(
                  builder: (BuildContext context, CountryState state) {
                    if (state is CountryInitial) {
                      context.read<CountryBloc>().add(CountryLoadEvent());
                      return const SizedBox.shrink();
                    } else if (state is CountryLoadingState) {
                      return const SizedBox.shrink();
                    } else if (state is CountryLoadedSate) {
                      if (address != null) {
                        var pCountry = state.countries.firstWhere(
                            (item) => item.id == (address?.country ?? 0));
                        selectedCountry = SelectionPopupModel(
                            title: pCountry.name, value: pCountry.id);
                        context
                            .read<StateBloc>()
                            .add(StateLoadEvent(selectedCountry?.value ?? 0));
                      }
                      return CustomDropDown(
                        value: selectedCountry,
                        hintText: 'Select Country',
                        items: state.countries
                            .map((Country country) => SelectionPopupModel(
                                title: country.name, value: country.id))
                            .toList(),
                        validator: (SelectionPopupModel? value) {
                          return validateField(
                              value: value?.title ?? '', title: 'country');
                        },
                        onChanged: (SelectionPopupModel? val) {
                          selectedCountry = val;
                          selectedState = null;
                          context
                              .read<StateBloc>()
                              .add(StateLoadEvent(val?.value ?? 0));
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                SizedBox(height: 16.v),
                Text(
                  context.translate('stateField'),
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 8.v),
                BlocBuilder<StateBloc, StateState>(
                  builder: (BuildContext context, state) {
                    if (state is StateInitial) {
                      return CustomDropDown(
                        value: selectedState,
                        hintText: 'Select State',
                        items: const <SelectionPopupModel>[],
                        validator: (SelectionPopupModel? value) {
                          return validateField(
                              value: value?.title ?? '', title: 'state');
                        },
                        onChanged: (SelectionPopupModel val) {
                          selectedState = val;
                          selectedCity = null;

                          context
                              .read<CityBloc>()
                              .add(CityLoadEvent(val.value ?? 0));
                        },
                      );
                    } else if (state is StateLoading) {
                      return const SizedBox.shrink();
                    } else if (state is StateLoaded) {
                      if (address != null) {
                        var pState = state.states.firstWhere(
                            (item) => item.id == (address?.state ?? 0));
                        selectedState = SelectionPopupModel(
                            title: pState.name, value: pState.id);
                        context
                            .read<CityBloc>()
                            .add(CityLoadEvent(selectedState?.value ?? 0));
                      }
                      return CustomDropDown(
                        value: selectedState,
                        hintText: 'Select State',
                        items: state.states
                            .map((state) => SelectionPopupModel(
                                title: state.name, value: state.id))
                            .toList(),
                        validator: (SelectionPopupModel? value) {
                          return validateField(
                              value: value?.title ?? '', title: 'state');
                        },
                        onChanged: (SelectionPopupModel val) {
                          selectedState = val;
                          selectedCity = null;
                          context
                              .read<CityBloc>()
                              .add(CityLoadEvent(val.value ?? 0));
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                SizedBox(height: 16.v),
                Text(
                  context.translate('cityField'),
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 8.v),
                BlocBuilder<CityBloc, CityState>(
                  builder: (BuildContext context, CityState state) {
                    if (state is CityInitial) {
                      return CustomDropDown(
                        value: selectedCity,
                        hintText: "Select City",
                        items: const <SelectionPopupModel>[],
                        validator: (SelectionPopupModel? value) {
                          return validateField(
                              value: value?.title ?? '', title: 'city');
                        },
                        onChanged: (SelectionPopupModel val) {
                          selectedCity = val;
                        },
                      );
                    } else if (state is CityLoadingSate) {
                      return const SizedBox.shrink();
                    } else if (state is CityLoaded) {
                      if (address != null) {
                        var pCity = state.cities.firstWhere(
                            (item) => item.id == (address?.city ?? 0));
                        selectedCity = SelectionPopupModel(
                            title: pCity.name, value: pCity.id);
                      }
                      return CustomDropDown(
                        value: selectedCity,
                        hintText: "Select City",
                        items: state.cities
                            .map((City city) => SelectionPopupModel(
                                title: city.name, value: city.id))
                            .toList(),
                        validator: (SelectionPopupModel? value) {
                          return validateField(
                              value: value?.title ?? '', title: 'city');
                        },
                        onChanged: (SelectionPopupModel val) {
                          selectedCity = val;
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                SizedBox(
                  height: 16.v,
                ),
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
              context.showSnackBar(state.message);
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            return CustomElevatedButton(
              isLoading: state is AddAddressLoadingState,
              text: 'Add Address',
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (!_formKey.currentState!.validate()) {
                  return;
                } else {
                  context.read<AddAddressBloc>().add(AddAddressSubmitEvent(
                          address: Address(
                        addressType: selectedAddressType?.title ?? '',
                        houseNo: flatHouseNumberController.text,
                        pinCode: pinCodeController.text,
                        areaStreet: areaController.text,
                        landmark: landMarkController.text,
                        state: selectedState?.value ?? 0,
                        city: selectedCity?.value ?? 0,
                        makeDefaultAddress: _isDefault ? 1 : 0,
                        country: selectedCountry?.value ?? 0,
                      )));
                }
              },
            );
          },
        ),
      ),
    );
  }
}
