import 'package:flutter/material.dart';
import 'package:vigiatech/core/constants/app_colors.dart';
import 'package:vigiatech/core/constants/app_strings.dart';
import 'package:vigiatech/models/machine.dart';

/// Machine Details screen - Phase 3: Dashboard and Monitoring
class MachineDetailsView extends StatefulWidget {
  final Machine machine;

  const MachineDetailsView({
    super.key,
    required this.machine,
  });

  @override
  State<MachineDetailsView> createState() => _MachineDetailsViewState();
}

class _MachineDetailsViewState extends State<MachineDetailsView> {
  // Mock chart data - TODO: Replace with real data from backend
  final List<double> _chartData = [
    0.2, 0.25, 0.3, 0.28, 0.35, 0.4, 0.5, 0.6, 0.7, 0.75,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.machine.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            _buildStatusCard(),
            const SizedBox(height: 24),

            // Chart Card
            _buildChartCard(),
            const SizedBox(height: 24),

            // Information Card
            _buildInformationCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (widget.machine.status) {
      case MachineStatus.normal:
        statusColor = AppColors.statusNormal;
        statusText = AppStrings.normal;
        statusIcon = Icons.check_circle;
        break;
      case MachineStatus.warning:
        statusColor = AppColors.statusWarning;
        statusText = AppStrings.warning;
        statusIcon = Icons.warning;
        break;
      case MachineStatus.critical:
        statusColor = AppColors.statusCritical;
        statusText = AppStrings.critical;
        statusIcon = Icons.error;
        break;
      case MachineStatus.offline:
        statusColor = AppColors.primaryTextDimmed;
        statusText = 'Offline';
        statusIcon = Icons.offline_bolt;
        break;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.status,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.primaryTextDimmed,
              ),
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Icon(
                  statusIcon,
                  color: statusColor,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    statusText,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.secondaryBackground,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            Text(
              '${AppStrings.vibrationLevel}: ${widget.machine.vibrationLevel.toStringAsFixed(2)} m/s²',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '${AppStrings.lastUpdated}: ${_formatDateTime(widget.machine.lastUpdated)}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.primaryTextDimmed,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vibration History',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.primaryTextDimmed,
              ),
            ),
            const SizedBox(height: 16),
            
            // Simple chart visualization
            SizedBox(
              height: 200,
              child: CustomPaint(
                painter: _ChartPainter(data: _chartData),
                child: Container(),
              ),
            ),
            
            const SizedBox(height: 8),
            Text(
              'Last 10 readings',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.primaryTextDimmed,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInformationCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.information,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.primaryTextDimmed,
              ),
            ),
            const SizedBox(height: 16),
            
            _buildInfoRow('Machine ID', widget.machine.id),
            const SizedBox(height: 12),
            _buildInfoRow('Name', widget.machine.name),
            const SizedBox(height: 12),
            if (widget.machine.model != null) ...[
              _buildInfoRow('Model', widget.machine.model!),
              const SizedBox(height: 12),
            ],
            if (widget.machine.location != null) ...[
              _buildInfoRow('Location', widget.machine.location!),
              const SizedBox(height: 12),
            ],
            _buildInfoRow('Status', _getStatusText()),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.primaryTextDimmed,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  String _getStatusText() {
    switch (widget.machine.status) {
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

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }
}

/// Custom painter for simple line chart
class _ChartPainter extends CustomPainter {
  final List<double> data;

  _ChartPainter({required this.data});

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paint = Paint()
      ..color = AppColors.secondary
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final maxValue = data.reduce((a, b) => a > b ? a : b);
    final minValue = data.reduce((a, b) => a < b ? a : b);
    final valueRange = maxValue - minValue;

    final path = Path();
    for (var i = 0; i < data.length; i++) {
      final x = (i / (data.length - 1)) * size.width;
      final normalizedValue = valueRange > 0 
          ? (data[i] - minValue) / valueRange 
          : 0.5;
      final y = size.height - (normalizedValue * size.height);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }

      // Draw points
      canvas.drawCircle(
        Offset(x, y),
        4,
        Paint()
          ..color = AppColors.secondary
          ..style = PaintingStyle.fill,
      );
    }

    canvas.drawPath(path, paint);

    // Draw grid lines
    final gridPaint = Paint()
      ..color = AppColors.primaryTextDimmed.withOpacity(0.2)
      ..strokeWidth = 1;

    for (var i = 0; i <= 4; i++) {
      final y = (i / 4) * size.height;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
