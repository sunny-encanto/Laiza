import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/blocs/product_bloc/product_bloc.dart';
import 'package:laiza/data/models/product_model/product.dart';

class ProductCardWidget extends StatelessWidget {
  final Product product;

  const ProductCardWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(AppRoutes.productDetailScreen, arguments: product.id);
      },
      child: SizedBox(
        width: 185.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageView(
              height: 185.v,
              width: 185.h,
              fit: BoxFit.fill,
              radius: BorderRadius.circular(6.h),
              imagePath: product.productImage,
            ),
            SizedBox(height: 4.v),
            Text(
              product.productName,
              style: textTheme.titleMedium,
              maxLines: 1,
            ),
            SizedBox(height: 2.v),
            Row(
              children: [
                Text(
                  '₹${product.mrp}',
                  style: textTheme.bodySmall!
                      .copyWith(decoration: TextDecoration.lineThrough),
                ),
                SizedBox(width: 5.h),
                Text(
                  '₹${product.finalPrice}',
                  style: textTheme.titleMedium,
                ),
              ],
            ),
            SizedBox(height: 8.v),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          AppRoutes.productDetailScreen,
                          arguments: product.id);
                    },
                    height: 26.v,
                    text: 'Buy Now',
                    buttonTextStyle: TextStyle(fontSize: 12.fSize),
                  ),
                ),
                SizedBox(width: 5.h),
                IconButton(
                    onPressed: () {
                      context
                          .read<ProductBloc>()
                          .add(ToggleWishListEvent(product.id));
                    },
                    icon: Icon(
                      product.isAddedToWishlist
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: product.isAddedToWishlist
                          ? Colors.red
                          : AppColor.primary,
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
