import 'package:flutter/material.dart';
import 'package:vigiatech/core/constants/app_colors.dart';
import 'package:vigiatech/core/constants/app_strings.dart';
import 'package:vigiatech/core/constants/app_routes.dart';

/// Settings screen - Phase 4
class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  int _selectedIndex = 2;

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle navigation based on selected index
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, AppRoutes.devices);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, AppRoutes.alerts);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.settings),
      ),
      body: ListView(
        children: [
          // Settings Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.settings,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                
                _SettingsTile(
                  icon: Icons.person_outline,
                  title: AppStrings.account,
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.account);
                  },
                ),
                const SizedBox(height: 8),
                
                _SettingsTile(
                  icon: Icons.notifications_outlined,
                  title: AppStrings.notifications,
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.notifications);
                  },
                ),
                const SizedBox(height: 8),
                
                _SettingsTile(
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                  onTap: () {
                    // TODO: Navigate to help screen
                  },
                ),
                const SizedBox(height: 8),
                
                _SettingsTile(
                  icon: Icons.info_outline,
                  title: 'About',
                  onTap: () {
                    _showAboutDialog(context);
                  },
                ),
                const SizedBox(height: 24),
                
                // Logout Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _handleLogout(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.statusCritical,
                      foregroundColor: AppColors.primaryText,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Logout'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: AppStrings.devices,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            activeIcon: Icon(Icons.notifications),
            label: AppStrings.alerts,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: AppStrings.settings,
          ),
        ],
      ),
    );
  }

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement logout logic
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.statusCritical,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: AppStrings.appName,
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(
        Icons.developer_board,
        size: 48,
        color: AppColors.accent,
      ),
      children: [
        const Text(
          'Industrial IoT Monitoring Platform for predictive maintenance.',
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, color: AppColors.secondary),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: AppColors.primaryTextDimmed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
