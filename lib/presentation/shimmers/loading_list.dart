import 'package:shimmer/shimmer.dart';

import '../../core/app_export.dart';
import 'placeholders/placeholder.dart';

class LoadingListPage extends StatefulWidget {
  const LoadingListPage({super.key});

  @override
  State<LoadingListPage> createState() => _LoadingListPageState();
}

class _LoadingListPageState extends State<LoadingListPage> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade100,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: List.generate(
              2,
              (index) => Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 20.0.v),
                  const ContentPlaceholder(
                    lineType: ContentLineType.threeLines,
                  ),
                  SizedBox(height: 20.0.v),
                  const ContentPlaceholder(
                    lineType: ContentLineType.threeLines,
                  ),
                  SizedBox(height: 20.0.v),
                  const ContentPlaceholder(
                    lineType: ContentLineType.threeLines,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class HorizontalLoadingListPage extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;

  const HorizontalLoadingListPage(
      {super.key, this.height, this.width, this.radius});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade100,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: SizedBox(
            height: height ?? 250.v,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Container(
                margin: EdgeInsets.only(right: 10.h, bottom: 15.v),
                width: width ?? 250.h,
                height: 130.v,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius ?? 8.0),
                  color: Colors.white,
                ),
              ),
            )));
  }
}
