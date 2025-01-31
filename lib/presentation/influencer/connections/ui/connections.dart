import 'package:laiza/core/app_export.dart';
import 'package:laiza/presentation/shimmers/loading_list.dart';

import '../../../../data/models/my_connections_model/my_connections_model.dart';
import '../../../empty_pages/no_connections_found/no_connections_found.dart';

class ConnectionsScreen extends StatelessWidget {
  ConnectionsScreen({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'My Connections',
        style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
      )),
      body: BlocBuilder<ConnectionsBloc, ConnectionsState>(
        builder: (context, state) {
          if (state is ConnectionsInitial) {
            context.read<ConnectionsBloc>().add(FetchConnectionsEvent());
          } else if (state is ConnectionsLoadingSate) {
            return const LoadingListPage();
          } else if (state is ConnectionsErrorState) {
            return Center(child: Text(state.message));
          } else if (state is ConnectionsLoadedState) {
            return Padding(
              padding: EdgeInsets.all(20.0.h),
              child: _buildConnectionsWidget(context, state.connections),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Column _buildConnectionsWidget(
      BuildContext context, List<Connection> connections) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        CustomTextFormField(
          controller: _searchController,
          prefixConstraints: BoxConstraints(maxWidth: 25.h),
          prefix: Padding(
            padding: EdgeInsets.only(left: 10.h),
            child: CustomImageView(
              width: 15.h,
              imagePath: ImageConstant.searchIcon,
            ),
          ),
          onChanged: (query) {
            context.read<ConnectionsBloc>().add(SearchConnectionsEvent(query));
          },
          hintText: 'Search',
        ),
        Expanded(
          child: connections.isEmpty
              ? const NoConnectionsFoundScreen()
              : ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(height: 2.v),
                  itemCount: connections.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Connection item = connections[index];
                    return _buildConnectionItem(item, textTheme);
                  },
                ),
        )
      ],
    );
  }

  ListTile _buildConnectionItem(Connection item, TextTheme textTheme) {
    return ListTile(
      onTap: () {},
      contentPadding: const EdgeInsets.all(0),
      leading: CustomImageView(
        onTap: () {},
        height: 50.h,
        width: 50.h,
        radius: BorderRadius.circular(50.h),
        imagePath: item.profileImg,
      ),
      trailing: CustomImageView(
        imagePath: ImageConstant.chatIcon,
      ),
      title: Text(
        item.name,
        style: textTheme.titleMedium,
      ),
      // subtitle: Row(
      //   children: [
      //     Text(
      //       'Product Category- ',
      //       style: textTheme.bodySmall,
      //     ),
      //     Text(
      //       item.category,
      //       style: textTheme.bodySmall!.copyWith(color: AppColor.blackColor),
      //     ),
      //   ],
      // ),
    );
  }
}
