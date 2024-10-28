import 'package:laiza/core/app_export.dart';

class TrendingCardWidget extends StatelessWidget {
  final int index;
  final double extent;

  const TrendingCardWidget(
      {super.key, required this.index, required this.extent});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 123.h,
      height: extent,
      margin: EdgeInsets.all(1.0.h),
      color: Colors.blueAccent,
      child: CustomImageView(
        imagePath: imagesList[index],
        fit: BoxFit.fill,
      ),
    );
  }
}
