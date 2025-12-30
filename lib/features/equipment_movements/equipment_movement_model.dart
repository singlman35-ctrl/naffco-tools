import 'package:cloud_firestore/cloud_firestore.dart';

class EquipmentMovement {
  final String id;
  final String equipmentId;
  final String fromProjectId;
  final String toProjectId;
  final String engineerName;
  final String movementType;
  final String notes;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  EquipmentMovement({
    required this.id,
    required this.equipmentId,
    required this.fromProjectId,
    required this.toProjectId,
    required this.engineerName,
    required this.movementType,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EquipmentMovement.fromMap(
    Map<String, dynamic> data,
    String documentId,
  ) {
    return EquipmentMovement(
      id: documentId,
      equipmentId: data['equipmentId'] ?? '',
      fromProjectId: data['fromProjectId'] ?? '',
      toProjectId: data['toProjectId'] ?? '',
      engineerName: data['engineerName'] ?? '',
      movementType: data['movementType'] ?? '',
      notes: data['notes'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'equipmentId': equipmentId,
      'fromProjectId': fromProjectId,
      'toProjectId': toProjectId,
      'engineerName': engineerName,
      'movementType': movementType,
      'notes': notes,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
