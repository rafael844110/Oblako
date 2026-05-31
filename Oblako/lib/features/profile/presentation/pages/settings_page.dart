import 'package:flutter/material.dart';

import 'dart:io';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Default settings values
  ThemeMode _themeMode = ThemeMode.system;
  String _language = 'en';
  String _unitSystem = 'metric';
  bool _dataSavingMode = false;
  bool _pushNotificationsEnabled = true;
  bool _emailNotificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 16),

              // Account settings
              _buildSectionHeader('Account Settings'),
              _buildAccountSettings(),

              const SizedBox(height: 16),

              // App settings
              _buildSectionHeader('App Settings'),
              _buildAppSettings(),

              const SizedBox(height: 16),

              // Notification settings
              _buildSectionHeader('Notification Settings'),
              _buildNotificationSettings(),

              const SizedBox(height: 16),

              // Logout and delete account
              _buildDangerZone(),

              const SizedBox(height: 32),

              // App version
              Center(
                child: Text(
                  'Version: 1.0.0',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              const SizedBox(height: kToolbarHeight),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildAccountSettings() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Change password
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text('Password'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),

          const Divider(height: 1),

          // Email verification
          // Email verification placeholder - assuming verified for mock
          const ListTile(
            leading: Icon(Icons.verified_user_outlined),
            title: Text('Email Verification'),
            subtitle: Text('Verified'), // Mocked as verified
            trailing: Icon(Icons.check_circle, color: Colors.green),
          ),
        ],
      ),
    );
  }

  Widget _buildAppSettings() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Theme
          ListTile(
            leading: const Icon(Icons.brightness_6_outlined),
            title: const Text('Theme'),
            trailing: DropdownButton<ThemeMode>(
              value: _themeMode,
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Light'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Dark'),
                ),
              ],
              onChanged: (ThemeMode? value) {
                if (value != null) {
                  setState(() {
                    _themeMode = value;
                  });
                }
              },
            ),
          ),

          const Divider(height: 1),

          // Language
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            trailing: DropdownButton<String>(
              value: _language,
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(
                  value: 'en',
                  child: Text('English'),
                ),
                DropdownMenuItem(
                  value: 'ru',
                  child: Text('Russian'),
                ),
                DropdownMenuItem(
                  value: 'ky',
                  child: Text('Kyrgyz'),
                ),
              ],
              onChanged: (String? value) {
                if (value != null) {
                  setState(() {
                    _language = value;
                  });
                }
              },
            ),
          ),

          const Divider(height: 1),

          // Data saving mode
          ListTile(
            leading: const Icon(Icons.data_saver_off),
            title: const Text('Data Storage Mode'),
            subtitle: const Text('Save traffic and resources'),
            trailing: Switch(
              value: _dataSavingMode,
              onChanged: (bool value) {
                setState(() {
                  _dataSavingMode = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationSettings() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text('Push Notifications'),
            trailing: Switch(
              value: _pushNotificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _pushNotificationsEnabled = value;
                });
              },
            ),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.email_outlined),
            title: const Text('Email Notifications'),
            trailing: Switch(
              value: _emailNotificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _emailNotificationsEnabled = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDangerZone() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.red.shade50,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Danger Zone',
              style: TextStyle(
                color: Colors.red.shade800,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.delete_forever, color: Colors.red.shade800),
            title: Text(
              'Delete Account',
              style: TextStyle(color: Colors.red.shade800),
            ),
            onTap: () => _showDeleteAccountDialog(),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Are you sure you want to delete your account? This action is irreversible.',
                style: TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Enter password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Implement account deletion
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Account deleted!')),
                );
              },
              child: const Text(
                'Delete Account',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
