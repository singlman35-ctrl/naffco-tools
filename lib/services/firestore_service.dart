import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Get document by path
  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument(
    String path,
  ) async {
    // To be implemented
    throw UnimplementedError();
  }

  // Set document by path
  Future<void> setDocument(String path, Map<String, dynamic> data) async {
    // To be implemented
    throw UnimplementedError();
  }

  // Delete document by path
  Future<void> deleteDocument(String path) async {
    // To be implemented
    throw UnimplementedError();
  }
}
