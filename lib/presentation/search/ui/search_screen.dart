import 'package:laiza/data/models/search_model/search_model.dart';
import 'package:laiza/presentation/empty_pages/no_search_found/no_search_found.dart';

import '../../../core/app_export.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final _searchController = TextEditingController();
  final List<String> _suggestions = ['Kristen Stewart', 'Kristen', 'Stewart'];
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                context
                    .read<SearchBloc>()
                    .add(SearchUserInteractionEvent(query));
              },
            ),
          ),
          body: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is SearchResultLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SearchErrorState) {
                Center(child: Text(state.message));
              } else if (state is SearchResultLoadedState) {
                return Column(
                  children: [
                    TabBar(
                        labelColor: AppColor.primary,
                        indicatorColor: AppColor.primary,
                        unselectedLabelColor: Colors.grey,
                        tabs: const [
                          Tab(
                            text: 'Account',
                          ),
                          Tab(text: 'Product'),
                        ]),
                    Expanded(
                        child: TabBarView(children: [
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
                              itemBuilder: (context, index) =>
                                  _buildSearchResult(
                                      state.searchResult[index], textTheme)),
                      //Product View
                      Expanded(
                          child: GridView.builder(
                        padding: EdgeInsets.all(20.h),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 130.h / 208.v,
                          mainAxisSpacing: 15.h,
                          crossAxisSpacing: 15.h,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomImageView(
                              radius: BorderRadius.circular(6.h),
                              height: 150.v,
                              width: SizeUtils.width,
                              fit: BoxFit.fill,
                              imagePath: imagesList[0],
                            ),
                            SizedBox(height: 4.v),
                            Text(
                              'Georgia star',
                              style: textTheme.bodySmall,
                            ),
                            SizedBox(height: 6.v),
                            Text(
                              'Bella Crossbody Bag',
                              style: textTheme.titleMedium,
                            ),
                            SizedBox(height: 6.v),
                            Text(
                              '₹ 2,799',
                              style: textTheme.bodySmall,
                            ),
                            SizedBox(height: 8.v),
                            Center(
                              child: CustomElevatedButton(
                                width: 208.h,
                                height: 42.v,
                                text: 'Continue',
                                buttonTextStyle: textTheme.titleSmall,
                              ),
                            )
                          ],
                        ),
                      )),
                    ]))
                  ],
                );
              }
              return ListView.builder(
                  itemCount: searchResult.length,
                  padding: EdgeInsets.all(20.h),
                  itemBuilder: (context, index) =>
                      _buildSuggestion(index, context));
            },
          )),
    );
  }

  ListTile _buildSearchResult(SearchModel item, TextTheme textTheme) {
    return ListTile(
      onTap: () {},
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

  InkWell _buildSuggestion(int index, BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        context
            .read<SearchBloc>()
            .add(SearchUserInteractionEvent(_suggestions[index]));
        _searchController.text = _suggestions[index];
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColor.offWhite))),
        height: 58.v,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _suggestions[index],
              style: textTheme.titleMedium,
            ),
            CustomImageView(
              imagePath: ImageConstant.recentIcon,
            )
          ],
        ),
      ),
    );
  }
}
