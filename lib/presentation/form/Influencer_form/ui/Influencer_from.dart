// ignore_for_file: file_names

import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/blocs/city_bloc/city_bloc.dart';
import 'package:laiza/data/blocs/country_bloc/country_bloc.dart';
import 'package:laiza/data/blocs/profile_api_bloc/profile_api_bloc.dart';
import 'package:laiza/data/blocs/state_bloc/state_bloc.dart';
import 'package:laiza/data/models/city_model/city.dart';
import 'package:laiza/data/models/user/user_model.dart';

import '../../../../data/blocs/category_bloc/category_bloc.dart';
import '../../../../data/models/category_model/Category.dart';
import '../../../../data/models/countries/country.dart';
import '../../../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../cubit/stepper_cubit.dart';

// ignore: must_be_immutable
class InfluencerFormScreen extends StatelessWidget {
  InfluencerFormScreen({super.key});

  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController laizaUserNameController = TextEditingController();
  final TextEditingController brandNameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController instagramLinkController = TextEditingController();

  //Social Media Step
  final TextEditingController instagramUserNameController =
      TextEditingController();
  final TextEditingController followersCountController =
      TextEditingController();

  final TextEditingController xAccountController = TextEditingController();
  final TextEditingController facebookAccountController =
      TextEditingController();
  final TextEditingController snapchatController = TextEditingController();

  //Bank Detail Step
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController ifscCodeController = TextEditingController();
  final TextEditingController branchController = TextEditingController();
  final TextEditingController accountHolderNameController =
      TextEditingController();
  final TextEditingController aadhaarController = TextEditingController();
  final TextEditingController bankVerificationController =
      TextEditingController();

  SelectionPopupModel? selectedCountry;
  SelectionPopupModel? selectedCategory;
  SelectionPopupModel? selectedState;
  SelectionPopupModel? selectedCity;
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (BuildContext context) => StepperCubit(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.h),
            child: BlocBuilder<ProfileApiBloc, ProfileApiState>(
              builder: (context, state) {
                if (state is ProfileApiInitial) {
                  context.read<ProfileApiBloc>().add(FetchProfileApi());
                  return const SizedBox.shrink();
                } else if (state is ProfileApiError) {
                  return Center(child: Text(state.message));
                } else if (state is ProfileApiLoadedState) {
                  nameController.text = state.userModel.name ?? '';
                  emailController.text = state.userModel.email ?? '';
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12.v),
                      Align(
                        alignment: Alignment.center,
                        child: CustomImageView(
                            width: 100.h, imagePath: ImageConstant.logo),
                      ),
                      SizedBox(height: 16.v),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          context.translate('joinUsNow'),
                          style: textTheme.titleLarge!
                              .copyWith(fontSize: 16.fSize),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          context.translate('influenceWithPurpose'),
                          style: textTheme.titleLarge!.copyWith(
                              color: AppColor.lightTitleColor,
                              fontSize: 16.fSize),
                        ),
                      ),
                      SizedBox(height: 24.v),
                      BlocBuilder<StepperCubit, int>(
                        buildWhen: (previous, current) => previous != current,
                        builder: (BuildContext context, currentStep) {
                          _currentStep = currentStep;
                          return Align(
                            alignment: Alignment.center,
                            child: Text(
                              _getTittle(currentStep),
                              style: textTheme.titleLarge,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20.v),
                      // build Stepper Header
                      // BlocBuilder<StepperCubit, int>(
                      //   buildWhen: (previous, current) => previous != current,
                      //   builder: (BuildContext context, currentStep) {
                      //     _currentStep = currentStep;
                      //     return Padding(
                      //       padding: EdgeInsets.symmetric(horizontal: 20.h),
                      //       child: Row(
                      //         children: [
                      //           _buildStepIndication(0, currentStep, context),
                      //           Expanded(
                      //             child: Container(
                      //               width: 20,
                      //               height: 5.v,
                      //               decoration: BoxDecoration(
                      //                   color: currentStep <= 0
                      //                       ? Colors.grey
                      //                       : AppColor.primary),
                      //             ),
                      //           ),
                      //           _buildStepIndication(1, currentStep, context),
                      //           // Expanded(
                      //           //     child: Container(
                      //           //   width: 20,
                      //           //   height: 5.v,
                      //           //   decoration: BoxDecoration(
                      //           //       color: currentStep <= 1
                      //           //           ? Colors.grey
                      //           //           : AppColor.primary),
                      //           // )),
                      //           // _buildStepIndication(2, currentStep, context),
                      //         ],
                      //       ),
                      //     );
                      //   },
                      // ),
                      // SizedBox(height: 20.v),
                      // Build Stepper body
                      BlocBuilder<StepperCubit, int>(
                        buildWhen: (previous, current) => previous != current,
                        builder: (BuildContext context, currentStep) {
                          _currentStep = currentStep;
                          return Column(
                            children: [
                              Visibility(
                                  visible: currentStep == 0,
                                  maintainState: true,
                                  child: _buildPersonalInfoStep(context)),
                              Visibility(
                                  visible: currentStep == 1,
                                  maintainState: true,
                                  child: _buildSocialMediaStep(context)),
                              SizedBox(height: 50.v)
                              // Visibility(
                              //     visible: currentStep == 2,
                              //     maintainState: true,
                              //     child: _buildBankingDetailsStep(context)),
                            ],
                          );
                        },
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        bottomSheet: Padding(
          padding: EdgeInsets.all(16.0.h),
          child: BlocConsumer<InfluencerFormBloc, InfluencerFormState>(
            listener: (BuildContext context, InfluencerFormState state) {
              if (state is InfluencerFormErrorState) {
                context.showSnackBar(state.message);
              }
              if (state is InfluencerFormSuccessState) {
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.successScreen);
              }
            },
            builder: (context, state) {
              return CustomElevatedButton(
                isLoading: state is InfluencerFormLoadingState,
                text: 'Next',
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (_currentStep == 0) {
                    if (!_formKey1.currentState!.validate()) {
                      return;
                    } else {
                      context.read<StepperCubit>().nextStep(2);
                    }
                  } else if (_currentStep == 1) {
                    if (!_formKey2.currentState!.validate()) {
                      return;
                    } else {
                      UserModel userModel = UserModel(
                        name: nameController.text.trim(),
                        phoneNumber: phoneNumberController.text.trim(),
                        email: emailController.text.trim(),
                        country: selectedCountry?.value ?? 0,
                        state: selectedState?.value ?? 0,
                        city: selectedCity?.value ?? 0,
                        username: laizaUserNameController.text,
                        instagramUserName: instagramUserNameController.text,
                        instagramFollowers: followersCountController.text,
                        instagramLink: instagramLinkController.text.trim(),
                        xComLink: xAccountController.text.trim(),
                        facebookLink: facebookAccountController.text.trim(),
                        snapchatLink: snapchatController.text.trim(),
                        accountNumber: accountNumberController.text,
                        // iFCCode: ifscCodeController.text,
                        // branchName: branchController.text,
                        // accountHolderName: accountHolderNameController.text,
                        // aadharNumber: aadhaarController.text,
                        // bankVerification: bankVerificationController.text,
                      );

                      context
                          .read<InfluencerFormBloc>()
                          .add(InfluencerFormSubmitEvent(userModel));
                    }
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  String _getTittle(int currentStep) {
    switch (currentStep) {
      case 0:
        return 'Personal Information';
      case 1:
        return 'Social Media';
      case 2:
        return 'Banking Detail';
      default:
        return '';
    }
  }

  Form _buildPersonalInfoStep(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Form(
      key: _formKey1,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) =>
                  CountryBloc(context.read<RegionRepository>())),
          BlocProvider(
              create: (BuildContext context) =>
                  StateBloc(context.read<RegionRepository>())),
          BlocProvider(
              create: (BuildContext context) =>
                  CityBloc(context.read<RegionRepository>())),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              'Laiza Username',
              style: textTheme.titleMedium,
            ),
            SizedBox(height: 8.v),
            CustomTextFormField(
              controller: laizaUserNameController,
              hintText: 'username',
              validator: (value) {
                return validateName(value!);
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
              builder: (context, state) {
                if (state is StateInitial) {
                  return CustomDropDown(
                    value: selectedState,
                    hintText: 'Select State',
                    items: const <SelectionPopupModel>[],
                    validator: (value) {
                      return validateField(
                          value: value?.title ?? '', title: 'state');
                    },
                    onChanged: (val) {
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
              builder: (context, state) {
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
          ],
        ),
      ),
    );
  }

  Form _buildSocialMediaStep(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Form(
      key: _formKey2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.translate('instagramUsername'),
            style: textTheme.titleMedium,
          ),
          SizedBox(height: 8.v),
          CustomTextFormField(
            controller: instagramUserNameController,
            hintText: 'Eg. abc_xyz',
            validator: (value) {
              return validateField(value: value!, title: ' instagram username');
            },
          ),
          SizedBox(height: 16.v),
          Text(
            'Followers Count',
            style: textTheme.titleMedium,
          ),
          SizedBox(height: 8.v),
          CustomTextFormField(
            controller: followersCountController,
            textInputType: TextInputType.number,
            hintText: 'Eg.50K',
            validator: (value) {
              return validateField(value: value!, title: 'followers count');
            },
          ),
          SizedBox(height: 16.v),
          Text(
            'Instagram Account Link',
            style: textTheme.titleMedium,
          ),
          SizedBox(height: 8.v),
          CustomTextFormField(
            controller: instagramLinkController,
            hintText: 'Paste link',
            validator: (value) {
              return validateField(value: value!, title: ' instagram account');
            },
          ),
          SizedBox(height: 16.v),
          Text(
            'X.com Account Link',
            style: textTheme.titleMedium,
          ),
          SizedBox(height: 8.v),
          CustomTextFormField(
            controller: xAccountController,
            hintText: 'Paste link',
            validator: (value) {
              return validateField(value: value!, title: 'X.com account');
            },
          ),
          SizedBox(height: 16.v),
          Text(
            'Facebook Account Link',
            style: textTheme.titleMedium,
          ),
          SizedBox(height: 8.v),
          CustomTextFormField(
            controller: facebookAccountController,
            hintText: 'Paste link',
            validator: (value) {
              return validateField(value: value!, title: 'facebook account');
            },
          ),
          SizedBox(height: 16.v),
          Text(
            'Snapchat  Account Link',
            style: textTheme.titleMedium,
          ),
          SizedBox(height: 8.v),
          CustomTextFormField(
            controller: snapchatController,
            hintText: 'Paste link',
            validator: (value) {
              return validateField(value: value!, title: 'snapchat  account ');
            },
          ),
          SizedBox(height: 16.v),
          Text(
            'Category ',
            style: textTheme.titleMedium,
          ),
          SizedBox(height: 8.v),
          BlocProvider(
            create: (context) =>
                CategoryBloc(context.read<CategoryRepository>()),
            child: BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryInitial) {
                  context.read<CategoryBloc>().add(CategoryLoadEvent());
                  return const SizedBox.shrink();
                } else if (state is CategoryLoading) {
                  return const SizedBox.shrink();
                } else if (state is CategoryLoaded) {
                  return CustomDropDown(
                    value: selectedCategory,
                    hintText: 'Select Category',
                    items: state.category
                        .map((Category category) => SelectionPopupModel(
                            value: category.id!.toInt(),
                            title: category.categoryName ?? ''))
                        .toList(),
                    // validator: (SelectionPopupModel? value) {
                    //   return validateField(
                    //       value: value?.title ?? '', title: 'product category');
                    // },
                    onChanged: (SelectionPopupModel? val) {
                      selectedCategory = val;
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
          SizedBox(height: 16.v),
        ],
      ),
    );
  }

  GestureDetector _buildStepIndication(
      int stepIndex, int currentStep, BuildContext context) {
    final stepperCubit = context.read<StepperCubit>();
    _currentStep = currentStep;
    return GestureDetector(
      onTap: () {
        if (!_formKey1.currentState!.validate()) {
          return;
        } else {
          stepperCubit.goToStep(stepIndex);
        }
      },
      child: Container(
        width: 26.h,
        height: 26.v,
        decoration: currentStep <= stepIndex
            ? BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: AppColor.primary))
            : BoxDecoration(shape: BoxShape.circle, color: AppColor.primary),
        child: Icon(
          Icons.done,
          color: Colors.white,
          size: 15.fSize,
        ),
      ),
    );
  }

  Form _buildBankingDetailsStep(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Form(
      // key: _formKey3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account Number',
            style: textTheme.titleMedium,
          ),
          SizedBox(height: 8.v),
          CustomTextFormField(
            controller: accountNumberController,
            textInputType: TextInputType.number,
            hintText: 'Eg. 12345678901234',
            validator: (value) {
              return validateField(value: value!, title: ' Account Number');
            },
          ),
          SizedBox(height: 16.v),
          Text(
            'IFSC Code',
            style: textTheme.titleMedium,
          ),
          SizedBox(height: 8.v),
          CustomTextFormField(
            controller: ifscCodeController,
            hintText: 'HDFC0005678',
            validator: (value) {
              return validateField(value: value!, title: ' IFSC Code');
            },
          ),
          SizedBox(height: 16.v),
          Text(
            'Branch Name',
            style: textTheme.titleMedium,
          ),
          SizedBox(height: 8.v),
          CustomTextFormField(
            controller: branchController,
            hintText: 'HDFC Bank Pune, Maharashta',
            validator: (value) {
              return validateField(value: value!, title: ' Branch Name');
            },
          ),
          SizedBox(height: 16.v),
          Text(
            'Account Holder Name',
            style: textTheme.titleMedium,
          ),
          SizedBox(height: 8.v),
          CustomTextFormField(
            controller: accountHolderNameController,
            hintText: 'HDFC Bank Pune, Maharashta',
            validator: (value) {
              return validateField(
                  value: value!, title: ' Account Holder Name');
            },
          ),
          SizedBox(height: 16.v),
          Text(
            'Aadhaar/Pan ',
            style: textTheme.titleMedium,
          ),
          SizedBox(height: 8.v),
          CustomTextFormField(
            controller: aadhaarController,
            hintText: 'Upload jpeg',
            suffix: const Icon(Icons.attach_file),
            validator: (value) {
              return validateField(value: value!, title: ' Aadhaar/Pan');
            },
          ),
          SizedBox(height: 16.v),
          Text(
            'Bank Verification ',
            style: textTheme.titleMedium,
          ),
          SizedBox(height: 8.v),
          CustomTextFormField(
            controller: bankVerificationController,
            hintText: 'passbook/cheque',
            suffix: const Icon(Icons.attach_file),
            validator: (value) {
              return validateField(
                value: value!,
                title: ' Bank Verification',
              );
            },
          ),
        ],
      ),
    );
  }
}
