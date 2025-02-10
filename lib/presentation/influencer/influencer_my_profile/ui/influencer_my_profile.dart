import 'package:laiza/core/app_export.dart';
import 'package:laiza/core/utils/api_constant.dart';
import 'package:laiza/data/blocs/collection_bloc/collection_bloc.dart';
import 'package:laiza/data/models/user/user_model.dart';
import 'package:laiza/data/repositories/collection_repository/collection_repository.dart';
import 'package:laiza/data/repositories/reel_repository/reel_repository.dart';
import 'package:laiza/presentation/shimmers/loading_grid.dart';
import 'package:laiza/presentation/shimmers/loading_list.dart';
import 'package:laiza/widgets/play_button.dart';

import '../../../../data/blocs/my_reel_bloc/my_reel_bloc.dart';
import '../../../../data/services/share.dart';
import '../../../../widgets/custom_popup_menu_button.dart';
import '../../my_reel_view/my_reel_view.dart';

class InfluencerMyProfileScreen extends StatelessWidget {
  InfluencerMyProfileScreen({super.key});

  UserModel _userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 2,
      child: BlocProvider(
        create: (context) => MyReelBloc(context.read<ReelRepository>()),
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  actions: [
                    CustomPopupMenuButton(
                      menuItems: [
                        PopupMenuItem<int>(
                          value: 0,
                          child: Text(
                            'Edit Profile',
                            style: textTheme.titleMedium,
                          ),
                        ),
                      ],
                      onItemSelected: (value) {
                        if (value == 0) {
                          return Navigator.of(context)
                              .pushNamed(AppRoutes.editProfileScreen);
                        }
                      },
                    )
                  ],
                  iconTheme: const IconThemeData(color: Colors.black),
                  pinned: true,
                  bottom: PreferredSize(
                      preferredSize: Size(SizeUtils.width, 60.v),
                      child: Container(
                        color: Colors.white,
                        child: TabBar(
                            indicatorColor: AppColor.primary,
                            labelColor: AppColor.primary,
                            tabs: const [
                              Tab(
                                text: 'Post',
                              ),
                              Tab(
                                text: 'Product',
                              ),
                            ]),
                      )),
                  backgroundColor: Colors.white,
                  expandedHeight: SizeUtils.height - 60.v,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomImageView(
                          width: SizeUtils.width,
                          height: 150.v,
                          imagePath: ImageConstant.profileBg,
                        ),
                        _buildProfileCard(context),
                        SizedBox(height: 12.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Fashion & Lifestyle Influencer | Trend Curator 🛍️',
                                style: textTheme.titleMedium,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Every Day Style to make you feel your best believer, mama, runner, ice cream lover ',
                                style: textTheme.bodySmall,
                              ),
                              SizedBox(height: 12.v),
                              Row(
                                children: [
                                  CustomImageView(
                                    onTap: () {
                                      context
                                          .read<InfluencerMyProfileBloc>()
                                          .add(OnInstagramIconTap());
                                    },
                                    height: 36.v,
                                    width: 36.v,
                                    imagePath: ImageConstant.instagram,
                                  ),
                                  SizedBox(width: 24.h),
                                  CustomImageView(
                                    onTap: () {
                                      context
                                          .read<InfluencerMyProfileBloc>()
                                          .add(OnXIconTap());
                                    },
                                    height: 36.v,
                                    width: 36.v,
                                    imagePath: ImageConstant.xIcon,
                                  ),
                                  SizedBox(width: 24.h),
                                  CustomImageView(
                                    onTap: () {
                                      context
                                          .read<InfluencerMyProfileBloc>()
                                          .add(OnFBIconTap());
                                    },
                                    height: 36.v,
                                    width: 36.v,
                                    imagePath: ImageConstant.fb,
                                  ),
                                  SizedBox(width: 24.h),
                                  CustomImageView(
                                    onTap: () {
                                      context
                                          .read<InfluencerMyProfileBloc>()
                                          .add(OnSnapIconTap());
                                    },
                                    height: 36.v,
                                    width: 36.v,
                                    imagePath: ImageConstant.snap,
                                  ),
                                ],
                              ),
                              SizedBox(height: 24.h),
                              BlocProvider(
                                create: (context) => CollectionBloc(
                                    context.read<CollectionRepository>()),
                                child: BlocBuilder<CollectionBloc,
                                    CollectionState>(
                                  builder: (context, state) {
                                    if (state is CollectionInitial) {
                                      context
                                          .read<CollectionBloc>()
                                          .add(FetchCollection());
                                    } else if (state is CollectionLoading) {
                                      return const HorizontalLoadingListPage();
                                    } else if (state is CollectionError) {
                                      return Center(
                                        child: Text(state.message),
                                      );
                                    } else if (state is CollectionLoaded) {
                                      return SizedBox(
                                          height: 185.v,
                                          child: ListView.builder(
                                            itemCount: state.collection.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) =>
                                                index == 0
                                                    ? InkWell(
                                                        onTap: () {
                                                          Navigator.of(context)
                                                              .pushNamed(AppRoutes
                                                                  .createConnectionsScreen);
                                                        },
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: 125.h,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: AppColor
                                                                      .offWhite)),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons.add,
                                                                size: 40.h,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              SizedBox(
                                                                  height: 5.h),
                                                              const Text(
                                                                  'Add New \nCollection')
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : CollectionCardWidget(
                                                        collection: state
                                                            .collection[index],
                                                      ),
                                          ));
                                    }
                                    return const SizedBox.shrink();
                                  },
                                ),
                              ),
                              SizedBox(height: 24.v),
                              CustomOutlineButton(
                                  onPressed: () async {
                                    Navigator.of(context).pushNamed(
                                        AppRoutes.uploadReelScreen,
                                        arguments: {
                                          'reel': null,
                                          'path': null
                                        }).then((_) {
                                      context
                                          .read<MyReelBloc>()
                                          .add(LoadMyReelEvent());
                                    });
                                    // Media? media = await MediaServices
                                    //     .pickVideoPathAndExtension();
                                    // if (media != null) {
                                    //   Navigator.of(context).pushNamed(
                                    //       AppRoutes.uploadReelScreen,
                                    //       arguments: {
                                    //         'reel': null,
                                    //         'path': media.path
                                    //       }).then((_) {
                                    //     context
                                    //         .read<MyReelBloc>()
                                    //         .add(LoadMyReelEvent());
                                    //   });
                                    // }
                                  },
                                  leftIcon: CustomImageView(
                                    margin: EdgeInsets.only(right: 20.h),
                                    height: 20.h,
                                    width: 20.h,
                                    imagePath: ImageConstant.uploadIcon,
                                    color: Colors.black,
                                  ),
                                  text: 'Upload a Reel'),
                              SizedBox(height: 16.v),
                              CustomOutlineButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                        AppRoutes.scheduleStreamScreen);
                                  },
                                  leftIcon: CustomImageView(
                                    imagePath: ImageConstant.liveIcon,
                                    color: Colors.black,
                                  ),
                                  text: 'Schedule a stream'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.v),
              child: TabBarView(
                children: [
                  _postView(context),
                  _productView(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _productView(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 5.v,
          crossAxisSpacing: 5.h,
          childAspectRatio: 155.h / 269.v,
          crossAxisCount: 2),
      itemBuilder: (context, index) => _buildProductCart(context),
    );
  }

  Widget _postView(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return BlocBuilder<MyReelBloc, MyReelState>(
      builder: (context, state) {
        if (state is MyReelInitial) {
          context.read<MyReelBloc>().add(LoadMyReelEvent());
        } else if (state is MyReelLoading) {
          return const LoadingGridScreen();
        } else if (state is MyReelError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is MyReelLoaded) {
          return GridView.builder(
            itemCount: state.reels.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 5.v,
                crossAxisSpacing: 5.h,
                childAspectRatio: 140.h / 269.v,
                crossAxisCount: 2),
            itemBuilder: (context, index) => Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomImageView(
                      height: 261.v,
                      fit: BoxFit.fill,
                      radius: BorderRadius.only(
                          topRight: Radius.circular(12.h),
                          topLeft: Radius.circular(12.h)),
                      imagePath: state.reels[index].reelCoverPath,
                    ),
                    PlayButton(
                      isVisible: true,
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                          builder: (context) =>
                              VideoReelPage(initialIndex: index),
                        ))
                            .then((_) {
                          context.read<MyReelBloc>().add(LoadMyReelEvent());
                        });
                        // Navigator.of(context)
                        //     .push(MaterialPageRoute(
                        //   builder: (context) => MyReelViewScreen(
                        //     reelId: state.reels[index].id,
                        //   ),
                        // ))
                        //     .then((_) {
                        //   context.read<MyReelBloc>().add(LoadMyReelEvent());
                        // });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 7.v),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Visibility(
                            visible: state.reels[index].likeStatus == 0,
                            replacement: InkWell(
                              onTap: () {
                                context.read<MyReelBloc>().add(
                                    ToggleMyReelLikeButtonEvent(
                                        state.reels[index].id));
                              },
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ),
                            child: CustomImageView(
                              margin: EdgeInsets.only(top: 6.v, left: 2.h),
                              onTap: () {
                                context.read<MyReelBloc>().add(
                                    ToggleMyReelLikeButtonEvent(
                                        state.reels[index].id));
                              },
                              imagePath: ImageConstant.favIcon,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 8.v),
                          Text(
                            state.reels[index].likesCount.toString(),
                            style: textTheme.bodySmall!.copyWith(
                                fontSize: 12.fSize,
                                color: const Color(0xFF232323),
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          CustomImageView(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.commentsScreen,
                                      arguments: state.reels[index].id)
                                  .then((_) {
                                context
                                    .read<MyReelBloc>()
                                    .add(LoadMyReelEvent());
                              });
                              // showModalBottomSheet(
                              //   context: context,
                              //   isScrollControlled: true,
                              //   builder: (context) => BlocProvider(
                              //     create: (context) => CommentsBloc(
                              //         context.read<CommentsRepository>()),
                              //     child: SizedBox(
                              //       height: SizeUtils.height * 0.8,
                              //       child: CommentsScreen(
                              //           reelId: state.reels[index].id),
                              //     ),
                              //   ),
                              // ).then(
                              //   (value) {
                              //     context
                              //         .read<MyReelBloc>()
                              //         .add(LoadMyReelEvent());
                              //   },
                              // );
                            },
                            imagePath: ImageConstant.commentIcon,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 8.v),
                          Text(
                            state.reels[index].commentsCount.toString(),
                            style: textTheme.bodySmall!.copyWith(
                                fontSize: 12.fSize,
                                color: const Color(0xFF232323),
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () async {
                          await shareContent(state.reels[index].reelPath);
                        },
                        child: Column(
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.shareIcon,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 8.v),
                            Text(
                              'Share',
                              style: textTheme.bodySmall!.copyWith(
                                  fontSize: 12.fSize,
                                  color: const Color(0xFF232323),
                                  fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Container _buildProductCart(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
          color: AppColor.offWhite, borderRadius: BorderRadius.circular(12.h)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            height: 185.v,
            radius: BorderRadius.circular(12.h),
            imagePath: ImageConstant.productImage,
          ),
          SizedBox(height: 4.v),
          Text(
            'Classic White Sneakers',
            style: textTheme.titleMedium,
          ),
          SizedBox(height: 8.v),
          Text(
            'by Shubham Deep',
            style: textTheme.bodySmall,
          ),
          SizedBox(height: 12.v),
          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  height: 26.v,
                  text: 'View Details',
                  buttonTextStyle: textTheme.titleSmall,
                ),
              ),
              CustomImageView(
                imagePath: ImageConstant.shareIcon,
                color: AppColor.primary,
              )
            ],
          )
        ],
      ),
    );
  }

  Padding _buildCollectionCard(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(right: 12.h),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.collectionViewScreen);
        },
        child: Container(
          padding: EdgeInsets.all(8.h),
          height: 167.v,
          decoration: BoxDecoration(
              color: AppColor.offWhite,
              borderRadius: BorderRadius.circular(6.h)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                    width: 61.h,
                    height: 117.v,
                    fit: BoxFit.fill,
                    imagePath: imagesList[0],
                  ),
                  SizedBox(width: 2.h),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomImageView(
                        width: 52.h,
                        height: 52.v,
                        fit: BoxFit.fill,
                        imagePath: imagesList[1],
                      ),
                      SizedBox(height: 2.v),
                      CustomImageView(
                        width: 52.h,
                        height: 62.v,
                        fit: BoxFit.fill,
                        imagePath: imagesList[2],
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 4.v),
              Text(
                'Party Wear',
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 2.v),
              Text(
                '4 Post',
                style: textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildProfileCard(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        BlocProvider(
          create: (context) => ProfileApiBloc(context.read<UserRepository>()),
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
                _userModel = state.userModel;
                return Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(100.h),
                      ),
                      child: CustomImageView(
                        radius: BorderRadius.circular(100.h),
                        width: 90.v,
                        height: 90.v,
                        fit: BoxFit.fill,
                        imagePath: state.userModel.profileImg,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ViewImageWidget(
                                url: state.userModel.profileImg ?? ''),
                          ));
                        },
                      ),
                    ),
                    SizedBox(width: 12.h),
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.userModel.username ?? '',
                              style: textTheme.titleMedium!
                                  .copyWith(fontSize: 20.fSize),
                            ),
                            SizedBox(height: 8.v),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(AppRoutes.followersScreen);
                                  },
                                  child: Column(
                                    children: [
                                      Text('Followers',
                                          style: textTheme.bodySmall),
                                      SizedBox(height: 4.v),
                                      Text('224.5K',
                                          style: textTheme.titleMedium),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 8.v),
                                Column(
                                  children: [
                                    Text('Connections',
                                        style: textTheme.bodySmall),
                                    SizedBox(height: 4.v),
                                    Text('84', style: textTheme.titleMedium),
                                  ],
                                ),
                                SizedBox(width: 8.v),
                                Column(
                                  children: [
                                    Text('Share Profile',
                                        style: textTheme.bodySmall),
                                    SizedBox(height: 4.v),
                                    CustomImageView(
                                      onTap: () {
                                        shareContent(
                                            '${ApiConstant.baseUrlWeb}profile?id=${_userModel.id}');
                                      },
                                      imagePath: ImageConstant.shareIcon,
                                      color: Colors.black,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 12.v),
                      ],
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
