import 'package:laiza/core/app_export.dart';

import '../../../widgets/influencer_profile_card_widget.dart';

class FollowingScreen extends StatelessWidget {
  const FollowingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Following',
          style: textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0.h),
          child: Column(
            children: [
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: imagesList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 165.h / 140.v,
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.h,
                  mainAxisSpacing: 20.v,
                ),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(AppRoutes.influencerProfileScreen);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.h),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(imagesList[index]))),
                    height: 120.v,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          height: 82.v,
                          width: SizeUtils.width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: AppColor.offWhite),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.h),
                                  topRight: Radius.circular(4.h))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 15.v),
                              Text(
                                'Monica Bellucci',
                                style: textTheme.titleMedium,
                              ),
                              SizedBox(height: 4.v),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomImageView(
                                      imagePath: ImageConstant.groupIcon),
                                  SizedBox(width: 4.v),
                                  Text(
                                    '10K Followers',
                                    style: textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 55.v),
                          child: CustomImageView(
                            width: 60.v,
                            height: 60.v,
                            imagePath: imagesList[index],
                            radius: BorderRadius.circular(90.h),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.v),
              const Divider(),
              SizedBox(height: 14.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Influencer Picks for You',
                    style: textTheme.titleMedium,
                  ),
                  Text(
                    'VIew All',
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
              SizedBox(height: 20.v),
              GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: imagesList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 160.h / 320.v,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.h,
                    mainAxisSpacing: 10.v,
                  ),
                  itemBuilder: (context, index) =>
                      const InfluencerProfileCardWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
