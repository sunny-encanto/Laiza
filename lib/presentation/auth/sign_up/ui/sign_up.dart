import 'package:laiza/core/app_export.dart';
import 'package:laiza/core/utils/pref_utils.dart';
import 'package:laiza/presentation/auth/sign_up/bloc/sign_up_states.dart';
import 'package:laiza/presentation/select_role/ui/select_role.dart';

import '../../login/ui/socail_login_widget.dart';
import '../bloc/sign_up_event.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final _formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final reEnterpasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: BlocListener<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state.isFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('SignUp Failed')),
                );
              } else if (state.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('SignUp Successful')),
                );
                if (PrefUtils.getRole() == UserRole.Influencer.name) {
                  Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.influencerFormScreen);
                } else {
                  Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.successScreen);
                }
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
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            return CustomTextFormField(
                              controller: passwordController,
                              obscureText: !state.isPasswordVisible,
                              hintText: '**********',
                              suffix: InkWell(
                                child: Icon(
                                  state.isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onTap: () {
                                  context
                                      .read<SignUpBloc>()
                                      .add(TogglePasswordVisibility());
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
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            return CustomTextFormField(
                              controller: reEnterpasswordController,
                              obscureText: !state.isReEnterPasswordVisible,
                              hintText: '**********',
                              suffix: InkWell(
                                child: Icon(
                                  state.isReEnterPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onTap: () {
                                  context
                                      .read<SignUpBloc>()
                                      .add(ToggleReEnterPasswordVisibility());
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
                                isLoading: state.isSubmitting,
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  if (!_formkey.currentState!.validate()) {
                                    return;
                                  } else {
                                    context.read<SignUpBloc>().add(
                                          SignUpButtonPressed(
                                            state.email,
                                            state.password,
                                          ),
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
                          create: (context) => LoginBloc(),
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
