/// Represents the status of a machine
enum MachineStatus {
  normal,
  warning,
  critical,
  offline,
}

/// Machine model representing an industrial device
class Machine {
  final String id;
  final String name;
  final MachineStatus status;
  final double vibrationLevel;
  final DateTime lastUpdated;
  final String? location;
  final String? model;

  const Machine({
    required this.id,
    required this.name,
    required this.status,
    required this.vibrationLevel,
    required this.lastUpdated,
    this.location,
    this.model,
  });

  factory Machine.fromJson(Map<String, dynamic> json) {
    return Machine(
      id: json['id'] as String,
      name: json['name'] as String,
      status: _statusFromString(json['status'] as String),
      vibrationLevel: (json['vibrationLevel'] as num).toDouble(),
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      location: json['location'] as String?,
      model: json['model'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': _statusToString(status),
      'vibrationLevel': vibrationLevel,
      'lastUpdated': lastUpdated.toIso8601String(),
      'location': location,
      'model': model,
    };
  }

  static MachineStatus _statusFromString(String status) {
    switch (status.toLowerCase()) {
      case 'normal':
        return MachineStatus.normal;
      case 'warning':
        return MachineStatus.warning;
      case 'critical':
        return MachineStatus.critical;
      case 'offline':
        return MachineStatus.offline;
      default:
        return MachineStatus.offline;
    }
  }

  static String _statusToString(MachineStatus status) {
    switch (status) {
      case MachineStatus.normal:
        return 'normal';
      case MachineStatus.warning:
        return 'warning';
      case MachineStatus.critical:
        return 'critical';
      case MachineStatus.offline:
        return 'offline';
    }
  }

  Machine copyWith({
    String? id,
    String? name,
    MachineStatus? status,
    double? vibrationLevel,
    DateTime? lastUpdated,
    String? location,
    String? model,
  }) {
    return Machine(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      vibrationLevel: vibrationLevel ?? this.vibrationLevel,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      location: location ?? this.location,
      model: model ?? this.model,
    );
  }
}
