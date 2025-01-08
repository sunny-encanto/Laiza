import '../../../core/app_export.dart';
import '../../shimmers/loading_list.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications',
            style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize)),
      ),
      body: BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (BuildContext context, NotificationsState state) {
          if (state is NotificationsInitial) {
            context.read<NotificationsBloc>().add(NotificationFetchEvent());
          } else if (state is NotificationsLoadingState) {
            return const LoadingListPage();
          } else if (state is NotificationsLoaded) {
            // return const EmptyNotificationsScreen();
            //TODO: Add Condition here to show empty screen
            return ListView.builder(
                itemCount: 3,
                padding: EdgeInsets.all(20.h),
                itemBuilder: (BuildContext context, int index) =>
                    _buildItem(textTheme, context));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  SizedBox _buildItem(TextTheme textTheme, BuildContext context) {
    return SizedBox(
      width: SizeUtils.width,
      child: Padding(
        padding: EdgeInsets.only(bottom: 20.v),
        child: Row(
          children: [
            CustomImageView(
              width: 135.h,
              height: 135.v,
              fit: BoxFit.fill,
              radius: BorderRadius.only(
                  topLeft: Radius.circular(12.h),
                  bottomLeft: Radius.circular(12.h)),
              imagePath:
                  'https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350',
            ),
            SizedBox(width: 5.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your order has been shipped!',
                    style: textTheme.titleMedium,
                  ),
                  SizedBox(height: 8.v),
                  Text(
                    'Track your package as it’s on its way to you. Estimated delivery',
                    style: textTheme.bodySmall,
                  ),
                  SizedBox(height: 8.v),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '12:30 PM 03 Oct 2024',
                      style: textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
