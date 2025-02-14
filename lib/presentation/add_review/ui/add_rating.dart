import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/presentation/add_review/bloc/add_rating_bloc.dart';

class AddRatingScreen extends StatelessWidget {
  final int productId;

  AddRatingScreen({super.key, required this.productId});

  double rating = 1;
  final ratingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Rating',
          style: textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildItem(textTheme, context),
            Text('Rate Product', style: textTheme.titleMedium),
            SizedBox(height: 12.v),
            Container(
              height: 123.v,
              decoration: BoxDecoration(
                  color: AppColor.offWhite,
                  borderRadius: BorderRadius.circular(6.h)),
              child: RatingBar(
                alignment: Alignment.center,
                filledIcon: Icons.star,
                emptyIcon: Icons.star_border,
                onRatingChanged: (value) {
                  rating = value;
                  print(value);
                  print(rating);
                },
                initialRating: 1,
                maxRating: 5,
              ),
            ),
            SizedBox(height: 28.v),
            Text('Tell Us About Your Experience', style: textTheme.titleMedium),
            SizedBox(height: 12.v),
            CustomTextFormField(
              controller: ratingController,
              hintText: 'Add your review',
              maxLines: 8,
              maxLength: 250,
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.all(20.h),
        child: BlocConsumer<AddRatingBloc, AddRatingState>(
          listener: (context, state) {
            if (state is AddRatingError) {
              context.showSnackBar(state.message);
            } else if (state is AddRatingSuccess) {
              context.showSnackBar(state.message);
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            return CustomElevatedButton(
              isLoading: state is AddRatingLoading,
              text: 'Submit',
              onPressed: () {
                context.read<AddRatingBloc>().add(AddRatingRequestEvent(
                    productId: productId,
                    rating: rating.round(),
                    review: ratingController.text));
              },
            );
          },
        ),
      ),
    );
  }

  SizedBox _buildItem(TextTheme textTheme, BuildContext context) {
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
              imagePath:
                  'https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350',
            ),
            SizedBox(width: 5.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Classic  Sneakers – Minimalist Design, Maximum Comfort',
                    style: textTheme.bodySmall,
                  ),
                  SizedBox(height: 8.v),
                  Row(
                    children: [
                      Text(
                        'Status-',
                        style: textTheme.bodySmall,
                      ),
                      SizedBox(width: 5.v),
                      Text(
                        'Shipped',
                        style: textTheme.bodySmall!
                            .copyWith(color: AppColor.primary),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.v),
                  Text(
                    '₹ 2,799',
                    style: textTheme.titleMedium,
                  ),
                  SizedBox(height: 12.v),
                  CustomElevatedButton(
                    height: 28.v,
                    width: 150.h,
                    text: 'Download Invoice',
                    buttonTextStyle: TextStyle(
                        fontSize: 10.fSize, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12.v),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
