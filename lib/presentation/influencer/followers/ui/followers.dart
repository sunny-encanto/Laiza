import '../../../../core/app_export.dart';
import '../../../../data/models/followers_model/follower.dart';
import '../../../empty_pages/no_connections_found/no_connections_found.dart';

class FollowersScreen extends StatelessWidget {
  FollowersScreen({super.key});

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Followers',
          style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0.h),
        child: BlocBuilder<FollowersBloc, FollowersState>(
          builder: (context, state) {
            if (state is FollowersInitial) {
              context.read<FollowersBloc>().add(FollowersFetchEvent());
            } else if (state is FollowersLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is FollowersError) {
              return Center(child: Text(state.message));
            } else if (state is FollowersLoaded) {
              return state.followers.isNotEmpty
                  ? _buildFollowersWidget(context, state.followers)
                  : const NoConnectionsFoundScreen();
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Column _buildFollowersWidget(BuildContext context, List<Follower> items) {
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
            context.read<FollowersBloc>().add(FollowersSearch(query));
          },
          hintText: 'Search',
        ),
        Expanded(
          child: ListView.separated(
            itemCount: items.length,
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) =>
                Divider(height: 2.v),
            itemBuilder: (context, index) =>
                _buildFollowersItem(items, index, context),
          ),
        )
      ],
    );
  }

  ListTile _buildFollowersItem(
      List<Follower> items, int index, BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: CustomImageView(
        height: 50.h,
        width: 50.h,
        radius: BorderRadius.circular(50.h),
        imagePath: items[index].profileImg,
      ),
      trailing: InkWell(
        onTap: () {
          context
              .read<FollowersBloc>()
              .add(FollowersRemoveEvent(items[index].id));
        },
        child: Container(
          width: 96.h,
          height: 36.v,
          alignment: Alignment.center,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: const Text('Remove'),
        ),
      ),
      title: Text(
        items[index].name,
        style: textTheme.titleMedium,
      ),
    );
  }
}
