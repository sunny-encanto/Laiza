import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/blocs/all_seller_bloc/all_seller_bloc.dart';
import 'package:laiza/data/models/my_connections_model/my_connections_model.dart';
import 'package:laiza/data/models/product_model/product.dart';
import 'package:laiza/data/models/user/user_model.dart';
import 'package:laiza/data/repositories/connections_repository/connections_repository.dart';

import '../../../../data/blocs/product_bloc/product_bloc.dart';
import '../../../../data/repositories/product_repository/product_repository.dart';
import '../../../shimmers/loading_list.dart';
import '../../side_bar/ui/side_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      drawer: const SideBar(),
      appBar: customAppBar(context),
      body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: EdgeInsets.all(20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        contentPadding: EdgeInsets.all(15.h),
                        prefixConstraints: BoxConstraints(maxWidth: 25.h),
                        prefix: Padding(
                          padding: EdgeInsets.only(left: 10.h),
                          child: CustomImageView(
                            width: 15.h,
                            imagePath: ImageConstant.searchIcon,
                          ),
                        ),
                        hintText: 'Search for product or seller',
                      ),
                    ),
                    SizedBox(width: 16.h),
                    CustomIconButton(
                      icon: ImageConstant.request,
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.connectionsRequestScreen);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12.v),
                // SizedBox(
                //   height: 46.v,
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: 3,
                //     itemBuilder: (context, index) => Padding(
                //       padding: EdgeInsets.only(right: 12.h),
                //       child: index == 0
                //           ? Chip(
                //               backgroundColor: AppColor.primary,
                //               label: Row(
                //                 mainAxisSize: MainAxisSize.min,
                //                 children: [
                //                   CustomImageView(
                //                     imagePath: ImageConstant.menuIcon,
                //                     color: Colors.white,
                //                   ),
                //                   SizedBox(width: 5.h),
                //                   Text(
                //                     'Filters',
                //                     style: textTheme.bodySmall!
                //                         .copyWith(color: Colors.white),
                //                   )
                //                 ],
                //               ))
                //           : Chip(
                //               shape: StadiumBorder(
                //                   side: BorderSide(color: AppColor.primary)),
                //               backgroundColor: Colors.white,
                //               label: Row(
                //                 mainAxisSize: MainAxisSize.min,
                //                 children: [
                //                   Text(
                //                     getFilterName(index),
                //                     style: textTheme.bodySmall!
                //                         .copyWith(color: AppColor.primary),
                //                   ),
                //                   SizedBox(width: 5.h),
                //                   Icon(
                //                     Icons.arrow_drop_down,
                //                     color: AppColor.primary,
                //                   )
                //                 ],
                //               )),
                //     ),
                //   ),
                // ),
                // SizedBox(height: 24.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Products from your connections',
                      style:
                          textTheme.titleMedium!.copyWith(fontSize: 16.fSize),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.allProductsScreen);
                      },
                      child: Text(
                        'View All',
                        style: textTheme.bodySmall!,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 12.v),
                BlocProvider(
                  create: (_) => ProductBloc(context.read<ProductRepository>())
                    ..add(LoadProducts()),
                  child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is ProductInitial) {
                        return const HorizontalLoadingListPage();
                      } else if (state is ProductLoading) {
                        return const HorizontalLoadingListPage();
                      } else if (state is ProductError) {
                        return Center(child: Text('Error: ${state.message}'));
                      } else if (state is ProductLoaded) {
                        return SizedBox(
                          height: 330.v,
                          child: ListView.builder(
                            itemCount: state.products.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.only(right: 10.h),
                              child: PromotionProductCard(
                                  product: state.products[index]),
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Connections',
                      style:
                          textTheme.titleMedium!.copyWith(fontSize: 16.fSize),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.connectionsScreen);
                      },
                      child: Text(
                        'View All',
                        style: textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.v),
                BlocProvider(
                  create: (context) =>
                      ConnectionsBloc(context.read<ConnectionsRepository>()),
                  child: BlocBuilder<ConnectionsBloc, ConnectionsState>(
                    builder: (context, state) {
                      if (state is ConnectionsInitial) {
                        context
                            .read<ConnectionsBloc>()
                            .add(FetchConnectionsEvent());
                        return const LoadingListPage();
                      } else if (state is ConnectionsLoadingSate) {
                        return const LoadingListPage();
                      } else if (state is ConnectionsErrorState) {
                        return Center(child: Text(state.message));
                      } else if (state is ConnectionsLoadedState) {
                        List<Connection> connections = state.connections
                            .sublist(
                                0,
                                state.connections.length > 4
                                    ? 4
                                    : state.connections.length);
                        return Column(
                          children: List.generate(
                              connections.length,
                              (index) => _buildConnectionItem(
                                  connections[index], textTheme)),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                SizedBox(height: 28.v),
                Text(
                  'Promote These Hot Products',
                  style: textTheme.titleMedium!.copyWith(fontSize: 16.fSize),
                ),
                SizedBox(height: 12.v),
                BlocProvider(
                  create: (_) => ProductBloc(context.read<ProductRepository>())
                    ..add(LoadProducts()),
                  child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is ProductInitial) {
                        return const HorizontalLoadingListPage();
                      } else if (state is ProductLoading) {
                        return const HorizontalLoadingListPage();
                      } else if (state is ProductError) {
                        return Center(child: Text('Error: ${state.message}'));
                      } else if (state is ProductLoaded) {
                        return SizedBox(
                          height: 330.v,
                          child: ListView.builder(
                            itemCount: state.products.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.only(right: 10.h),
                              child: PromotionProductCard(
                                  product: state.products[index]),
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                SizedBox(height: 20.v),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recommended Sellers to Collaborate',
                      style:
                          textTheme.titleMedium!.copyWith(fontSize: 16.fSize),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(AppRoutes.discoverConnectionsScreen);
                      },
                      child: Text(
                        'View All',
                        style: textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.v),
                BlocProvider(
                  create: (context) =>
                      AllSellerBloc(context.read<UserRepository>()),
                  child: BlocBuilder<AllSellerBloc, AllSellerState>(
                    builder: (context, state) {
                      if (state is AllSellerInitial) {
                        context
                            .read<AllSellerBloc>()
                            .add(FetchAllSellerEvent());
                        return const HorizontalLoadingListPage();
                      } else if (state is AllSellerLoading) {
                        return const HorizontalLoadingListPage();
                      } else if (state is AllSellerError) {
                        return Center(child: Text(state.message));
                      } else if (state is AllSellerLoaded) {
                        return SizedBox(
                          height: 250.v,
                          child: ListView.builder(
                              itemCount: state.sellers.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                UserModel seller = state.sellers[index];
                                return Padding(
                                  padding: EdgeInsets.only(right: 10.h),
                                  child: Container(
                                    width: 185.h,
                                    decoration: BoxDecoration(
                                        color: AppColor.offWhite,
                                        borderRadius:
                                            BorderRadius.circular(12.h)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomImageView(
                                          height: 100.h,
                                          width: 100.h,
                                          radius: BorderRadius.circular(100.h),
                                          imagePath: seller.profileImg,
                                        ),
                                        SizedBox(height: 8.v),
                                        Text(
                                          seller.name ?? '',
                                          style: textTheme.titleMedium!
                                              .copyWith(fontSize: 16.fSize),
                                        ),
                                        // SizedBox(height: 4.h),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.center,
                                        //   children: [
                                        //     CustomImageView(
                                        //         imagePath:
                                        //             ImageConstant.categoryIcon),
                                        //     SizedBox(width: 5.h),
                                        //     Text(
                                        //         seller.productCategory
                                        //             .toString(),
                                        //         //'Cosmetics',
                                        //         style: textTheme.bodySmall),
                                        //   ],
                                        // ),
                                        SizedBox(height: 16.h),
                                        CustomElevatedButton(
                                          width: 122.h,
                                          height: 33.v,
                                          text: 'View Profile',
                                          buttonTextStyle: textTheme.titleSmall,
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                AppRoutes.sellerInfoScreen);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                SizedBox(height: 52.v),
              ],
            ),
          )),
    );
  }

  String getFilterName(int index) {
    switch (index) {
      case 1:
        return 'Payment Status';
      case 2:
        return 'Month';
      default:
        return '';
    }
  }

  ListTile _buildConnectionItem(Connection items, TextTheme textTheme) {
    return ListTile(
      onTap: () {},
      contentPadding: const EdgeInsets.all(0),
      leading: CustomImageView(
        height: 50.h,
        width: 50.h,
        radius: BorderRadius.circular(50.h),
        imagePath: items.profileImg,
      ),
      trailing: CustomImageView(
        imagePath: ImageConstant.chatIcon,
      ),
      title: Text(
        items.name,
        style: textTheme.titleMedium,
      ),
      // subtitle: Row(
      //   children: [
      //     Text(
      //       'Product Category- ',
      //       style: textTheme.bodySmall,
      //     ),
      //     Text(
      //       items.category,
      //       style: textTheme.bodySmall!.copyWith(color: AppColor.blackColor),
      //     ),
      //   ],
      // ),
    );
  }

  PreferredSize customAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(SizeUtils.width, 60.h),
      child: AppBar(
        elevation: 5,
        automaticallyImplyLeading: false,
        toolbarHeight: 50.h,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.h),
          bottomRight: Radius.circular(32.h),
        )),
        backgroundColor: const Color(0xFFF9F9F9),
        centerTitle: true,
        leadingWidth: 70.h,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.h),
          child: Builder(builder: (context) {
            return CustomIconButton(
                icon: ImageConstant.menu,
                onTap: () {
                  Scaffold.of(context).openDrawer();
                });
          }),
        ),
        title: CustomImageView(
          width: 98.h,
          imagePath: ImageConstant.logo,
        ),
        actions: [
          CustomIconButton(
            icon: ImageConstant.bellIcon,
            onTap: () async {
              Navigator.of(context).pushNamed(AppRoutes.notificationsScreen);
            },
          ),
          SizedBox(width: 8.h),
          CustomIconButton(
            icon: ImageConstant.message,
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.chatsScreen);
            },
          ),
          SizedBox(width: 8.h),
        ],
      ),
    );
  }
}

class PromotionProductCard extends StatelessWidget {
  final Product product;

  const PromotionProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(AppRoutes.productDetailScreen, arguments: product.id);
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.offWhite,
            borderRadius: BorderRadius.circular(12.h)),
        width: 200.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageView(
              height: 185.v,
              width: SizeUtils.width,
              radius: BorderRadius.circular(12.h),
              imagePath: product.images.isEmpty
                  ? ImageConstant.imageNotFound
                  : product.images[0].imagePath,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 4.v),
            Text(
              product.productName,
              style: textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.v),
            Text(
              'by ${product.user.name}',
              style: textTheme.bodySmall,
            ),
            SizedBox(height: 4.v),
            Row(
              children: [
                Text(
                  'Category- ',
                  style: textTheme.bodySmall,
                ),
                Text(
                  "${product.category.name}",
                  style: textTheme.titleMedium!.copyWith(fontSize: 12.fSize),
                ),
              ],
            ),
            SizedBox(height: 4.v),
            Row(
              children: [
                Text(
                  'Promotion Pricing- ',
                  style: textTheme.bodySmall,
                ),
                Expanded(
                  child: Text(
                    '₹${product.price}',
                    style: textTheme.titleMedium!.copyWith(fontSize: 12.fSize),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.v),
            Center(
              child: CustomElevatedButton(
                height: 26.v,
                text: product.isAsked ? 'Requested' : "Ask for Promotion",
                buttonTextStyle: textTheme.titleSmall,
                onPressed: () {
                  context
                      .read<ProductBloc>()
                      .add(AskForPromotionEvent(product.id));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
