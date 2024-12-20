import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/services/firebase_services.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 8.v),
          Column(
            children: [
              CustomImageView(
                imagePath: ImageConstant.success,
              ),
              SizedBox(height: 23.v),
              Padding(
                padding: EdgeInsets.all(5.0.h),
                child: Text(
                  'Your details have been received successfully!!',
                  textAlign: TextAlign.center,
                  style: textTheme.titleLarge!
                      .copyWith(color: AppColor.greenColor),
                ),
              ),
              SizedBox(height: 23.v),
              Text(
                'Thank You!!!',
                textAlign: TextAlign.center,
                style: textTheme.titleLarge,
              ),
              SizedBox(height: 8.v),
              Text(
                'We will be back to you once we are live!!',
                textAlign: TextAlign.center,
                style: textTheme.bodySmall,
              ),
            ],
          ),
          SizedBox(height: 8.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.h),
            child: CustomOutlineButton(
              text: 'Close',
              onPressed: () {
                FirebaseServices.handleLogOut(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
