import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:laiza/core/app_export.dart';
import 'package:laiza/presentation/privacy_policy/ui/bloc/privacy_policy_bloc.dart';

class TermsAndServices extends StatelessWidget {
  const TermsAndServices({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Terms and conditions ',
            style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PrivacyPolicyBloc, PrivacyPolicyState>(
              builder: (context, state) {
            if (state is PrivacyPolicyInitial) {
              context
                  .read<PrivacyPolicyBloc>()
                  .add(FetchTermsAndConditionsEvent());
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

class ResponsibleDisclosurePolicy extends StatelessWidget {
  const ResponsibleDisclosurePolicy({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Responsible Disclosure Policy',
            style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PrivacyPolicyBloc, PrivacyPolicyState>(
              builder: (context, state) {
            if (state is PrivacyPolicyInitial) {
              context
                  .read<PrivacyPolicyBloc>()
                  .add(FetchResponsibleDisclosurePolicyEvent());
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

class AntiPhishingPolicy extends StatelessWidget {
  const AntiPhishingPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Anti Phishing Policy',
            style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PrivacyPolicyBloc, PrivacyPolicyState>(
              builder: (context, state) {
            if (state is PrivacyPolicyInitial) {
              context
                  .read<PrivacyPolicyBloc>()
                  .add(FetchAntiPhishingPolicyEvent());
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

class IntellectualPropertyPolicyScreen extends StatelessWidget {
  const IntellectualPropertyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Intellectual Property Policy',
            style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PrivacyPolicyBloc, PrivacyPolicyState>(
              builder: (context, state) {
            if (state is PrivacyPolicyInitial) {
              context
                  .read<PrivacyPolicyBloc>()
                  .add(IntellectualPropertyPolicyEvent());
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

class RefundReplacementPolicy extends StatelessWidget {
  const RefundReplacementPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Refund Replacement Policy',
            style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PrivacyPolicyBloc, PrivacyPolicyState>(
              builder: (context, state) {
            if (state is PrivacyPolicyInitial) {
              context
                  .read<PrivacyPolicyBloc>()
                  .add(RefundReturnReplacementPolicyEvent());
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

class CancellationRefundPolicyScreen extends StatelessWidget {
  const CancellationRefundPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Refund Replacement Policy',
            style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PrivacyPolicyBloc, PrivacyPolicyState>(
              builder: (context, state) {
            if (state is PrivacyPolicyInitial) {
              context
                  .read<PrivacyPolicyBloc>()
                  .add(LaizaCancellationRefundPolicyEvent());
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

class ThirdPartyFunctionalities extends StatelessWidget {
  const ThirdPartyFunctionalities({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Third Party Functionalities',
            style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<PrivacyPolicyBloc, PrivacyPolicyState>(
              builder: (context, state) {
            if (state is PrivacyPolicyInitial) {
              context
                  .read<PrivacyPolicyBloc>()
                  .add(ThirdPartyFunctionalitiesEvent());
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
