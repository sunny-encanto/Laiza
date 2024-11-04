import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/live_stream_model.dart/live_stream_model.dart';
import 'package:laiza/data/services/firebase_services.dart';

import '../../../widgets/slider_widget.dart';
import '../../../widgets/streams_card_widget.dart';

class LiveScreen extends StatelessWidget {
  const LiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: customAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 16.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Followed Influencer',
                style: textTheme.titleLarge,
              ),
              SizedBox(height: 20.v),
              SizedBox(
                  height: 114.v,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(left: 8.h),
                      child: profileWidget(context),
                    ),
                  )),
              SizedBox(height: 28.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ongoing Streams',
                    style: textTheme.titleLarge,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.allOngoingStreamsScreen);
                    },
                    child: Text(
                      'View All',
                      style: textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 28.v),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseServices.getOnGoingLiveStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox.shrink();
                    }
                    var snapShotData = snapshot.data?.docs ?? [];
                    List<LiveStreamModel> liveStreamModel = snapShotData
                        .map((e) => LiveStreamModel.fromMap(
                            e.data() as Map<String, dynamic>))
                        .toList();
                    return SizedBox(
                      height: liveStreamModel.isNotEmpty ? 250.v : 0.v,
                      child: ListView.builder(
                        itemCount: liveStreamModel.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(right: 10.h),
                          child: StreamsCard(
                            model: liveStreamModel[index],
                          ),
                        ),
                      ),
                    );
                  }),
              SizedBox(height: 36.v),
              Text(
                'Upcoming Streams',
                style: textTheme.titleLarge,
              ),
              SizedBox(height: 20.v),
              SizedBox(
                child: customSlider(height: 186.h, childList: [
                  _buildUpComingStreamCardRed(),
                  _buildUpComingStreamCardGreen()
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildUpComingStreamCardGreen() {
    return CustomImageView(
      margin: EdgeInsets.symmetric(horizontal: 2.h),
      radius: BorderRadius.circular(12.h),
      imagePath: ImageConstant.sliderImageGreen,
    );
  }

  _buildUpComingStreamCardRed() {
    return CustomImageView(
      margin: EdgeInsets.symmetric(horizontal: 2.h),
      radius: BorderRadius.circular(12.h),
      imagePath: ImageConstant.sliderImageRed,
    );
    // Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 8.h),
    //   child: Stack(
    //     clipBehavior: Clip.hardEdge,
    //     alignment: Alignment.topRight,
    //     children: [
    //       Container(
    //         width: SizeUtils.width,
    //         height: 186.v,
    //         decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(12.h),
    //           gradient: const LinearGradient(
    //             begin: Alignment.centerLeft,
    //             end: Alignment.centerRight,
    //             colors: [
    //               Color(0xFFFDC878),
    //               Color(0xFFFF8E56),
    //             ],
    //             stops: [0.0, 0.8627],
    //           ),
    //         ),
    //         child: Padding(
    //           padding:
    //               EdgeInsets.symmetric(vertical: 8.0.v, horizontal: 10.0.h),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               SizedBox(height: 15.v),
    //               Text(
    //                 'Unlock Exclusive Deals on GlowGenix\n Skincare—Live with Sharvari',
    //                 style: GoogleFonts.roboto(
    //                   color: AppColor.brownColor,
    //                   fontSize: 12.fSize,
    //                   fontWeight: FontWeight.w600,
    //                 ),
    //               ),
    //               SizedBox(height: 16.v),
    //               Text(
    //                   'Get ready for exclusive deals and live\n interaction—starting in  2h 15m  ',
    //                   style: GoogleFonts.roboto(
    //                     color: AppColor.brownColor,
    //                     fontSize: 12.fSize,
    //                     fontWeight: FontWeight.w600,
    //                   )),
    //               SizedBox(height: 14.v),
    //               CustomElevatedButton(
    //                 text: 'Notify me',
    //                 width: 128.h,
    //                 height: 21.v,
    //                 buttonTextStyle: TextStyle(fontSize: 10.fSize),
    //               )
    //             ],
    //           ),
    //         ),
    //       ),
    //       CustomImageView(
    //         radius: BorderRadius.only(topRight: Radius.circular(12.h)),
    //         imagePath: ImageConstant.music,
    //       ),
    //       Positioned(
    //         right: 90.h,
    //         top: 100.v,
    //         child: CustomImageView(
    //           height: 80.v,
    //           imagePath: ImageConstant.giftBox,
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //       Padding(
    //         padding: EdgeInsets.only(right: 30.h),
    //         child: CustomImageView(
    //           height: 186.v,
    //           imagePath: ImageConstant.bannerGirl,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  Widget profileWidget(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Outer colored border
              Container(
                width: 82.h,
                height: 82.v,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red,
                      Colors.blue,
                      Colors.green,
                      Colors.yellow,
                    ],
                    stops: [0.0, 0.3, 0.7, 1.0],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              // Inner content
              Container(
                width: 75.v,
                height: 75.v,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: CustomImageView(
                  radius: BorderRadius.circular(82.h),
                  width: 82.h,
                  height: 82.v,
                  imagePath: ImageConstant.reelImg,
                ),
              ),
              Positioned(
                bottom: -5.v,
                child: Container(
                  width: 42.h,
                  height: 19.v,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: const Color(0xFFFF4365),
                      borderRadius: BorderRadius.circular(10.h)),
                  child: Text(
                    'Live',
                    style: TextStyle(color: Colors.white, fontSize: 12.fSize),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'Name ',
            style: textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
