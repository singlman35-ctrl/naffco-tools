import 'package:cloud_firestore/cloud_firestore.dart';

class EngineerRequestItem {
  final String materialId;
  final double quantity;
  final double unitPrice;
  final double total;

  EngineerRequestItem({
    required this.materialId,
    required this.quantity,
    required this.unitPrice,
    required this.total,
  });

  factory EngineerRequestItem.fromMap(Map<String, dynamic> map) {
    return EngineerRequestItem(
      materialId: map['materialId'] ?? '',
      quantity: (map['quantity'] ?? 0).toDouble(),
      unitPrice: (map['unitPrice'] ?? 0).toDouble(),
      total: (map['total'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'materialId': materialId,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'total': total,
    };
  }
}

class EngineerRequestModel {
  final String requestId;
  final String engineerId;
  final String projectId;
  final DateTime date;
  final String status;
  final double totalAmount;
  final List<EngineerRequestItem> items;

  EngineerRequestModel({
    required this.requestId,
    required this.engineerId,
    required this.projectId,
    required this.date,
    required this.status,
    required this.totalAmount,
    required this.items,
  });

  factory EngineerRequestModel.fromMap(Map<String, dynamic> map) {
    return EngineerRequestModel(
      requestId: map['requestId'] ?? '',
      engineerId: map['engineerId'] ?? '',
      projectId: map['projectId'] ?? '',
      date: (map['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      status: map['status'] ?? '',
      totalAmount: (map['totalAmount'] ?? 0).toDouble(),
      items: (map['items'] as List<dynamic>? ?? [])
          .map(
            (item) => EngineerRequestItem.fromMap(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'requestId': requestId,
      'engineerId': engineerId,
      'projectId': projectId,
      'date': date,
      'status': status,
      'totalAmount': totalAmount,
      'items': items.map((e) => e.toMap()).toList(),
    };
  }
}
