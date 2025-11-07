import 'package:flutter/material.dart';
import 'package:vigiatech/core/theme/app_theme.dart';
import 'package:vigiatech/core/constants/app_strings.dart';
import 'package:vigiatech/core/constants/app_routes.dart';
import 'package:vigiatech/views/auth/login_view.dart';
import 'package:vigiatech/views/auth/forgot_password_view.dart';
import 'package:vigiatech/views/devices/devices_view.dart';
import 'package:vigiatech/views/devices/machine_details_view.dart';
import 'package:vigiatech/views/devices/add_device_view.dart';
import 'package:vigiatech/views/alerts/alerts_view.dart';
import 'package:vigiatech/views/alerts/settings_view.dart';
import 'package:vigiatech/models/machine.dart';

void main() {
  runApp(const VigiaTechApp());
}

class VigiaTechApp extends StatelessWidget {
  const VigiaTechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.login,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.login:
            return MaterialPageRoute(builder: (_) => const LoginView());
          
          case AppRoutes.forgotPassword:
            return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
          
          case AppRoutes.devices:
            return MaterialPageRoute(builder: (_) => const DevicesView());
          
          case AppRoutes.machineDetails:
            final machine = settings.arguments as Machine;
            return MaterialPageRoute(
              builder: (_) => MachineDetailsView(machine: machine),
            );
          
          case AppRoutes.addDevice:
            return MaterialPageRoute(builder: (_) => const AddDeviceView());
          
          case AppRoutes.alerts:
            return MaterialPageRoute(builder: (_) => const AlertsView());
          
          case AppRoutes.settings:
            return MaterialPageRoute(builder: (_) => const SettingsView());
          
          default:
            return MaterialPageRoute(builder: (_) => const LoginView());
        }
      },
    );
  }
}
