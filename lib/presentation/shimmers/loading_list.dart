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
        baseColor: Colors.grey.shade300,
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
