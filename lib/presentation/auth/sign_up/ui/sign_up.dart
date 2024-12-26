// ignore_for_file: must_be_immutable

import 'package:laiza/core/app_export.dart';
import 'package:laiza/presentation/auth/sign_up/bloc/sign_up_states.dart';

import '../../../../core/utils/pref_utils.dart';
import '../../../../data/repositories/auth_repository/auth_repository.dart';
import '../../login/ui/socail_login_widget.dart';
import '../bloc/sign_up_event.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final reEnterpasswordController = TextEditingController();
  bool _isPasswordVisible = true;
  bool _isConfirmPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    print('Role=> ${PrefUtils.getRole()}');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: BlocListener<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state is SignUpErrorState) {
                context.showSnackBar(state.message);
              } else if (state is SignUpSuccessStates) {
                context.showSnackBar(state.message);
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.otpScreen, arguments: {
                  'id': state.userId,
                  'routeName': PrefUtils.getRole() == UserRole.influencer.name
                      ? AppRoutes.influencerFormScreen
                      : AppRoutes.bottomBarScreen,
                  'email': emailController.text.trim(),
                  'authType': 'signUp'
                });
              }
            },
            child: Form(
              key: _formkey,
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          context.translate('createAccount'),
                          style: textTheme.titleLarge,
                        ),
                        SizedBox(height: 16.v),
                        Text(
                          context.translate('welcomeMessage'),
                          style: textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16.v),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            context.translate('nameField'),
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
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            context.translate('email'),
                            style: textTheme.titleMedium,
                          ),
                        ),
                        SizedBox(height: 8.v),
                        CustomTextFormField(
                          controller: emailController,
                          hintText: 'example@gmail.com',
                          validator: (value) {
                            return validateEmail(value!);
                          },
                        ),
                        SizedBox(height: 16.v),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            context.translate('password'),
                            style: textTheme.titleMedium,
                          ),
                        ),
                        SizedBox(height: 8.v),
                        BlocConsumer<SignUpBloc, SignUpState>(
                          buildWhen: (previous, current) =>
                              current is TogglePasswordVisibleState,
                          listener: (context, state) {
                            if (state is TogglePasswordVisibleState) {
                              _isPasswordVisible = state.isVisible;
                            }
                          },
                          builder: (context, state) {
                            return CustomTextFormField(
                              controller: passwordController,
                              obscureText: _isPasswordVisible,
                              hintText: '**********',
                              suffix: InkWell(
                                child: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                                onTap: () {
                                  context.read<SignUpBloc>().add(
                                      TogglePasswordVisibility(
                                          isVisible: _isPasswordVisible));
                                },
                              ),
                              validator: (value) {
                                return validatePassword(value!);
                              },
                            );
                          },
                        ),
                        SizedBox(height: 16.v),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            context.translate('reEnterPasswordField'),
                            style: textTheme.titleMedium,
                          ),
                        ),
                        SizedBox(height: 8.v),
                        BlocConsumer<SignUpBloc, SignUpState>(
                          buildWhen: (previous, current) =>
                              current is ToggleReInterPasswordVisibleState,
                          listener: (context, state) {
                            if (state is ToggleReInterPasswordVisibleState) {
                              _isConfirmPasswordVisible = state.isVisible;
                            }
                          },
                          builder: (context, state) {
                            return CustomTextFormField(
                              controller: reEnterpasswordController,
                              obscureText: _isConfirmPasswordVisible,
                              hintText: '**********',
                              suffix: InkWell(
                                child: Icon(
                                  _isConfirmPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                                onTap: () {
                                  context.read<SignUpBloc>().add(
                                      ToggleReEnterPasswordVisibility(
                                          isVisible:
                                              _isConfirmPasswordVisible));
                                },
                              ),
                              validator: (value) {
                                return validateAndMatchPassword(
                                    password: value!,
                                    reEnteredPassword: passwordController.text);
                              },
                            );
                          },
                        ),
                        SizedBox(height: 28.v),
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            return CustomElevatedButton(
                                text: context.translate('sign_up'),
                                isLoading: state is SignUpLoadingState,
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  if (!_formkey.currentState!.validate()) {
                                    return;
                                  } else {
                                    context.read<SignUpBloc>().add(
                                          SignUpButtonPressed(
                                              name: nameController.text.trim(),
                                              email:
                                                  emailController.text.trim(),
                                              password: passwordController.text
                                                  .trim(),
                                              userType: PrefUtils.getRole()),
                                        );
                                  }
                                });
                          },
                        ),
                        SizedBox(height: 32.v),
                        Row(
                          children: [
                            const Expanded(child: Divider()),
                            Text(context.translate('orSignUpWith'),
                                style: textTheme.bodySmall),
                            const Expanded(child: Divider()),
                          ],
                        ),
                        SizedBox(height: 32.v),
                        BlocProvider(
                          create: (context) =>
                              LoginBloc(context.read<AuthRepository>()),
                          child: const SocialLoginWidgets(),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(10.0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.translate('alreadyHaveAccount'),
              style: textTheme.bodySmall?.copyWith(fontSize: 16.fSize),
            ),
            SizedBox(width: 2.h),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.signInScreen);
              },
              child: Text(
                context.translate('sign_in'),
                style: textTheme.titleMedium
                    ?.copyWith(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
