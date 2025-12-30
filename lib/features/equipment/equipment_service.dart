import 'package:cloud_firestore/cloud_firestore.dart';
import 'equipment_model.dart';

class EquipmentService {
  final _db = FirebaseFirestore.instance;

  Future<void> addEquipment(Equipment equipment) async {
    await _db.collection('equipment').add(equipment.toMap());
  }

  Future<void> updateEquipment(Equipment equipment) async {
    await _db
        .collection('equipment')
        .doc(equipment.id)
        .update(equipment.toMap());
  }

  Future<void> deleteEquipment(String id) async {
    await _db.collection('equipment').doc(id).delete();
  }

  Stream<List<Equipment>> getEquipmentStream() {
    return _db.collection('equipment').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Equipment.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }
}
