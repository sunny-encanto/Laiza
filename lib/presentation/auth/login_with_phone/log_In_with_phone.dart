import 'package:laiza/presentation/auth/login/bloc/login_state.dart';

import '../../../core/app_export.dart';
import '../login/bloc/login_event.dart';

class LogInWithPhoneScreen extends StatelessWidget {
  LogInWithPhoneScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Log In with Phone Number',
                style: textTheme.titleLarge,
              ),
              SizedBox(height: 4.v),
              Text(
                'Quick and secure access to your account',
                style: textTheme.bodySmall,
              ),
              SizedBox(height: 12.v),
              Text(
                'Phone number',
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 8.v),
              CustomTextFormField(
                controller: _phoneController,
                hintText: 'Eg. 8456332145',
                maxLength: 10,
                counter: const Text(''),
                textInputType: TextInputType.number,
                validator: (value) {
                  return validatePhoneNumber(value!);
                },
              ),
              SizedBox(height: 12.v),
              Text(
                'You may receive a verification email form us for security and login purpose.',
                style: textTheme.bodySmall!.copyWith(fontSize: 12.fSize),
              ),
              SizedBox(height: 24.v),
              BlocConsumer<LoginBloc, LoginState>(
                buildWhen: (previous, current) => previous != current,
                listener: (context, state) {
                  if (state is LoginSuccessState) {
                    Navigator.of(context).pushNamed(AppRoutes.otpScreen,
                        arguments: {
                          'id': state.userId,
                          'routeName': '',
                          'email': ''
                        });
                  } else {
                    if (state is LoginError) {
                      context.showSnackBar(state.message);
                    }
                  }
                },
                builder: (context, state) {
                  return CustomElevatedButton(
                    isLoading: state is LoginLoading,
                    text: 'Continue',
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      } else {
                        context.read<LoginBloc>().add(
                              LoginWithPhoneEvent(_phoneController.text),
                            );
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
