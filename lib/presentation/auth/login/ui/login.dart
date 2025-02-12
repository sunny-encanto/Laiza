import 'package:laiza/core/app_export.dart';
import 'package:laiza/presentation/auth/login/bloc/login_state.dart';
import 'package:laiza/presentation/auth/login/ui/socail_login_widget.dart';

import '../../../../core/utils/pref_utils.dart';
import '../bloc/login_event.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocProvider(
          create: (BuildContext context) =>
              LoginBloc(context.read<AuthRepository>()),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    context.translate('sign_in'),
                    style: textTheme.titleLarge,
                  ),
                  SizedBox(height: 16.v),
                  Text(
                    context.translate('Log_in_to_shop'),
                    style: textTheme.bodySmall,
                    textAlign: TextAlign.center,
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
                    controller: _emailController,
                    hintText: context.translate('example@gmail.com'),
                    validator: (String? value) {
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
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (BuildContext context, LoginState state) {
                      if (state is LoginPasswordToggleState) {
                        _isPasswordVisible = state.isVisible;
                      }
                    },
                    builder: (BuildContext context, state) {
                      return CustomTextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        hintText: '**********',
                        suffix: InkWell(
                          child: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onTap: () {
                            _isPasswordVisible = !_isPasswordVisible;
                            context.read<LoginBloc>().add(
                                TogglePasswordVisibility(_isPasswordVisible));
                          },
                        ),
                        validator: (String? value) {
                          return validatePassword(value!);
                        },
                      );
                    },
                  ),
                  SizedBox(height: 16.v),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.forgotPasswordScreen);
                      },
                      child: Text(
                        context.translate('forgot_password'),
                        style: textTheme.titleMedium
                            ?.copyWith(decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  SizedBox(height: 28.v),
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (BuildContext context, state) {
                      if (state is LoginError) {
                        context.showSnackBar(state.message);
                      } else if (state is LoginSuccessState) {
                        if (PrefUtils.getRole() == UserRole.user.name) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.bottomBarScreen,
                            (route) => false,
                          );
                        } else {
                          if (state.isProfileComplete) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRoutes.homeScreen,
                              (route) => false,
                            );
                          } else {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRoutes.influencerFormScreen,
                              (route) => false,
                            );
                          }
                        }
                      } else if (state is LoginUserNotApproved) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.successScreen,
                          (route) => false,
                        );
                      }
                    },
                    builder: (BuildContext context, state) {
                      return CustomElevatedButton(
                          text: context.translate('sign_in'),
                          isLoading: state is LoginLoading,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (!_formKey.currentState!.validate()) {
                              return;
                            } else {
                              context.read<LoginBloc>().add(
                                    LoginButtonPressed(
                                      _emailController.text,
                                      _passwordController.text,
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
                      Text(context.translate('or_sign_in_with'),
                          style: textTheme.bodySmall),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  SizedBox(height: 32.v),
                  const SocialLoginWidgets(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.translate('don’t_have_an_account'),
              style: textTheme.bodySmall?.copyWith(fontSize: 16.fSize),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.signUpScreen);
              },
              child: Text(
                context.translate('sign_up'),
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
