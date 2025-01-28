import 'package:laiza/core/app_export.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  final int userId;
  final String routeName;
  final String email;
  final String authType;

  OtpScreen({
    super.key,
    required this.userId,
    required this.routeName,
    required this.email,
    required this.authType,
  });

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();

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
                'Enter Verification Code ',
                style: textTheme.titleLarge,
              ),
              SizedBox(height: 12.v),
              // Text(
              //   'Enter OTP sent on User144@email.com',
              //   style: textTheme.titleMedium,
              // ),
              SizedBox(height: 8.v),
              _pinInputFiled(context),
              TextButton(
                onPressed: () {
                  context
                      .read<OtpScreenBloc>()
                      .add(OtpResnetEvent(userId: userId, email));
                },
                child: Text(
                  'Resend  OTP',
                  style: textTheme.titleMedium!
                      .copyWith(decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(height: 24.v),
            ],
          ),
        ),
      ),
      bottomSheet: BlocConsumer<OtpScreenBloc, OtpScreenState>(
        listener: (context, state) {
          if (state is OtpScreenErrorState) {
            context.showSnackBar(state.message);
          } else if (state is OtpResentSuccessState) {
            context.showSnackBar(state.message);
          } else if (state is OtpScreenSuccessState) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                routeName, arguments: email, (route) => false);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20.h),
            child: CustomElevatedButton(
              isLoading: state is OtpScreenScreenLoadingState,
              text: 'Continue',
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                } else {
                  context.read<OtpScreenBloc>().add(OtpSubmitEvent(
                        email: email,
                        otp: _otpController.text.trim(),
                        authType: authType,
                      ));
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _pinInputFiled(BuildContext context) {
    return Center(
      child: Pinput(
        length: 4,
        defaultPinTheme: const PinTheme(
          width: 56,
          height: 56,
          textStyle: TextStyle(
            fontSize: 22,
            color: Colors.black,
          ),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey)),
          ),
        ),
        onCompleted: (pin) {
          context.read<OtpScreenBloc>().add(OtpSubmitEvent(
              email: email,
              otp: _otpController.text.trim(),
              authType: authType));
        },
        onChanged: (pin) {
          _otpController.text = pin;
        },
      ),
    );
  }
}
