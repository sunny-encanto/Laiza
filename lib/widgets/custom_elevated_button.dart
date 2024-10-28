import 'package:laiza/core/app_export.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'base_button.dart';

class CustomElevatedButton extends BaseButton {
  const CustomElevatedButton({
    super.key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    super.margin,
    super.onPressed,
    super.buttonStyle,
    super.alignment,
    super.buttonTextStyle,
    super.isDisabled,
    super.height,
    super.width,
    super.isLoading,
    required super.text,
    this.backgroundColor,
  });

  final BoxDecoration? decoration;

  final Widget? leftIcon;

  final Widget? rightIcon;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildElevatedButtonWidget,
          )
        : buildElevatedButtonWidget;
  }

  Widget get buildElevatedButtonWidget => Container(
        height: height ?? 50.v,
        width: width ?? double.maxFinite,
        margin: margin,
        decoration: decoration,
        child: ElevatedButton(
          style: buttonStyle ??
              ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor ?? AppColor.primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.h))),
          onPressed: isDisabled ?? false ? null : onPressed ?? () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leftIcon ?? const SizedBox.shrink(),
              (isLoading ?? false)
                  ? Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.white,
                      size: 30,
                    ))
                  : Padding(
                      padding:
                          EdgeInsets.only(left: leftIcon == null ? 0 : 10.h),
                      child: Text(
                        text,
                        style: buttonTextStyle ??
                            TextStyle(
                                fontSize: 18.0.fSize,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                      ),
                    ),
              rightIcon ?? const SizedBox.shrink(),
            ],
          ),
        ),
      );
}

class CustomOutlineButton extends BaseButton {
  const CustomOutlineButton({
    super.key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    super.margin,
    super.onPressed,
    super.buttonStyle,
    super.alignment,
    super.buttonTextStyle,
    super.isDisabled,
    super.height,
    super.width,
    super.isLoading,
    required super.text,
  });

  final BoxDecoration? decoration;

  final Widget? leftIcon;

  final Widget? rightIcon;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildElevatedButtonWidget,
          )
        : buildElevatedButtonWidget;
  }

  Widget get buildElevatedButtonWidget => Container(
        height: height ?? 50.v,
        width: width ?? double.maxFinite,
        margin: margin,
        decoration: decoration,
        child: ElevatedButton(
          style: buttonStyle ??
              ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(24.h))),
          onPressed: isDisabled ?? false ? null : onPressed ?? () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leftIcon ?? const SizedBox.shrink(),
              (isLoading ?? false)
                  ? Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.white,
                      size: 30,
                    ))
                  : Text(
                      text,
                      style: buttonTextStyle ??
                          TextStyle(
                              fontSize: 18.0.fSize,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                    ),
              rightIcon ?? const SizedBox.shrink(),
            ],
          ),
        ),
      );
}
