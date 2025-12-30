import 'package:cloud_firestore/cloud_firestore.dart';

class EquipmentModel {
  final String equipmentId;
  final String equipmentCode;
  final String name;
  final String category;
  final String status;
  final String currentLocationType;
  final String currentLocationId;
  final DateTime createdAt;

  EquipmentModel({
    required this.equipmentId,
    required this.equipmentCode,
    required this.name,
    required this.category,
    required this.status,
    required this.currentLocationType,
    required this.currentLocationId,
    required this.createdAt,
  });

  factory EquipmentModel.fromMap(Map<String, dynamic> map) {
    return EquipmentModel(
      equipmentId: map['equipmentId'] ?? '',
      equipmentCode: map['equipmentCode'] ?? '',
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      status: map['status'] ?? '',
      currentLocationType: map['currentLocationType'] ?? '',
      currentLocationId: map['currentLocationId'] ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'equipmentId': equipmentId,
      'equipmentCode': equipmentCode,
      'name': name,
      'category': category,
      'status': status,
      'currentLocationType': currentLocationType,
      'currentLocationId': currentLocationId,
      'createdAt': createdAt,
    };
  }
}
