import 'package:laiza/core/app_export.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Filter and Discover',
          style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          children: [
            SizedBox(
              height: 46.v,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(right: 12.h),
                  child: index == 0
                      ? Chip(
                          backgroundColor: AppColor.primary,
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.menuIcon,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5.h),
                              Text(
                                'Filters',
                                style: textTheme.bodySmall!
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          ))
                      : Chip(
                          shape: StadiumBorder(
                              side: BorderSide(color: AppColor.primary)),
                          backgroundColor: Colors.white,
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Product',
                                style: textTheme.bodySmall!
                                    .copyWith(color: AppColor.primary),
                              ),
                              SizedBox(width: 5.h),
                              Icon(
                                Icons.arrow_drop_down,
                                color: AppColor.primary,
                              )
                            ],
                          )),
                ),
              ),
            ),
            SizedBox(height: 20.v),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Clear all filters',
                style: textTheme.titleMedium!
                    .copyWith(decoration: TextDecoration.underline),
              ),
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(20.h),
        child: const CustomElevatedButton(text: 'Apply Filters'),
      ),
    );
  }
}
