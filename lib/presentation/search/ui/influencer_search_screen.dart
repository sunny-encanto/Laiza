import 'package:laiza/data/models/search_model/search_model.dart';
import 'package:laiza/presentation/empty_pages/no_search_found/no_search_found.dart';

import '../../../core/app_export.dart';

class InfluencerSearchScreen extends StatefulWidget {
  const InfluencerSearchScreen({super.key});

  @override
  State<InfluencerSearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<InfluencerSearchScreen>
    with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();

  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Listen to tab changes
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _currentIndex = _tabController.index;
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 30.h,
          title: CustomTextFormField(
            controller: _searchController,
            prefixConstraints: BoxConstraints(maxWidth: 25.h),
            prefix: Padding(
              padding: EdgeInsets.only(left: 10.h),
              child: CustomImageView(
                width: 15.h,
                imagePath: ImageConstant.searchIcon,
              ),
            ),
            suffix: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                return _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          context.read<SearchBloc>().add(
                              SearchUserInteractionEvent(
                                  _searchController.text));
                        },
                        icon: const Icon(
                          Icons.cancel_outlined,
                          color: Colors.grey,
                        ))
                    : const Text('');
              },
            ),
            hintText: 'Search',
            onChanged: (query) {
              if (_currentIndex == 0) {
                context
                    .read<SearchBloc>()
                    .add(SearchUserInteractionEvent(query));
              } else {
                context
                    .read<SearchBloc>()
                    .add(SearchProductInteractionEvent(query));
              }
            },
          ),
        ),
        body: BlocBuilder<SearchBloc, SearchState>(
          buildWhen: (previous, current) =>
              (current is SearchResultLoadingState ||
                  current is SearchResultLoadedState),
          builder: (context, state) {
            if (state is SearchInitial) {
              context.read<SearchBloc>().add(const FetchSearchItems(true));
            } else if (state is SearchResultLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SearchErrorState) {
              Center(child: Text(state.message));
            } else if (state is SearchResultLoadedState) {
              context.read<SearchBloc>().add(FetchSearchItemsProducts());
              return Column(
                children: [
                  TabBar(
                      controller: _tabController,
                      labelColor: AppColor.primary,
                      indicatorColor: AppColor.primary,
                      unselectedLabelColor: Colors.grey,
                      tabs: const [
                        Tab(
                          text: 'Seller',
                        ),
                        Tab(text: 'Product'),
                      ]),
                  Expanded(
                      child: TabBarView(controller: _tabController, children: [
                    state.searchResult.isEmpty
                        ? const NoSearchFoundScreen()
                        : ListView.separated(
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            shrinkWrap: true,
                            itemCount: state.searchResult.length,
                            padding: EdgeInsets.all(20.h),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    Divider(height: 2.v),
                            itemBuilder: (context, index) => _buildSearchResult(
                                state.searchResult[index], context)),
                    //Product View
                    BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) {
                        if (state is SearchProductResultLoadingState) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is SearchProductResultLoadedState) {
                          return state.searchResult.isEmpty
                              ? const NoSearchFoundScreen()
                              : GridView.builder(
                                  itemCount: state.searchResult.length,
                                  padding: EdgeInsets.all(20.h),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 130.h / 208.v,
                                    mainAxisSpacing: 15.h,
                                    crossAxisSpacing: 15.h,
                                    crossAxisCount: 2,
                                  ),
                                  itemBuilder: (context, index) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomImageView(
                                          radius: BorderRadius.circular(6.h),
                                          height: 150.v,
                                          width: SizeUtils.width,
                                          fit: BoxFit.fill,
                                          imagePath: state.searchResult[index]
                                                  .images.isEmpty
                                              ? ImageConstant.imageNotFound
                                              : state.searchResult[index]
                                                  .images[0].imagePath),
                                      SizedBox(height: 4.v),
                                      Text(
                                        state.searchResult[index].productName,
                                        style: textTheme.bodySmall!.copyWith(
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      SizedBox(height: 6.v),
                                      // SizedBox(
                                      //   height: 10.v,
                                      //   child: HtmlWidget(
                                      //     state.searchResult[index].description,
                                      //     // style: textTheme.titleMedium!.copyWith(
                                      //     //     overflow: TextOverflow.ellipsis),
                                      //     renderMode: RenderMode.column,
                                      //
                                      //     // textStyle: textTheme.bodyMedium!
                                      //     //     .copyWith(
                                      //     //         overflow:
                                      //     //             TextOverflow.ellipsis),
                                      //   ),
                                      // ),
                                      // Text(
                                      //   state.searchResult[index].description,
                                      //   style: textTheme.titleMedium!.copyWith(
                                      //       overflow: TextOverflow.ellipsis),
                                      // ),
                                      SizedBox(height: 6.v),
                                      Text(
                                        '₹ ${state.searchResult[index].price}',
                                        style: textTheme.bodySmall,
                                      ),
                                      SizedBox(height: 8.v),
                                      Center(
                                        child: CustomElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                AppRoutes.productDetailScreen,
                                                arguments: state
                                                    .searchResult[index].id);
                                          },
                                          width: 208.h,
                                          height: 36.v,
                                          text: 'Continue',
                                          buttonTextStyle: textTheme.titleSmall,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ]))
                ],
              );
            }
            return const SizedBox.shrink();
            // ListView.builder(
            //     itemCount: searchResult.length,
            //     padding: EdgeInsets.all(20.h),
            //     itemBuilder: (context, index) =>
            //         _buildSuggestion(index, context));
          },
        ));
  }

  ListTile _buildSearchResult(SearchModel item, BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return ListTile(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.influencerProfileScreen,
            arguments: item.id.toString());
      },
      contentPadding: const EdgeInsets.all(0),
      leading: CustomImageView(
        height: 50.h,
        width: 50.h,
        radius: BorderRadius.circular(50.h),
        imagePath: item.profile,
      ),
      title: Text(
        item.name,
        style: textTheme.titleMedium,
      ),
      subtitle: Row(
        children: [
          CustomImageView(imagePath: ImageConstant.groupIcon),
          SizedBox(width: 2.h),
          Text(
            item.followersCount,
            style: textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
