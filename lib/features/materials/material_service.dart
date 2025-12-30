import 'package:cloud_firestore/cloud_firestore.dart';

import 'material_model.dart';

class MaterialService {
  final _db = FirebaseFirestore.instance;

  Future<void> addMaterial(MaterialModel material) async {
    await _db.collection('materials').add(material.toMap());
  }

  Future<void> updateMaterial(MaterialModel material) async {
    await _db.collection('materials').doc(material.id).update(material.toMap());
  }

  Future<void> deleteMaterial(String id) async {
    await _db.collection('materials').doc(id).delete();
  }

  Stream<List<MaterialModel>> getMaterialsStream() {
    return _db.collection('materials').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return MaterialModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }
}
