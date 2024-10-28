import '../../../core/app_export.dart';
import '../../../data/services/url_lancher.dart';

class HelpCentreScreen extends StatelessWidget {
  const HelpCentreScreen({super.key});

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
            _buildFAQ(
                "How do I create an account?",
                "To create an account, click on the Sign-Up button on the home screen, and follow the steps to enter your details and verify your email.",
                textTheme),
            _buildFAQ(
                "How can I reset my password?",
                "If you forgot your password, go to the login screen and click on 'Forgot Password'. You will receive a link to reset your password via email.",
                textTheme),
            _buildFAQ(
                "How do I track my order?",
                "You can track your order by going to the 'Orders' section of the app, where you can view the status and details of all your orders.",
                textTheme),
            _buildFAQ(
                "How can I contact customer support?",
                "You can reach customer support via email at support@dawabajar.com, or by calling our support number listed below.",
                textTheme),

            const SizedBox(height: 16),

            // Contact Us Section
            Text("Contact Us",
                style: textTheme.titleLarge!
                    .copyWith(fontSize: 24.fSize, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text("Email Us"),
              subtitle: const Text("support@Liza.com"),
              onTap: () {
                _launchEmail();
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text("Call Us"),
              subtitle: const Text("+91 12345 67890"),
              onTap: () {
                _launchPhone();
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text("Visit Our Website"),
              subtitle: const Text("www.Liza.com"),
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

  // Helper function to build FAQ items
  Widget _buildFAQ(String question, String answer, TextTheme textTheme) {
    return ExpansionTile(
      title: Text(
        question,
        style: textTheme.titleMedium,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            answer,
            style: textTheme.bodySmall,
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
      path: '+911234567890',
    );

    await launchURL(phoneUri);
  }

  // Function to open website
  void _launchWebsite() async {
    final Uri websiteUri = Uri.parse('https://flutter.dev');
    await launchURL(websiteUri);
  }
}
