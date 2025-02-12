import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/presentation/privacy_policy/ui/bloc/privacy_policy_bloc.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Privacy Policy',
            style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PrivacyPolicyBloc, PrivacyPolicyState>(
              builder: (context, state) {
            if (state is PrivacyPolicyInitial) {
              context.read<PrivacyPolicyBloc>().add(FetchPrivacyPolicyEvent());
            } else if (state is PrivacyPolicyLading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PrivacyPolicyError) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is PrivacyPolicyLoaded) {
              return SingleChildScrollView(
                child: HtmlWidget(
                  state.privacyPolicy,
                  textStyle: const TextStyle(fontSize: 18),
                  renderMode: RenderMode.column,
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        ));
  }
}
