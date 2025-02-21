import '../../../core/app_export.dart';
import '../../../data/blocs/all_influencer_bloc/bloc/all_influencer_bloc.dart';
import '../../../data/repositories/follow_repository/follow_repository.dart';
import '../../../widgets/influencer_profile_card_widget.dart';
import '../../shimmers/loading_grid.dart';

class AllCreatorScreen extends StatelessWidget {
  const AllCreatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Creators',
          style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: BlocProvider(
          create: (BuildContext context) => AllInfluencerBloc(
              context.read<UserRepository>(),
              context.read<FollowersRepository>()),
          child: BlocBuilder<AllInfluencerBloc, AllInfluencerState>(
            builder: (BuildContext context, AllInfluencerState state) {
              if (state is AllInfluencerInitial) {
                context.read<AllInfluencerBloc>().add(FetchAllInfluencer());
                return const LoadingGridScreen();
              }
              if (state is AllInfluencerLoading) {
                return const LoadingGridScreen();
              } else if (state is AllInfluencerError) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is AllInfluencerLoaded) {
                return MasonryGridView.builder(
                  gridDelegate:
                      const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  shrinkWrap: true,
                  itemCount: state.influencers.length,
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
      ),
    );
  }
}
