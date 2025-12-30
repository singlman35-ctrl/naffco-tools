import 'package:cloud_firestore/cloud_firestore.dart';

import 'engineer_request_model.dart';

class EngineerRequestService {
  final _db = FirebaseFirestore.instance;

  Future<void> addEngineerRequest(EngineerRequest request) async {
    await _db.collection('engineer_requests').add(request.toMap());
  }

  Future<void> updateEngineerRequest(EngineerRequest request) async {
    await _db
        .collection('engineer_requests')
        .doc(request.id)
        .update(request.toMap());
  }

  Future<void> deleteEngineerRequest(String id) async {
    await _db.collection('engineer_requests').doc(id).delete();
  }

  Stream<List<EngineerRequest>> getRequestsStream() {
    return _db.collection('engineer_requests').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return EngineerRequest.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }
}
