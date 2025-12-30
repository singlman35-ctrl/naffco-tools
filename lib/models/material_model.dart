import 'package:cloud_firestore/cloud_firestore.dart';

class MaterialModel {
  final String materialId;
  final String materialCode;
  final String name;
  final String unit;
  final double basePrice;
  final double stockQuantity;
  final DateTime createdAt;

  MaterialModel({
    required this.materialId,
    required this.materialCode,
    required this.name,
    required this.unit,
    required this.basePrice,
    required this.stockQuantity,
    required this.createdAt,
  });

  factory MaterialModel.fromMap(Map<String, dynamic> map) {
    return MaterialModel(
      materialId: map['materialId'] ?? '',
      materialCode: map['materialCode'] ?? '',
      name: map['name'] ?? '',
      unit: map['unit'] ?? '',
      basePrice: (map['basePrice'] ?? 0).toDouble(),
      stockQuantity: (map['stockQuantity'] ?? 0).toDouble(),
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'materialId': materialId,
      'materialCode': materialCode,
      'name': name,
      'unit': unit,
      'basePrice': basePrice,
      'stockQuantity': stockQuantity,
      'createdAt': createdAt,
    };
  }
}
