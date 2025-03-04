import '../../../../core/app_export.dart';

// ignore: must_be_immutable
class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final reEnterPasswordController = TextEditingController();
  bool _isNewPasswordVisible = false;
  bool _isCurrentPasswordVisible = false;
  bool _isReEnteredPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.translate('changePassword'),
                style: textTheme.titleLarge,
              ),
              Text(
                context.translate('createNewPassword'),
                style: textTheme.bodySmall,
              ),
              SizedBox(height: 12.v),
              Text(
                'Enter Current password',
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 8.v),
              BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
                listener: (context, state) {
                  if (state is CurrentPasswordToggleState) {
                    _isCurrentPasswordVisible = state.isVisible;
                  }
                },
                builder: (context, state) {
                  return CustomTextFormField(
                    controller: currentPasswordController,
                    obscureText: !_isCurrentPasswordVisible,
                    hintText: '**********',
                    suffix: InkWell(
                      child: Icon(
                        _isCurrentPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        _isCurrentPasswordVisible = !_isCurrentPasswordVisible;
                        context.read<ChangePasswordBloc>().add(
                            CurrentPasswordToggle(_isCurrentPasswordVisible));
                      },
                    ),
                    validator: (value) {
                      return validatePassword(value!);
                    },
                  );
                },
              ),
              SizedBox(height: 12.v),
              Text(
                context.translate('enterNewPassword'),
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 8.v),
              BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
                listener: (context, state) {
                  if (state is NewPasswordToggleState) {
                    _isNewPasswordVisible = state.isVisible;
                  }
                },
                builder: (context, state) {
                  return CustomTextFormField(
                    controller: passwordController,
                    obscureText: !_isNewPasswordVisible,
                    hintText: '**********',
                    suffix: InkWell(
                      child: Icon(
                        _isNewPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        _isNewPasswordVisible = !_isNewPasswordVisible;
                        context
                            .read<ChangePasswordBloc>()
                            .add(NewPasswordToggle(_isNewPasswordVisible));
                      },
                    ),
                    validator: (value) {
                      return validatePassword(value!);
                    },
                  );
                },
              ),
              SizedBox(height: 12.v),
              Text(
                context.translate('reEnterPassword'),
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 8.v),
              BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
                listener: (context, state) {
                  if (state is ReEnterNewPasswordToggleState) {
                    _isReEnteredPasswordVisible = state.isVisible;
                  }
                },
                builder: (context, state) {
                  return CustomTextFormField(
                    controller: reEnterPasswordController,
                    obscureText: !_isReEnteredPasswordVisible,
                    hintText: '**********',
                    suffix: InkWell(
                      child: Icon(
                        _isReEnteredPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onTap: () {
                        _isReEnteredPasswordVisible =
                            !_isReEnteredPasswordVisible;
                        context.read<ChangePasswordBloc>().add(
                            ReEnteredNewPasswordToggle(
                                _isReEnteredPasswordVisible));
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
              SizedBox(height: 24.v),
              BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
                listener: (context, state) {
                  if (state is ChangePasswordSuccess) {
                    context.showSnackBar(state.message);
                    Navigator.of(context).pop();
                  } else if (state is ChangePasswordError) {
                    context.showSnackBar(state.message);
                  }
                },
                builder: (context, state) {
                  return CustomElevatedButton(
                    isLoading: state is ChangePasswordLoading,
                    text: context.translate('continue'),
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      } else {
                        context.read<ChangePasswordBloc>().add(
                            ChangePasswordSubmitRequest(
                                newPassword: passwordController.text,
                                password: currentPasswordController.text));
                      }
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
