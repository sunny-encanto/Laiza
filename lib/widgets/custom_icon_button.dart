import 'package:laiza/core/app_export.dart';

// ignore: must_be_immutable
class CustomIconButton extends StatelessWidget {
  CustomIconButton(
      {super.key,
      required this.icon,
      required this.onTap,
      this.color,
      this.iconColor});

  final String icon;
  void Function()? onTap;
  final Color? color;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15.v),
        height: 50.h,
        width: 50.h,
        decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(12)),
        child: CustomImageView(
          fit: BoxFit.fill,
          height: 23.h,
          width: 23.h,
          imagePath: icon,
          color: iconColor,
        ),
      ),
    );
  }
}
