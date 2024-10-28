import 'package:laiza/core/app_export.dart';

class InfluencerCardWidget extends StatelessWidget {
  final int index;

  const InfluencerCardWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.influencerProfileScreen);
      },
      child: Container(
        width: 185.h,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: NetworkImage(imagesList[index])),
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(12.h)),
        child: Padding(
          padding: EdgeInsets.all(8.0.h),
          child: Row(
            children: [
              CustomImageView(
                height: 30.v,
                width: 30.v,
                radius: BorderRadius.circular(20.h),
                imagePath: ImageConstant.reelImg,
              ),
              SizedBox(width: 12.h),
              Text(
                'Daniel George',
                style: TextStyle(color: Colors.white, fontSize: 12.fSize),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
