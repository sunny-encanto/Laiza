import 'package:shimmer/shimmer.dart';

import '../../core/app_export.dart';

class LoadingGridScreen extends StatelessWidget {
  final double? radius;

  const LoadingGridScreen({super.key, this.radius});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade100,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          padding: const EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 185.h / 180.v,
            crossAxisCount: 2,
            crossAxisSpacing: 10.h,
            mainAxisSpacing: 10.v,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius ?? 8.0),
                color: Colors.white,
              ),
            );
          }),
    );
  }
}
