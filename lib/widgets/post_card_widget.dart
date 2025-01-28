import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/post_model/post_model.dart';
import 'package:laiza/widgets/play_button.dart';

class PostCardWidget extends StatelessWidget {
  final Post post;

  const PostCardWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 185.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomImageView(
            height: 261.v,
            width: 185.h,
            fit: BoxFit.fill,
            radius: BorderRadius.circular(6.h),
            imagePath: post.url,
          ),
          PlayButton(isVisible: post.isVideo)
        ],
      ),
    );
  }
}
