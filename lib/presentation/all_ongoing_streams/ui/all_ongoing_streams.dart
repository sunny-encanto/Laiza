import 'package:laiza/core/app_export.dart';

import '../../../widgets/streams_card_widget.dart';

class AllOngoingStreamsScreen extends StatelessWidget {
  const AllOngoingStreamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ongoing Streams',
          style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
        ),
      ),
      body:
          // GridView.builder(
          //   padding: EdgeInsets.all(8.h),
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisSpacing: 8.h, mainAxisSpacing: 8.v, crossAxisCount: 2),
          //   itemBuilder: (context, index) => Center(
          //     child: StreamsCard(
          //       width: SizeUtils.width,
          //     ),
          //   ),
          // )
          MasonryGridView.count(
        padding: EdgeInsets.all(5.h),
        shrinkWrap: true,
        itemCount: 12,
        crossAxisCount: 2,
        mainAxisSpacing: 5.v,
        crossAxisSpacing: 5.h,
        itemBuilder: (context, index) {
          return const StreamsCard();
        },
      ),
    );
  }
}
