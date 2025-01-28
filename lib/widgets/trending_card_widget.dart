import 'package:laiza/core/app_export.dart';
import 'package:laiza/widgets/play_button.dart';

class TrendingCardWidget extends StatelessWidget {
  final int index;
  final double extent;

  const TrendingCardWidget(
      {super.key, required this.index, required this.extent});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 123.h,
          height: extent,
          margin: EdgeInsets.all(1.0.h),
          color: Colors.grey,
          child: CustomImageView(
            imagePath: imagesList[index],
            fit: BoxFit.fitHeight,
          ),
        ),
        PlayButton(isVisible: index.isOdd)
      ],
    );
  }
}
