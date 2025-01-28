import '../core/app_export.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({super.key, required this.isVisible, this.onTap});

  final bool isVisible;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(5.h),
          decoration:
              const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: const Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}
