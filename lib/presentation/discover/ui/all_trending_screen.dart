import 'package:laiza/core/app_export.dart';

import '../../../data/blocs/trending_now_bloc/trending_now_bloc.dart';
import '../../../widgets/trending_card_widget.dart';
import '../../shimmers/loading_grid.dart';

class AllTrendingScreen extends StatelessWidget {
  const AllTrendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: AppColor.offWhite,
        title: Text(
          'Trending Now',
          style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
        ),
      ),
      body: BlocProvider(
        create: (context) => TrendingNowBloc(context.read<PostRepository>()),
        child: BlocBuilder<TrendingNowBloc, TrendingNowState>(
          builder: (context, state) {
            print('build=>');
            if (state is TrendingNowInitial) {
              context.read<TrendingNowBloc>().add(FetchTrendingNowEvent());
            } else if (state is TrendingNowInitial) {
              return const LoadingGridScreen();
            } else if (state is TrendingNowError) {
              return Center(child: Text(state.message));
            } else if (state is TrendingNowLoaded) {
              return MasonryGridView.count(
                shrinkWrap: true,
                itemCount: state.trendingNow.length,
                crossAxisCount: 3,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                itemBuilder: (BuildContext context, index) {
                  return TrendingCardWidget(
                    trendingItems: state.trendingNow[index],
                    extent: (index % 2 + 1) * 100,
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      // MasonryGridView.count(
      //   padding: EdgeInsets.all(20.h),
      //   shrinkWrap: true,
      //   itemCount: 12,
      //   crossAxisCount: 3,
      //   mainAxisSpacing: 0,
      //   crossAxisSpacing: 0,
      //   itemBuilder: (context, index) {
      //     return TrendingCardWidget(
      //       index: index,
      //       extent: (index % 2 + 1) * 100,
      //     );
      //   },
      // ),
    );
  }
}
