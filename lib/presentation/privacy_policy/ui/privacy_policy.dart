import 'package:laiza/core/app_export.dart';

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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Privacy Policy",
              style: textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              "Effective Date: October 1, 2024",
              style: textTheme.titleMedium!,
            ),
            const SizedBox(height: 16),
            Text(
              "Introduction",
              style: textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              "Welcome to Dawa Bajar! This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application. Please read this privacy policy carefully. If you do not agree with the terms of this privacy policy, please do not access the application.",
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            Text(
              "Information We Collect",
              style: textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              "We may collect information about you in a variety of ways. The information we may collect via the app includes:",
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            Text(
              "1. Personal Data: Personally identifiable information, such as your name, email address, and phone number, that you voluntarily give to us.",
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            Text(
              "2. Usage Data: Information about your device and app usage such as IP address, browser type, operating system, and the pages you visit.",
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            Text(
              "How We Use Your Information",
              style: textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              "We use the information we collect in the following ways:",
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              "1. To provide, maintain, and improve our app.",
              style: textTheme.bodySmall,
            ),
            Text(
              "2. To communicate with you about updates or customer support.",
              style: textTheme.bodySmall,
            ),
            Text(
              "3. To enforce our terms, conditions, and policies.",
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            Text(
              "Sharing Your Information",
              style: textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              "We may share your information in the following situations:",
              style: textTheme.titleMedium,
            ),
            Text(
              "1. With third-party vendors and service providers to assist us in providing our services.",
              style: textTheme.bodySmall,
            ),
            Text(
              "2. If required by law or to protect our legal rights.",
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            Text(
              "Changes to This Privacy Policy",
              style: textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              "We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.",
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            Text(
              "Contact Us",
              style: textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              "If you have any questions or concerns about this Privacy Policy, please contact us at support@Laiza.com.",
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
