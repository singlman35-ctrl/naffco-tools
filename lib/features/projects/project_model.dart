import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  final String id;
  final String name;
  final String code;
  final String location;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  Project({
    required this.id,
    required this.name,
    required this.code,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Project.fromMap(Map<String, dynamic> data, String documentId) {
    return Project(
      id: documentId,
      name: data['name'] ?? '',
      code: data['code'] ?? '',
      location: data['location'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': code,
      'location': location,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
