import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/blocs/all_influencer_bloc/bloc/all_influencer_bloc.dart';
import 'package:laiza/data/repositories/follow_repository/follow_repository.dart';
import 'package:laiza/presentation/creator/bloc/creator_bloc.dart';
import 'package:laiza/presentation/shimmers/loading_grid.dart';
import 'package:laiza/widgets/influencer_card_widget.dart';

import '../../../widgets/influencer_profile_card_widget.dart';

// ignore: must_be_immutable
class CreatorScreen extends StatelessWidget {
  CreatorScreen({super.key});

  int _selectedChip = 1;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: customAppBar(context),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (BuildContext context) => CreatorBloc(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.v),
                Text(
                  'Influencers You Follow',
                  style: textTheme.titleLarge,
                ),
                SizedBox(height: 20.v),
                SizedBox(
                    height: 130.v,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) => Padding(
                        padding: EdgeInsets.only(left: 8.h),
                        child: profileWidget(textTheme),
                      ),
                    )),
                SizedBox(height: 20.v),
                SizedBox(
                  height: 36.v,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: () {
                        context
                            .read<CreatorBloc>()
                            .add(CreatorsCategoryChipSelectedEvent(index));
                      },
                      child: BlocConsumer<CreatorBloc, CreatorState>(
                        listener: (BuildContext context, state) {
                          if (state is CreatorsCategoryChipSelectedState) {
                            _selectedChip = state.categoryId;
                          }
                        },
                        builder: (BuildContext context, state) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            margin: EdgeInsets.only(right: 12.h),
                            height: 36.v,
                            width: 89.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: _selectedChip == index
                                    ? Colors.black
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(24.h)),
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 400),
                              style: textTheme.labelSmall!.copyWith(
                                  color: _selectedChip == index
                                      ? Colors.white
                                      : null),
                              child: const Text(
                                'Fashion',
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.v),
                Text(
                  'Meet the Trendsetters',
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 2.v),
                Text(
                  'Discover the most buzz-worthy creators driving the latest trends. Tap to explore their reels and products.',
                  style: textTheme.bodySmall,
                ),
                SizedBox(height: 20.h),
                SizedBox(
                    height: 261.v,
                    child: ListView.builder(
                      itemCount: imagesList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, index) => Padding(
                        padding: EdgeInsets.only(right: 5.h),
                        child: InfluencerCardWidget(index: index),
                      ),
                    )),
                SizedBox(height: 28.v),
                Text(
                  'Discover and Follow New Creators',
                  style: textTheme.titleMedium,
                ),
                SizedBox(height: 20.v),
                BlocProvider(
                  create: (BuildContext context) => AllInfluencerBloc(
                      context.read<UserRepository>(),
                      context.read<FollowersRepository>()),
                  child: BlocBuilder<AllInfluencerBloc, AllInfluencerState>(
                    builder: (BuildContext context, AllInfluencerState state) {
                      if (state is AllInfluencerInitial) {
                        context
                            .read<AllInfluencerBloc>()
                            .add(FetchAllInfluencer());
                      }
                      if (state is AllInfluencerLoading) {
                        return const LoadingGridScreen();
                      } else if (state is AllInfluencerError) {
                        return Center(
                          child: Text(state.message),
                        );
                      } else if (state is AllInfluencerLoaded) {
                        return MasonryGridView.count(
                          shrinkWrap: true,
                          itemCount: state.influencers.length,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 5.v,
                          crossAxisSpacing: 5.h,
                          itemBuilder: (BuildContext context, index) {
                            return InfluencerProfileCardWidget(
                                userModel: state.influencers[index]);
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profileWidget(TextTheme textTheme) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            // Outer colored border
            Container(
              width: 82.v,
              height: 82.v,
              decoration: const BoxDecoration(
                color: Colors.pink,
                shape: BoxShape.circle,
              ),
            ),
            // Inner content
            Container(
              width: 75.v,
              height: 75.v,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: CustomImageView(
                radius: BorderRadius.circular(80),
                width: 82.v,
                height: 82.v,
                imagePath: ImageConstant.reelImg,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          'Name ',
          style: textTheme.titleMedium,
        ),
        Row(
          children: [
            Container(
              height: 8.v,
              width: 8.h,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.red),
            ),
            SizedBox(width: 5.h),
            Text(
              '4 New Post ',
              style: textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }
}
