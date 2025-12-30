import 'package:cloud_firestore/cloud_firestore.dart';

class PdfLinkModel {
  final String pdfId;
  final String fileName;
  final String storagePath;
  final String linkedToType;
  final String linkedToId;
  final String uploadedBy;
  final DateTime uploadedAt;

  PdfLinkModel({
    required this.pdfId,
    required this.fileName,
    required this.storagePath,
    required this.linkedToType,
    required this.linkedToId,
    required this.uploadedBy,
    required this.uploadedAt,
  });

  factory PdfLinkModel.fromMap(Map<String, dynamic> map) {
    return PdfLinkModel(
      pdfId: map['pdfId'] ?? '',
      fileName: map['fileName'] ?? '',
      storagePath: map['storagePath'] ?? '',
      linkedToType: map['linkedToType'] ?? '',
      linkedToId: map['linkedToId'] ?? '',
      uploadedBy: map['uploadedBy'] ?? '',
      uploadedAt: (map['uploadedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pdfId': pdfId,
      'fileName': fileName,
      'storagePath': storagePath,
      'linkedToType': linkedToType,
      'linkedToId': linkedToId,
      'uploadedBy': uploadedBy,
      'uploadedAt': uploadedAt,
    };
  }
}
