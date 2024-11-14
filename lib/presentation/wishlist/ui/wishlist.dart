import 'package:laiza/data/models/wishlist_model/wishlist_model.dart';
import 'package:laiza/presentation/shimmers/loading_list.dart';

import '../../../core/app_export.dart';
import '../../empty_pages/empty_wishlist/empty_wishlist.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wishlist',
          style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
        ),
      ),
      body: BlocBuilder<WishlistBloc, WishlistState>(
        builder: (context, state) {
          if (state is WishlistInitial) {
            context.read<WishlistBloc>().add(FetchWishListsEvent());
            return const LoadingListPage();
          } else if (state is WishlistLoadingState) {
            return const LoadingListPage();
          } else if (state is WishlistLoadedState) {
            return state.items.isEmpty
                ? const EmptyWishlistScreen()
                : ListView.builder(
                    padding: EdgeInsets.all(20.h),
                    itemCount: state.items.length,
                    itemBuilder: (context, index) =>
                        _buildItems(state.items[index], context),
                  );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  SizedBox _buildItems(Wishlist item, BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
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
              imagePath: item.thumbnail,
            ),
            SizedBox(width: 5.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: textTheme.bodySmall,
                  ),
                  SizedBox(height: 8.v),
                  Text(
                    '₹${item.price}',
                    style: textTheme.titleMedium,
                  ),
                  SizedBox(height: 12.v),
                  Row(
                    children: [
                      CustomElevatedButton(
                        width: 104.h,
                        height: 28.h,
                        text: 'Buy Now',
                        buttonTextStyle:
                            textTheme.titleSmall!.copyWith(fontSize: 12.fSize),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              AppRoutes.productDetailScreen,
                              arguments: item.id);
                        },
                      ),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            context
                                .read<WishlistBloc>()
                                .add(RemoveWishListsItemEvent(item.id));
                          },
                          child: Text(
                            'Remove',
                            style: textTheme.bodySmall!
                                .copyWith(color: AppColor.redColor),
                          ))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
