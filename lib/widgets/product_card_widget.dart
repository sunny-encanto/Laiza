import 'package:laiza/core/app_export.dart';

class ProductCardWidget extends StatelessWidget {
  final String image;
  const ProductCardWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: 185.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            height: 185.v,
            width: 185.h,
            fit: BoxFit.fill,
            radius: BorderRadius.circular(6.h),
            imagePath: image,
          ),
          SizedBox(height: 4.v),
          Text(
            "Women's Mid Rise 725 Bootcut Jeans",
            style: textTheme.titleMedium,
          ),
          SizedBox(height: 2.v),
          Row(
            children: [
              Text(
                '₹ 5,999',
                style: textTheme.bodySmall!
                    .copyWith(decoration: TextDecoration.lineThrough),
              ),
              Text(
                '₹ ₹ 2,799',
                style: textTheme.bodySmall,
              ),
            ],
          ),
          SizedBox(height: 8.v),
          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  height: 26.v,
                  text: 'Buy Now',
                  buttonTextStyle: TextStyle(fontSize: 12.fSize),
                ),
              ),
              SizedBox(width: 5.h),
              const Icon(Icons.favorite_border)
            ],
          ),
        ],
      ),
    );
  }
}
