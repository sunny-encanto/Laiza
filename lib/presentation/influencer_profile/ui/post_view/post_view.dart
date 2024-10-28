import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/post_model/post_model.dart';

import '../../../../widgets/post_card_widget.dart';

class PostView extends StatelessWidget {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24.v),
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                prefixConstraints: BoxConstraints(maxWidth: 25.h),
                prefix: Padding(
                  padding: EdgeInsets.only(left: 10.h),
                  child: CustomImageView(
                    width: 15.h,
                    imagePath: ImageConstant.searchIcon,
                  ),
                ),
                hintText: 'Search for  398 Post',
              ),
            ),
            SizedBox(width: 16.h),
            CustomIconButton(
              icon: ImageConstant.menuIcon,
              onTap: () {},
            ),
          ],
        ),
        SizedBox(height: 24.v),
        Text(
          'Trending Post',
          style: textTheme.titleMedium,
        ),
        SizedBox(height: 12.v),
        SizedBox(
          height: 261.v,
          child: ListView.builder(
            itemCount: postList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(right: 24.h),
              child: PostCardWidget(post: postList[index]),
            ),
          ),
        ),
        SizedBox(height: 36.v),
        Text(
          'Collections',
          style: textTheme.titleMedium,
        ),
        SizedBox(height: 8.v),
        SizedBox(
          height: 185.v,
          child: ListView.builder(
            itemCount: imagesList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => _buildCollectionCard(context),
          ),
        ),
        SizedBox(height: 24.v),
        Text(
          'Recent Posts',
          style: textTheme.titleMedium,
        ),
        SizedBox(height: 4.v),
        Text(
          '398 Posts',
          style: textTheme.bodySmall,
        ),
        SizedBox(height: 15.h),
        GridView.custom(
          shrinkWrap: true,
          padding: const EdgeInsets.all(0),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverWovenGridDelegate.count(
            crossAxisCount: 2,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            pattern: [
              const WovenGridTile(1),
              const WovenGridTile(
                5 / 7,
                crossAxisRatio: 0.9,
                alignment: AlignmentDirectional.centerEnd,
              ),
            ],
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            childCount: postList.length,
            (context, index) => PostCardWidget(post: postList[index]),
          ),
        ),
        SizedBox(height: 24.v),
      ],
    );
  }

  Padding _buildCollectionCard(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(right: 12.h),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.collectionViewScreen);
        },
        child: Container(
          padding: EdgeInsets.all(8.h),
          // width: 125.h,
          height: 167.v,
          decoration: BoxDecoration(
              color: AppColor.offWhite,
              borderRadius: BorderRadius.circular(6.h)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                    width: 61.h,
                    height: 117.v,
                    fit: BoxFit.fill,
                    imagePath: imagesList[0],
                  ),
                  SizedBox(width: 2.h),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomImageView(
                        width: 52.h,
                        height: 52.v,
                        fit: BoxFit.fill,
                        imagePath: imagesList[1],
                      ),
                      SizedBox(height: 2.v),
                      CustomImageView(
                        width: 52.h,
                        height: 62.v,
                        fit: BoxFit.fill,
                        imagePath: imagesList[2],
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 4.v),
              Text(
                'Party Wear',
                style: textTheme.titleMedium,
              ),
              SizedBox(height: 2.v),
              Text(
                '4 Post',
                style: textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
