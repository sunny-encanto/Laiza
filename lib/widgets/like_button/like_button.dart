import 'package:laiza/data/repositories/reel_repository/reel_repository.dart';
import 'package:laiza/widgets/like_button/bloc/like_button_bloc.dart';

import '../../core/app_export.dart';

class LikeButton extends StatelessWidget {
  final bool isLiked;
  final VoidCallback onTap;

  const LikeButton({super.key, required this.isLiked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LikeButtonBloc(context.read<ReelRepository>()),
      child: BlocConsumer<LikeButtonBloc, LikeButtonState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LikeButtonPressState) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(12)),
              child: IconButton(
                  onPressed: () {
                    // context
                    //     .read<LikeButtonBloc>()
                    //     .add(LikeButtonPressEvent(!state.isLIked));
                  },
                  icon: Icon(
                    state.isLIked
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color: state.isLIked ? Colors.red : Colors.white,
                  )),
            );
          }
          return Container(
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(12)),
            child: IconButton(
                onPressed: () {
                  // context
                  //     .read<LikeButtonBloc>()
                  //     .add(LikeButtonPressEvent(!isLiked));
                },
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border_outlined,
                  color: isLiked ? Colors.red : Colors.white,
                )),
          );
        },
      ),
    );
  }
}
