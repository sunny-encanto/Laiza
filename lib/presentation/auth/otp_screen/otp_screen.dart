import 'package:laiza/core/app_export.dart';
import 'package:laiza/presentation/auth/login/bloc/login_event.dart';
import 'package:laiza/presentation/auth/login/bloc/login_state.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

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
                'Enter OTP',
                style: textTheme.titleLarge,
              ),
              SizedBox(height: 12.v),
              Text(
                'Enter OTP',
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 8.v),
              CustomTextFormField(
                controller: _otpController,
                hintText: '**********',
                maxLength: 6,
                counter: const Text(''),
                validator: (value) {
                  return validateField(value: value!, title: 'otp');
                },
              ),
              SizedBox(height: 24.v),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccessState) {
                    // Navigator.of(context).pushNamed(AppRoutes.homeScreen);
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
                        context
                            .read<LoginBloc>()
                            .add(VerifyOtpEvent(_otpController.text));
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
