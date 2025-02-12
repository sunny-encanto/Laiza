import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/product_model/product.dart';

class ProductView extends StatelessWidget {
  final List<Product> products;

  const ProductView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    // TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15.h),
        products.isEmpty
            ? const Center(
                child: Text('No Data Found'),
              )
            : GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 12.h,
                    childAspectRatio: 175.v / 320.h,
                    crossAxisCount: 2),
                itemCount: products.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(top: index.isEven ? 30.v : 0),
                  child: ProductCardWidget(product: products[index]),
                ),
              ),
        SizedBox(height: 24.v),
        // SizedBox(height: 24.v),
        // Row(
        //   children: [
        //     Expanded(
        //       child: CustomTextFormField(
        //         prefixConstraints: BoxConstraints(maxWidth: 25.h),
        //         prefix: Padding(
        //           padding: EdgeInsets.only(left: 10.h),
        //           child: CustomImageView(
        //             width: 15.h,
        //             imagePath: ImageConstant.searchIcon,
        //           ),
        //         ),
        //         hintText: 'Search for  398 Post',
        //       ),
        //     ),
        //     SizedBox(width: 16.h),
        //     CustomIconButton(
        //       icon: ImageConstant.menuIcon,
        //       onTap: () {},
        //     ),
        //   ],
        // ),
        // SizedBox(height: 24.v),
        // Text(
        //   'Trending Products',
        //   style: textTheme.titleMedium,
        // ),
        // SizedBox(height: 12.v),
        // SizedBox(
        //   height: 300.v,
        //   child: ListView.builder(
        //     scrollDirection: Axis.horizontal,
        //     itemCount: imagesList.length,
        //     itemBuilder: (context, index) => Padding(
        //       padding: EdgeInsets.only(right: 24.h),
        //       child: ProductCardWidget(image: imagesList[index]),
        //     ),
        //   ),
        // ),
        // SizedBox(height: 36.v),
        // Text(
        //   'Product Sets',
        //   style: textTheme.titleMedium,
        // ),
        // SizedBox(height: 8.v),
        // SizedBox(
        //   height: 185.v,
        //   child: ListView.builder(
        //     itemCount: imagesList.length,
        //     scrollDirection: Axis.horizontal,
        //     itemBuilder: (context, index) => Padding(
        //       padding: EdgeInsets.only(right: 12.h),
        //       child: InkWell(
        //         onTap: () {
        //           Navigator.of(context)
        //               .pushNamed(AppRoutes.collectionViewScreen);
        //         },
        //         child: Container(
        //           padding: EdgeInsets.all(8.h),
        //           // width: 125.h,
        //           height: 167.v,
        //           decoration: BoxDecoration(
        //               color: AppColor.offWhite,
        //               borderRadius: BorderRadius.circular(6.h)),
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Row(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   CustomImageView(
        //                     width: 61.h,
        //                     height: 117.v,
        //                     fit: BoxFit.fill,
        //                     imagePath: imagesList[0],
        //                   ),
        //                   SizedBox(width: 2.h),
        //                   Column(
        //                     mainAxisAlignment: MainAxisAlignment.start,
        //                     children: [
        //                       CustomImageView(
        //                         width: 52.h,
        //                         height: 52.v,
        //                         fit: BoxFit.fill,
        //                         imagePath: imagesList[1],
        //                       ),
        //                       SizedBox(height: 2.v),
        //                       CustomImageView(
        //                         width: 52.h,
        //                         height: 62.v,
        //                         fit: BoxFit.fill,
        //                         imagePath: imagesList[2],
        //                       ),
        //                     ],
        //                   )
        //                 ],
        //               ),
        //               SizedBox(height: 4.v),
        //               Text(
        //                 'Skin Care',
        //                 style: textTheme.titleMedium,
        //               ),
        //               SizedBox(height: 2.v),
        //               Text(
        //                 '4 Post',
        //                 style: textTheme.bodySmall,
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        // SizedBox(height: 24.v),
        // Text(
        //   'Recent Posts',
        //   style: textTheme.titleMedium,
        // ),
        // SizedBox(height: 4.v),
        // Text(
        //   '398 Posts',
        //   style: textTheme.bodySmall,
        // ),
      ],
    );
  }
}
