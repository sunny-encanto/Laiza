import 'package:laiza/data/models/connections_model/connections_model.dart';
import 'package:laiza/presentation/shimmers/loading_list.dart';

import '../../../../core/app_export.dart';

class DiscoverConnectionsScreen extends StatelessWidget {
  DiscoverConnectionsScreen({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'New Connections',
        style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
      )),
      body: BlocBuilder<DiscoverConnectionsBloc, DiscoverConnectionsState>(
        builder: (context, state) {
          if (state is DiscoverConnectionsInitial) {
            context
                .read<DiscoverConnectionsBloc>()
                .add(DiscoverConnectionsFetchEvent());
            return const SizedBox.shrink();
          } else if (state is DiscoverConnectionsLoading) {
            return const LoadingListPage();
          } else if (state is DiscoverConnectionsError) {
            return Center(child: Text(state.message));
          } else if (state is DiscoverConnectionsLoaded) {
            return buildConnectionItem(context, state.connections, false);
          } else if (state is DiscoverConnectionsFilterLoaded) {
            return buildConnectionItem(context, state.connections, true);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Padding buildConnectionItem(BuildContext context,
      List<ConnectionsModel> connections, bool isFiltered) {
    return Padding(
      padding: EdgeInsets.all(20.h),
      child: Column(
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
              context
                  .read<DiscoverConnectionsBloc>()
                  .add(DiscoverConnectionsSearchEvent(query));
            },
            hintText: 'Search',
          ),
          Expanded(
            child: ListView.separated(
              itemCount: connections.length,
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(height: 2.v),
              itemBuilder: (context, index) =>
                  _buildConnectionItem(connections, index, context, isFiltered),
            ),
          )
        ],
      ),
    );
  }

  ListTile _buildConnectionItem(List<ConnectionsModel> items, int index,
      BuildContext context, bool isFiltered) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: CustomImageView(
        height: 50.h,
        width: 50.h,
        radius: BorderRadius.circular(50.h),
        imagePath: items[index].profile,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomElevatedButton(
            width: 100.h,
            height: 32.v,
            text: items[index].isConnected ? 'Connected' : 'Connect',
            buttonTextStyle: textTheme.titleSmall,
            onPressed: () {
              if (isFiltered) {
                context
                    .read<DiscoverConnectionsBloc>()
                    .add(SendFilterConnectionEvent(items[index].id));
              } else {
                context
                    .read<DiscoverConnectionsBloc>()
                    .add(SendConnectionEvent(items[index].id));
              }
            },
          ),
          InkWell(
            onTap: () {
              if (isFiltered) {
                context
                    .read<DiscoverConnectionsBloc>()
                    .add(CrossFilterConnectionEvent(items[index].id));
              } else {
                context
                    .read<DiscoverConnectionsBloc>()
                    .add(CrossConnectionEvent(items[index].id));
              }
            },
            child: const Icon(
              Icons.close,
            ),
          )
        ],
      ),
      title: Text(
        items[index].name,
        style: textTheme.titleMedium,
      ),
      // subtitle: SizedBox(
      //   width: SizeUtils.width,
      //   child: Row(
      //     children: [
      //       Text(
      //         'Product Category- ',
      //         style: textTheme.bodySmall!.copyWith(fontSize: 10.fSize),
      //       ),
      //       Text(
      //         items[index].category,
      //         style: textTheme.bodySmall!
      //             .copyWith(fontSize: 10.fSize, color: AppColor.blackColor),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
