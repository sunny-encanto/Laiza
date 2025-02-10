import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laiza/core/app_export.dart';

import '../../../data/models/live_stream_model.dart/live_stream_model.dart';
import '../../../data/services/firebase_services.dart';
import '../../../widgets/streams_card_widget.dart';
import '../../empty_pages/no_ongoing_stream/no_ongoing_streams.dart';

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
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseServices.getOnGoingLiveStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox.shrink();
            }
            var snapShotData = snapshot.data?.docs ?? [];
            List<LiveStreamModel> liveStreamModel = snapShotData
                .map((e) =>
                    LiveStreamModel.fromMap(e.data() as Map<String, dynamic>))
                .toList();
            return liveStreamModel.isEmpty
                ? const NoOngoingStreamsScreen()
                : MasonryGridView.count(
                    padding: EdgeInsets.all(5.h),
                    shrinkWrap: true,
                    itemCount: liveStreamModel.length,
                    crossAxisCount: 2,
                    mainAxisSpacing: 5.v,
                    crossAxisSpacing: 5.h,
                    itemBuilder: (context, index) {
                      return StreamsCard(
                        isLive: true,
                        model: liveStreamModel[index],
                      );
                    },
                  );
          }),
    );
  }
}
