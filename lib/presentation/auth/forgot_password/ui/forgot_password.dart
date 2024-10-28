import '../../../../core/app_export.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.translate('find_your_account'),
                style: textTheme.titleLarge,
              ),
              SizedBox(height: 4.v),
              Text(
                context.translate('entered_your_registered'),
                style: textTheme.bodySmall,
              ),
              SizedBox(height: 12.v),
              Text(
                context.translate('email/phone'),
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
              SizedBox(height: 12.v),
              Text(
                context.translate('you_may_receive_email'),
                style: textTheme.bodySmall!.copyWith(fontSize: 12.fSize),
              ),
              SizedBox(height: 24.v),
              BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
                listener: (context, state) {
                  if (state is ForgotPasswordSuccessState) {
                    Navigator.of(context)
                        .pushNamed(AppRoutes.changePasswordScreen);
                  }
                },
                builder: (context, state) {
                  return CustomElevatedButton(
                    isLoading: state is ForgotPasswordLoadingState,
                    text: context.translate('continue'),
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      } else {
                        context.read<ForgotPasswordBloc>().add(
                            ForgotPasswordSubmitRequest(emailController.text));
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
