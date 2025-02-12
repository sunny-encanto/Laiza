import 'package:laiza/core/app_export.dart';
import 'package:laiza/data/services/firebase_services.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Settings',
          style: textTheme.titleMedium!.copyWith(fontSize: 18.fSize),
        ),
      ),
      body: ListView(
        children: [
          // Account Section
          SettingsSection(
            title: 'Account',
            tiles: [
              SettingsTile(
                title: 'Privacy Policy',
                icon: Icons.security,
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.privacyPolicyScreen);
                },
              ),
              SettingsTile(
                title: 'Change Password',
                icon: Icons.lock,
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(AppRoutes.changePasswordScreen);
                },
              ),
              SettingsTile(
                title: 'Delete Account',
                icon: Icons.delete,
                onTap: () {
                  _showConfirmationDialog(context);
                },
              ),
            ],
          ),

          // // Notifications Section
          // SettingsSection(
          //   title: 'Notifications',
          //   tiles: [
          //     SwitchSettingsTile(
          //       title: 'Push Notifications',
          //       icon: Icons.notifications,
          //       value: true,
          //       onChanged: (value) {
          //         // Handle toggle
          //       },
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm Deletion',
            style: textTheme.titleLarge,
          ),
          content: Text(
            'Once you delete your account, all your data will be lost. Do you wish to continue?',
            style: textTheme.bodySmall,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<UserRepository>().deleteUser();
                FirebaseServices.handleLogOut(context);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> tiles;

  const SettingsSection({
    super.key,
    required this.title,
    required this.tiles,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16.0.v),
          child: Text(
            title,
            style: textTheme.titleMedium,
          ),
        ),
        ...tiles,
      ],
    );
  }
}

class SettingsTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const SettingsTile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}

class SwitchSettingsTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SwitchSettingsTile({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
