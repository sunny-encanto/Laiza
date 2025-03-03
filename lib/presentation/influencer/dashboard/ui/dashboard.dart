import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/user/user_model.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Dashboard',
          style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocProvider(
              create: (context) =>
                  ProfileApiBloc(context.read<UserRepository>()),
              child: BlocBuilder<ProfileApiBloc, ProfileApiState>(
                builder: (context, state) {
                  if (state is ProfileApiInitial) {
                    context.read<ProfileApiBloc>().add(FetchProfileApi());
                    return const SizedBox.shrink();
                  } else if (state is ProfileApiLoadingState) {
                    return const SizedBox.shrink();
                  } else if (state is ProfileApiError) {
                    return Text(state.message);
                  } else if (state is ProfileApiLoadedState) {
                    UserModel user = state.userModel;
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(8.0.h),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5.h),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(100.h),
                              ),
                              child: CustomImageView(
                                radius: BorderRadius.circular(100.h),
                                width: 68.v,
                                height: 68.v,
                                fit: BoxFit.fill,
                                imagePath: user.profileImg,
                              ),
                            ),
                            SizedBox(width: 4.v),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name ?? '',
                                  style: textTheme.titleMedium,
                                ),
                                SizedBox(height: 4.v),
                                Text(
                                  '${user.followersCount ?? 0} Followers',
                                  style: textTheme.bodySmall,
                                ),
                              ],
                            ),
                            const Spacer(),
                            CustomIconButton(
                                icon: ImageConstant.request,
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      AppRoutes.connectionsRequestScreen);
                                }),
                          ],
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Upcoming Live Streams',
                        style: textTheme.titleMedium,
                      ),
                      Text(
                        'View All',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.v),
                  Column(
                    children: List.generate(
                      3,
                      (index) => Padding(
                        padding: EdgeInsets.only(bottom: 12.v),
                        child: Row(
                          children: [
                            CustomImageView(
                              height: 80.v,
                              width: 80.h,
                              radius: BorderRadius.circular(6.h),
                              imagePath: ImageConstant.productImage,
                            ),
                            SizedBox(width: 8.h),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "Chic & Timeless: Lavora's Signature Handbag Collection",
                                    style: textTheme.titleMedium,
                                  )
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "live in",
                                  style: textTheme.bodySmall,
                                ),
                                Text("04H: 35M: 28S",
                                    style: textTheme.titleMedium)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.v),
                  Text(
                    'Profile Analytics',
                    style: textTheme.titleMedium,
                  ),
                  SizedBox(height: 12.v),
                  SizedBox(
                    height: 55.v,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Container(
                        margin: EdgeInsets.only(right: 20.h),
                        width: 144.h,
                        decoration: BoxDecoration(color: AppColor.offWhite),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Follower Growth',
                              style: textTheme.bodySmall,
                            ),
                            Text(
                              '450',
                              style: textTheme.bodySmall!
                                  .copyWith(color: AppColor.greenColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.v),
                  Text(
                    ' Top-Performing Content',
                    style: textTheme.titleMedium,
                  ),
                  SizedBox(height: 12.v),
                  _postView(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _postView(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: List.generate(
        3,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: 20.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                width: SizeUtils.width,
                height: 261.v,
                fit: BoxFit.fill,
                // radius: BorderRadius.only(
                //     topRight: Radius.circular(12.h),
                //     topLeft: Radius.circular(12.h)),
                imagePath: ImageConstant.productImage,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.v),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Icon(
                          Icons.favorite_border,
                          color: Colors.grey,
                        ),
                        Text(
                          '52.3K',
                          style: textTheme.bodySmall,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        CustomImageView(
                          height: 20.v,
                          width: 20.v,
                          imagePath: ImageConstant.commentIcon,
                          color: Colors.grey,
                        ),
                        Text(
                          '380',
                          style: textTheme.bodySmall,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        CustomImageView(
                          width: 25.h,
                          imagePath: ImageConstant.visibilityIcon,
                          color: Colors.grey,
                        ),
                        Text(
                          '680',
                          style: textTheme.bodySmall,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  CustomImageView(
                    height: 100.v,
                    width: 100.h,
                    imagePath: ImageConstant.graph,
                  ),
                  SizedBox(width: 20.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Engagement Rate:8.2%',
                              style: textTheme.bodySmall),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Account Reach: 49K',
                              style: textTheme.bodySmall),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Followers Growth: 8K',
                              style: textTheme.bodySmall),
                        ],
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
    // GridView.builder(
    //   shrinkWrap: true,
    //   physics: const NeverScrollableScrollPhysics(),
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       mainAxisSpacing: 5.v,
    //       crossAxisSpacing: 5.h,
    //       childAspectRatio: 120.h / 269.v,
    //       crossAxisCount: 2),
    //   itemBuilder: (context, index) =>
    //   Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       CustomImageView(
    //         height: 261.v,
    //         fit: BoxFit.fill,
    //         radius: BorderRadius.only(
    //             topRight: Radius.circular(12.h),
    //             topLeft: Radius.circular(12.h)),
    //         imagePath: ImageConstant.productImage,
    //       ),
    //       Padding(
    //         padding: EdgeInsets.all(5.h),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Column(
    //               children: [
    //                 const Icon(
    //                   Icons.favorite_border,
    //                   color: Colors.grey,
    //                 ),
    //                 Text(
    //                   '52.3K',
    //                   style: textTheme.bodySmall,
    //                 )
    //               ],
    //             ),
    //             Column(
    //               children: [
    //                 CustomImageView(
    //                   height: 20.v,
    //                   width: 20.v,
    //                   imagePath: ImageConstant.commentIcon,
    //                   color: Colors.grey,
    //                 ),
    //                 Text(
    //                   '380',
    //                   style: textTheme.bodySmall,
    //                 )
    //               ],
    //             ),
    //             Column(
    //               children: [
    //                 CustomImageView(
    //                   width: 25.h,
    //                   imagePath: ImageConstant.visibilityIcon,
    //                   color: Colors.grey,
    //                 ),
    //                 Text(
    //                   '680',
    //                   style: textTheme.bodySmall,
    //                 )
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //       Row(
    //         children: [
    //           CustomImageView(
    //             height: 44.v,
    //             width: 44.h,
    //             imagePath: ImageConstant.graph,
    //           ),
    //           Column(
    //             children: [
    //               Row(
    //                 children: [
    //                   Text(
    //                     'Engagement Rate:8.2%',
    //                     style:
    //                         textTheme.bodySmall!.copyWith(fontSize: 10.fSize),
    //                   )
    //                 ],
    //               )
    //             ],
    //           )
    //         ],
    //       )
    //     ],
    //   ),

    // );
  }
}
