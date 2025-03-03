import '../../../../core/app_export.dart';
import '../../../../core/utils/pref_utils.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';

class SocialLoginWidgets extends StatelessWidget {
  const SocialLoginWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          context.showSnackBar(state.message);
        } else if (state is SocialLoginSuccessState) {
          if (PrefUtils.getRole() == UserRole.user.name) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.bottomBarScreen,
              (route) => false,
            );
          } else {
            if (state.isSignUp) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.influencerFormScreen,
                (route) => false,
              );
            } else {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRoutes.homeScreen,
                (route) => false,
              );
            }
          }
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // CustomImageView(
          //   onTap: () {
          //     Navigator.of(context).pushNamed(AppRoutes.logInWithPhoneScreen);
          //   },
          //   imagePath: ImageConstant.phoneAuth,
          // ),
          SizedBox(width: 18.v),
          BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (previous, current) => false,
            builder: (context, state) {
              return CustomImageView(
                onTap: () {
                  context.read<LoginBloc>().add(LoginWithGoggleEvent());
                },
                imagePath: ImageConstant.googleAuth,
              );
            },
          ),
          SizedBox(width: 18.v),
          BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (previous, current) => false,
            builder: (context, state) {
              return CustomImageView(
                onTap: () {
                  context.read<LoginBloc>().add(LoginWithAppleEvent());
                },
                imagePath: ImageConstant.appleAuth,
              );
            },
          ),
        ],
      ),
    );
  }
}
