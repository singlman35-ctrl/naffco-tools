import 'package:cloud_firestore/cloud_firestore.dart';

class Equipment {
  final String id;
  final String name;
  final String serialNumber;
  final String category;
  final String projectId;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  Equipment({
    required this.id,
    required this.name,
    required this.serialNumber,
    required this.category,
    required this.projectId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Equipment.fromMap(Map<String, dynamic> data, String documentId) {
    return Equipment(
      id: documentId,
      name: data['name'] ?? '',
      serialNumber: data['serialNumber'] ?? '',
      category: data['category'] ?? '',
      projectId: data['projectId'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'serialNumber': serialNumber,
      'category': category,
      'projectId': projectId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
