import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/models/post_model/post_model.dart';

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
          Visibility(
            visible: post.isVideo,
            child: Container(
              padding: EdgeInsets.all(5.h),
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: const Icon(Icons.play_arrow),
            ),
          )
        ],
      ),
    );
  }
}
