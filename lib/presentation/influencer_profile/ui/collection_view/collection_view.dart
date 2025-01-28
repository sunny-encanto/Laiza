import 'package:laiza/core/app_export.dart';

class CollectionViewScreen extends StatelessWidget {
  const CollectionViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        // will come from previous screen
        title: Row(
          children: [
            CustomImageView(
              onTap: () {},
              height: 30.v,
              width: 30.h,
              radius: BorderRadius.circular(30.h),
              imagePath: ImageConstant.reelImg,
            ),
            SizedBox(width: 8.h),
            Text(
              'Skin Care',
              style: textTheme.titleMedium,
            ),
          ],
        ),
        actions: const [Icon(Icons.more_vert)],
      ),
      // will Show based on previous screen
      //TODO: Need To Uncomment
      // body: GridView.builder(
      //   padding: EdgeInsets.all(20.h),
      //   shrinkWrap: true,
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //       crossAxisSpacing: 12.h,
      //       childAspectRatio: 170.v / 320.h,
      //       crossAxisCount: 2),
      //   itemCount: imagesList.length,
      //   itemBuilder: (context, index) => Padding(
      //     padding: EdgeInsets.only(top: index.isEven ? 30.v : 0),
      //     child: ProductCardWidget(product: ),
      //   ),
      // ),
    );
  }
}
