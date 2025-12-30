import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectModel {
  final String projectId;
  final String projectNumber;
  final String projectName;
  final String location;
  final String engineerId;
  final String status;
  final DateTime createdAt;

  ProjectModel({
    required this.projectId,
    required this.projectNumber,
    required this.projectName,
    required this.location,
    required this.engineerId,
    required this.status,
    required this.createdAt,
  });

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      projectId: map['projectId'] ?? '',
      projectNumber: map['projectNumber'] ?? '',
      projectName: map['projectName'] ?? '',
      location: map['location'] ?? '',
      engineerId: map['engineerId'] ?? '',
      status: map['status'] ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'projectId': projectId,
      'projectNumber': projectNumber,
      'projectName': projectName,
      'location': location,
      'engineerId': engineerId,
      'status': status,
      'createdAt': createdAt,
    };
  }
}
