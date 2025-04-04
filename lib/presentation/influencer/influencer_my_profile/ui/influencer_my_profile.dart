import 'package:laiza/core/app_export.dart';
import 'package:laiza/core/utils/api_constant.dart';
import 'package:laiza/core/utils/pref_utils.dart';
import 'package:laiza/data/blocs/collection_bloc/collection_bloc.dart';
import 'package:laiza/data/models/product_model/product.dart';
import 'package:laiza/data/models/user/user_model.dart';
import 'package:laiza/data/repositories/collection_repository/collection_repository.dart';
import 'package:laiza/data/repositories/reel_repository/reel_repository.dart';
import 'package:laiza/presentation/shimmers/loading_grid.dart';
import 'package:laiza/presentation/shimmers/loading_list.dart';
import 'package:laiza/widgets/play_button.dart';

import '../../../../data/blocs/influencer_profile_bloc/influencer_profile_bloc.dart';
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
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProfileApiBloc(context.read<UserRepository>()),
          ),
          BlocProvider(
            create: (context) => MyReelBloc(context.read<ReelRepository>()),
          ),
        ],
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
                              .pushNamed(AppRoutes.editProfileScreen)
                              .then((_) {
                            context
                                .read<ProfileApiBloc>()
                                .add(FetchProfileApi());
                          });
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
                    ),
                  ),
                  backgroundColor: Colors.white,
                  expandedHeight: SizeUtils.height - 60.v,
                  flexibleSpace: FlexibleSpaceBar(
                    background: BlocBuilder<ProfileApiBloc, ProfileApiState>(
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
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///Profile Background
                              CustomImageView(
                                width: SizeUtils.width,
                                height: 150.v,
                                imagePath: _userModel.profileBg,
                                fit: BoxFit.fill,
                              ),

                              ///Profile Card
                              _buildProfileCard(context),
                              SizedBox(height: 12.h),

                              ///bio
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.userModel.username ?? '',
                                      style: textTheme.titleMedium,
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      state.userModel.bio ?? '',
                                      style: textTheme.bodySmall,
                                    ),
                                    SizedBox(height: 12.v),

                                    /// Social Icons
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

                                    ///Collections
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
                                            return HorizontalLoadingListPage(
                                              width: 125.h,
                                              height: 185.v,
                                              radius: 0,
                                            );
                                          } else if (state
                                              is CollectionLoading) {
                                            return HorizontalLoadingListPage(
                                              width: 125.h,
                                              height: 185.v,
                                              radius: 0,
                                            );
                                          } else if (state is CollectionError) {
                                            return Center(
                                              child: Text(state.message),
                                            );
                                          } else if (state
                                              is CollectionLoaded) {
                                            return SizedBox(
                                                height: 185.v,
                                                child: ListView.builder(
                                                  itemCount:
                                                      state.collection.length +
                                                          1,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder: (context,
                                                          index) =>
                                                      index == 0
                                                          ? InkWell(
                                                              onTap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pushNamed(
                                                                        AppRoutes
                                                                            .createCollectionScreen)
                                                                    .then((_) {
                                                                  context
                                                                      .read<
                                                                          CollectionBloc>()
                                                                      .add(
                                                                          FetchCollection());
                                                                });
                                                              },
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
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
                                                                      size:
                                                                          40.h,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5.h),
                                                                    const Text(
                                                                        'Add New \nCollection')
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          : CollectionCardWidget(
                                                              collection: state
                                                                      .collection[
                                                                  index - 1],
                                                            ),
                                                ));
                                          }
                                          return const SizedBox.shrink();
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 24.v),

                                    /// Upload Reel
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
                          );
                        }
                        return SizedBox.fromSize();
                      },
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
    TextTheme textTheme = Theme.of(context).textTheme;
    return BlocProvider(
      create: (context) =>
          InfluencerProfileBloc(context.read<UserRepository>()),
      child: BlocBuilder<InfluencerProfileBloc, InfluencerProfileState>(
        buildWhen: (previous, current) =>
            (current is InfluencerProfileInitial ||
                current is InfluencerProfileLoading ||
                current is InfluencerProfileError ||
                current is InfluencerProfileLoaded),
        builder: (context, state) {
          if (state is InfluencerProfileInitial) {
            context
                .read<InfluencerProfileBloc>()
                .add(FetchInfluencerProfileEvent(PrefUtils.getId()));
            return const SizedBox.shrink();
          } else if (state is InfluencerProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is InfluencerProfileError) {
            return Center(child: Text(state.message));
          } else if (state is InfluencerProfileLoaded) {
            return state.influencerProfileModel.data.products.isEmpty
                ? SingleChildScrollView(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 115.v),
                          CustomImageView(
                            imagePath: ImageConstant.noPostFound,
                            height: 100.v,
                          ),
                          SizedBox(height: 15.v),
                          Text(
                            'No Product Yet',
                            style: textTheme.titleMedium,
                          )
                        ],
                      ),
                    ),
                  )
                : GridView.builder(
                    itemCount:
                        state.influencerProfileModel.data.products.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 5.v,
                        crossAxisSpacing: 5.h,
                        childAspectRatio: 155.h / 269.v,
                        crossAxisCount: 2),
                    itemBuilder: (context, index) => _buildProductCart(context,
                        state.influencerProfileModel.data.products[index]),
                  );
          }
          return const SizedBox.shrink();
        },
      ),
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
          return state.reels.isEmpty
              ? SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 115.v),
                        CustomImageView(
                          imagePath: ImageConstant.noPostFound,
                          height: 100.v,
                        ),
                        SizedBox(height: 15.v),
                        Text(
                          'No Post Yet',
                          style: textTheme.titleMedium,
                        )
                      ],
                    ),
                  ),
                )
              : GridView.builder(
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
                                context
                                    .read<MyReelBloc>()
                                    .add(LoadMyReelEvent());
                              });
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
                                    margin:
                                        EdgeInsets.only(top: 6.v, left: 2.h),
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

  Container _buildProductCart(BuildContext context, Product product) {
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
            imagePath: product.productImage,
          ),
          SizedBox(height: 4.v),
          Text(
            product.productName,
            style: textTheme.titleMedium,
          ),
          SizedBox(height: 8.v),
          Text(
            'by ${product.user.name}',
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
                              state.userModel.name ?? '',
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
