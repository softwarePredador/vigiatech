import 'package:flutter/material.dart';
import 'package:vigiatech/core/constants/app_colors.dart';
import 'package:vigiatech/core/constants/app_strings.dart';
import 'package:vigiatech/core/constants/app_routes.dart';
import 'package:vigiatech/models/alert.dart';

/// Alerts & Settings screen - Phase 4
class AlertsView extends StatefulWidget {
  const AlertsView({super.key});

  @override
  State<AlertsView> createState() => _AlertsViewState();
}

class _AlertsViewState extends State<AlertsView> {
  int _selectedIndex = 1;

  // Mock data - TODO: Replace with real data from backend
  final List<Alert> _alerts = [
    Alert(
      id: '1',
      machineId: '3',
      machineName: 'Machine 3',
      title: 'Elevated vibration detected',
      message: 'Vibration level exceeded threshold on Machine 3',
      timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
      isRead: false,
    ),
    Alert(
      id: '2',
      machineId: '1',
      machineName: 'Machine 1',
      title: 'Maintenance reminder',
      message: 'Scheduled maintenance due for Machine 1',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      isRead: true,
    ),
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle navigation based on selected index
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, AppRoutes.devices);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, AppRoutes.settings);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.alerts),
      ),
      body: _alerts.isEmpty
          ? _buildEmptyState()
          : ListView(
              children: [
                // Alerts List
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent Alerts',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      ..._alerts.map((alert) => _AlertItem(alert: alert)),
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 80,
            color: AppColors.primaryTextDimmed,
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.noAlerts,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.primaryTextDimmed,
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertItem extends StatelessWidget {
  final Alert alert;

  const _AlertItem({required this.alert});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to machine details or alert details
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Alert Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.error_outline,
                  color: AppColors.warning,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),

              // Alert Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            alert.title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: alert.isRead ? FontWeight.normal : FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          alert.getTimeAgo(),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.primaryTextDimmed,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      alert.message,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.primaryTextDimmed,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      alert.machineName,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Unread Indicator
              if (!alert.isRead)
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(left: 8, top: 8),
                  decoration: const BoxDecoration(
                    color: AppColors.warning,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
