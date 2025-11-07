import 'package:flutter/material.dart';
import 'package:vigiatech/core/constants/app_colors.dart';
import 'package:vigiatech/core/constants/app_strings.dart';
import 'package:vigiatech/core/constants/app_routes.dart';
import 'package:vigiatech/models/machine.dart';

/// Devices List screen - Phase 3: Dashboard and Monitoring
class DevicesView extends StatefulWidget {
  const DevicesView({super.key});

  @override
  State<DevicesView> createState() => _DevicesViewState();
}

class _DevicesViewState extends State<DevicesView> {
  int _selectedIndex = 0;

  // Mock data - TODO: Replace with real data from backend
  final List<Machine> _machines = [
    Machine(
      id: '1',
      name: 'Machine 1',
      status: MachineStatus.normal,
      vibrationLevel: 0.3,
      lastUpdated: DateTime.now().subtract(const Duration(minutes: 2)),
      location: 'Factory Floor A',
      model: 'VIGIATECH-2000',
    ),
    Machine(
      id: '2',
      name: 'Machine 2',
      status: MachineStatus.normal,
      vibrationLevel: 0.25,
      lastUpdated: DateTime.now().subtract(const Duration(minutes: 5)),
      location: 'Factory Floor A',
      model: 'VIGIATECH-2000',
    ),
    Machine(
      id: '3',
      name: 'Machine 3',
      status: MachineStatus.warning,
      vibrationLevel: 0.75,
      lastUpdated: DateTime.now().subtract(const Duration(minutes: 1)),
      location: 'Factory Floor B',
      model: 'VIGIATECH-3000',
    ),
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle navigation based on selected index
    switch (index) {
      case 1:
        Navigator.pushNamed(context, AppRoutes.alerts);
        break;
      case 2:
        Navigator.pushNamed(context, AppRoutes.settings);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.devices),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.addDevice);
            },
            tooltip: AppStrings.addDevice,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Implement refresh logic
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _machines.length,
          itemBuilder: (context, index) {
            return _MachineCard(
              machine: _machines[index],
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.machineDetails,
                  arguments: _machines[index],
                );
              },
            );
          },
        ),
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
}

class _MachineCard extends StatelessWidget {
  final Machine machine;
  final VoidCallback onTap;

  const _MachineCard({
    required this.machine,
    required this.onTap,
  });

  Color _getStatusColor() {
    switch (machine.status) {
      case MachineStatus.normal:
        return AppColors.statusNormal;
      case MachineStatus.warning:
        return AppColors.statusWarning;
      case MachineStatus.critical:
        return AppColors.statusCritical;
      case MachineStatus.offline:
        return AppColors.primaryTextDimmed;
    }
  }

  IconData _getStatusIcon() {
    switch (machine.status) {
      case MachineStatus.normal:
        return Icons.check_circle;
      case MachineStatus.warning:
        return Icons.warning;
      case MachineStatus.critical:
        return Icons.error;
      case MachineStatus.offline:
        return Icons.offline_bolt;
    }
  }

  String _getStatusText() {
    switch (machine.status) {
      case MachineStatus.normal:
        return AppStrings.normal;
      case MachineStatus.warning:
        return AppStrings.warning;
      case MachineStatus.critical:
        return AppStrings.critical;
      case MachineStatus.offline:
        return 'Offline';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Status Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getStatusColor().withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getStatusIcon(),
                  color: _getStatusColor(),
                ),
              ),
              const SizedBox(width: 16),

              // Machine Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      machine.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getStatusText(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: _getStatusColor(),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (machine.location != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        machine.location!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.primaryTextDimmed,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Chevron Icon
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
