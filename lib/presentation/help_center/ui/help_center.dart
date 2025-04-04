import 'package:laiza/data/blocs/faq_bloc/faq_bloc.dart';
import 'package:laiza/data/models/faq_model/faq_model.dart';
import 'package:laiza/presentation/help_center/cubit/faq_cubit.dart';

import '../../../core/app_export.dart';
import '../../../data/repositories/help_center_repository/help_center_repository.dart';
import '../../../data/services/url_lancher.dart';

class HelpCentreScreen extends StatelessWidget {
  HelpCentreScreen({super.key});

  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Centre',
            style: textTheme.titleMedium!.copyWith(fontSize: 20.fSize)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Help Centre",
              style: textTheme.titleLarge!
                  .copyWith(fontSize: 24.fSize, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Frequently Asked Questions Section
            Text(
              "Frequently Asked Questions (FAQs)",
              style: textTheme.titleLarge!.copyWith(fontSize: 20.fSize),
            ),
            const SizedBox(height: 8),
            MultiBlocProvider(
              // create: (context) =>
              //     FaqBloc(context.read<HelpCenterRepository>()),
              providers: [
                BlocProvider(create: (context) => FaqCubit()),
                BlocProvider(
                    create: (context) =>
                        FaqBloc(context.read<HelpCenterRepository>())),
              ],
              child: BlocBuilder<FaqBloc, FaqState>(
                builder: (context, state) {
                  if (state is FaqInitial) {
                    context.read<FaqBloc>().add(FetchFAQ());
                  } else if (state is FaqLoading) {
                    return const SizedBox.shrink();
                  } else if (state is FaqError) {
                    return Center(child: Text(state.message));
                  } else if (state is FaqLoaded) {
                    List list = state.faqs;
                    return BlocConsumer<FaqCubit, int?>(
                      listener: (context, state) => _expandedIndex = state,
                      builder: (context, state) {
                        return Column(
                          children: List.generate(
                            list.length,
                            (index) {
                              FAQ faq = list[index];
                              return _buildFAQ(faq.question, faq.answer,
                                  textTheme, index, context);
                            },
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),

            const SizedBox(height: 16),

            // Contact Us Section
            Text("Contact Us",
                style: textTheme.titleLarge!
                    .copyWith(fontSize: 24.fSize, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text("Email Us"),
              subtitle: const Text("support@laiza.live"),
              onTap: () {
                _launchEmail();
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text("Call Us"),
              subtitle: const Text("+917021356804"),
              onTap: () {
                _launchPhone();
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text("Visit Our Website"),
              subtitle: const Text("https://laiza.live"),
              onTap: () {
                _launchWebsite();
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQ(String question, String answer, TextTheme textTheme,
      int index, BuildContext context) {
    return ExpansionTile(
      iconColor: AppColor.primary,
      key: Key(index.toString()),
      initiallyExpanded: _expandedIndex == index,
      onExpansionChanged: (isExpanded) {
        context.read<FaqCubit>().expandFAQ(index);
      },
      title: Text(question, style: textTheme.titleMedium),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              answer,
              style: textTheme.bodySmall,
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  void _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@laiza.com',
      query:
          'subject=Help%20Needed&body=Hi%20Support%20Team,', // Optional: subject and body
    );
    await launchURL(emailUri);
  }

  // Function to open phone dialer
  void _launchPhone() async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: '+917021356804',
    );

    await launchURL(phoneUri);
  }

  // Function to open website
  void _launchWebsite() async {
    final Uri websiteUri = Uri.parse('https://laiza.live');
    await launchURL(websiteUri);
  }
}
