import 'package:flutter/material.dart';
import 'package:vigiatech/core/constants/app_colors.dart';
import 'package:vigiatech/core/constants/app_strings.dart';

/// Add Device screen - Phase 2: Device Provisioning
class AddDeviceView extends StatefulWidget {
  const AddDeviceView({super.key});

  @override
  State<AddDeviceView> createState() => _AddDeviceViewState();
}

class _AddDeviceViewState extends State<AddDeviceView> {
  final _formKey = GlobalKey<FormState>();
  final _ssidController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isScanning = false;
  bool _isConnecting = false;
  String? _selectedDevice;

  // Mock devices - TODO: Replace with real Bluetooth scan results
  final List<String> _availableDevices = [
    'VIGIATECH-001',
    'VIGIATECH-002',
    'VIGIATECH-003',
  ];

  @override
  void dispose() {
    _ssidController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _startScan() async {
    setState(() {
      _isScanning = true;
    });

    // TODO: Implement Bluetooth scan logic
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isScanning = false;
    });
  }

  Future<void> _connectDevice() async {
    if (_selectedDevice == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a device')),
      );
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isConnecting = true;
      });

      // TODO: Implement device provisioning logic
      await Future.delayed(const Duration(seconds: 3));

      setState(() {
        _isConnecting = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Device connected successfully!'),
            backgroundColor: AppColors.statusNormal,
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.addDevice),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Instructions
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Icon(
                      Icons.bluetooth_searching,
                      size: 48,
                      color: AppColors.secondary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Scan for nearby VIGIATECH sensors and connect them to your Wi-Fi network.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.primaryTextDimmed,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Scan Button
            ElevatedButton.icon(
              onPressed: _isScanning ? null : _startScan,
              icon: _isScanning
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.secondaryBackground,
                      ),
                    )
                  : const Icon(Icons.bluetooth_searching),
              label: Text(_isScanning ? 'Scanning...' : AppStrings.scanDevices),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            const SizedBox(height: 24),

            // Available Devices
            if (_availableDevices.isNotEmpty) ...[
              Text(
                'Available Devices',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              ..._availableDevices.map((device) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: RadioListTile<String>(
                    title: Text(device),
                    subtitle: Text(
                      'VIGIATECH Sensor',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.primaryTextDimmed,
                      ),
                    ),
                    value: device,
                    groupValue: _selectedDevice,
                    activeColor: AppColors.accent,
                    onChanged: (value) {
                      setState(() {
                        _selectedDevice = value;
                      });
                    },
                  ),
                );
              }),
              const SizedBox(height: 24),
            ],

            // Wi-Fi Configuration
            if (_selectedDevice != null) ...[
              Text(
                'Wi-Fi Configuration',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _ssidController,
                      decoration: const InputDecoration(
                        labelText: 'Wi-Fi Network (SSID)',
                        prefixIcon: Icon(Icons.wifi),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Wi-Fi network name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Wi-Fi Password',
                        prefixIcon: const Icon(Icons.lock_outlined),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Wi-Fi password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    
                    ElevatedButton(
                      onPressed: _isConnecting ? null : _connectDevice,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: _isConnecting
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.secondaryBackground,
                              ),
                            )
                          : const Text('Connect Device'),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
