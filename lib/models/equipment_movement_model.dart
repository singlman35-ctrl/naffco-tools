import 'package:cloud_firestore/cloud_firestore.dart';

class EquipmentMovementModel {
  final String movementId;
  final String equipmentId;
  final String fromLocationType;
  final String fromLocationId;
  final String toLocationType;
  final String toLocationId;
  final DateTime date;
  final String userId;

  EquipmentMovementModel({
    required this.movementId,
    required this.equipmentId,
    required this.fromLocationType,
    required this.fromLocationId,
    required this.toLocationType,
    required this.toLocationId,
    required this.date,
    required this.userId,
  });

  factory EquipmentMovementModel.fromMap(Map<String, dynamic> map) {
    return EquipmentMovementModel(
      movementId: map['movementId'] ?? '',
      equipmentId: map['equipmentId'] ?? '',
      fromLocationType: map['fromLocationType'] ?? '',
      fromLocationId: map['fromLocationId'] ?? '',
      toLocationType: map['toLocationType'] ?? '',
      toLocationId: map['toLocationId'] ?? '',
      date: (map['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      userId: map['userId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'movementId': movementId,
      'equipmentId': equipmentId,
      'fromLocationType': fromLocationType,
      'fromLocationId': fromLocationId,
      'toLocationType': toLocationType,
      'toLocationId': toLocationId,
      'date': date,
      'userId': userId,
    };
  }
}
