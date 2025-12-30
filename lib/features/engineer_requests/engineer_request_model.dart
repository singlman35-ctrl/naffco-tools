import 'package:cloud_firestore/cloud_firestore.dart';

class EngineerRequest {
  final String id;
  final String projectId;
  final String engineerName;
  final String requestType;
  final String description;
  final String status;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  EngineerRequest({
    required this.id,
    required this.projectId,
    required this.engineerName,
    required this.requestType,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EngineerRequest.fromMap(
    Map<String, dynamic> data,
    String documentId,
  ) {
    return EngineerRequest(
      id: documentId,
      projectId: data['projectId'] ?? '',
      engineerName: data['engineerName'] ?? '',
      requestType: data['requestType'] ?? '',
      description: data['description'] ?? '',
      status: data['status'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'projectId': projectId,
      'engineerName': engineerName,
      'requestType': requestType,
      'description': description,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
