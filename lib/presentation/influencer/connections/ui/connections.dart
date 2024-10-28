import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/connections_model/connections_model.dart';

import '../../../empty_pages/no_connections_found/no_connections_found.dart';

class ConnectionsScreen extends StatelessWidget {
  ConnectionsScreen({super.key});
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'My Connections',
        style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
      )),
      body: Padding(
        padding: EdgeInsets.all(20.0.h),
        child: BlocBuilder<ConnectionsBloc, ConnectionsState>(
          builder: (context, state) {
            if (state is ConnectionsInitial) {
              context.read<ConnectionsBloc>().add(FetchConnectionsEvent());
            } else if (state is ConnectionsLoadingSate) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ConnectionsErrorState) {
              return Center(child: Text(state.message));
            } else if (state is ConnectionsLoadedState) {
              return _buildConnectionsWidget(context, state.connections);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Column _buildConnectionsWidget(
      BuildContext context, List<ConnectionsModel> items) {
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
          child: items.isEmpty
              ? const NoConnectionsFoundScreen()
              : ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(height: 2.v),
                  itemCount: items.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      _buildConnectionItem(items, index, textTheme),
                ),
        )
      ],
    );
  }

  ListTile _buildConnectionItem(
      List<ConnectionsModel> items, int index, TextTheme textTheme) {
    return ListTile(
      onTap: () {},
      contentPadding: const EdgeInsets.all(0),
      leading: CustomImageView(
        height: 50.h,
        width: 50.h,
        radius: BorderRadius.circular(50.h),
        imagePath: items[index].profile,
      ),
      trailing: CustomImageView(
        imagePath: ImageConstant.chatIcon,
      ),
      title: Text(
        items[index].name,
        style: textTheme.titleMedium,
      ),
      subtitle: Row(
        children: [
          Text(
            'Product Category- ',
            style: textTheme.bodySmall,
          ),
          Text(
            items[index].category,
            style: textTheme.bodySmall!.copyWith(color: AppColor.blackColor),
          ),
        ],
      ),
    );
  }
}
