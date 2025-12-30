import 'package:cloud_firestore/cloud_firestore.dart';

class ImportRecordModel {
  final String importId;
  final String type;
  final String fileName;
  final String summary;
  final DateTime createdAt;
  final String uploadedBy;

  ImportRecordModel({
    required this.importId,
    required this.type,
    required this.fileName,
    required this.summary,
    required this.createdAt,
    required this.uploadedBy,
  });

  factory ImportRecordModel.fromMap(Map<String, dynamic> map) {
    return ImportRecordModel(
      importId: map['importId'] ?? '',
      type: map['type'] ?? '',
      fileName: map['fileName'] ?? '',
      summary: map['summary'] ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      uploadedBy: map['uploadedBy'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'importId': importId,
      'type': type,
      'fileName': fileName,
      'summary': summary,
      'createdAt': createdAt,
      'uploadedBy': uploadedBy,
    };
  }
}
