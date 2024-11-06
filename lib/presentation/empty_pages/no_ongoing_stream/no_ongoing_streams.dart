import '../../../core/app_export.dart';

class NoOngoingStreamsScreen extends StatelessWidget {
  const NoOngoingStreamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: CustomImageView(
            width: SizeUtils.width - 200.v,
            imagePath: ImageConstant.noOnGoing,
          ),
        ),
        SizedBox(height: 10.v),
        Text(
          'No Ongoing Streams',
          style: textTheme.titleMedium!
              .copyWith(fontSize: 18.fSize, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
