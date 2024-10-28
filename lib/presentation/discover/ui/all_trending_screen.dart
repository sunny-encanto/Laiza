import 'package:laiza/core/app_export.dart';

import '../../../widgets/trending_card_widget.dart';

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
      body: MasonryGridView.count(
        padding: EdgeInsets.all(20.h),
        shrinkWrap: true,
        itemCount: 12,
        crossAxisCount: 3,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        itemBuilder: (context, index) {
          return TrendingCardWidget(
            index: index,
            extent: (index % 2 + 1) * 100,
          );
        },
      ),
    );
  }
}
