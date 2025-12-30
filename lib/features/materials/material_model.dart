import 'package:cloud_firestore/cloud_firestore.dart';

class MaterialModel {
  final String id;
  final String name;
  final String code;
  final double quantity;
  final String unit;
  final String projectId;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  MaterialModel({
    required this.id,
    required this.name,
    required this.code,
    required this.quantity,
    required this.unit,
    required this.projectId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MaterialModel.fromMap(Map<String, dynamic> data, String documentId) {
    return MaterialModel(
      id: documentId,
      name: data['name'] ?? '',
      code: data['code'] ?? '',
      quantity: (data['quantity'] as num?)?.toDouble() ?? 0,
      unit: data['unit'] ?? '',
      projectId: data['projectId'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': code,
      'quantity': quantity,
      'unit': unit,
      'projectId': projectId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
