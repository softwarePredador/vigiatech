/// Represents an alert in the system
class Alert {
  final String id;
  final String machineId;
  final String machineName;
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;

  const Alert({
    required this.id,
    required this.machineId,
    required this.machineName,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
  });

  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(
      id: json['id'] as String,
      machineId: json['machineId'] as String,
      machineName: json['machineName'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isRead: json['isRead'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'machineId': machineId,
      'machineName': machineName,
      'title': title,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
    };
  }

  Alert copyWith({
    String? id,
    String? machineId,
    String? machineName,
    String? title,
    String? message,
    DateTime? timestamp,
    bool? isRead,
  }) {
    return Alert(
      id: id ?? this.id,
      machineId: machineId ?? this.machineId,
      machineName: machineName ?? this.machineName,
      title: title ?? this.title,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
    );
  }

  /// Returns a human-readable time difference from now
  String getTimeAgo() {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
