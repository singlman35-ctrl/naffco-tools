import 'package:cloud_firestore/cloud_firestore.dart';

import 'equipment_movement_model.dart';

class EquipmentMovementService {
  final _db = FirebaseFirestore.instance;

  Future<void> addEquipmentMovement(EquipmentMovement movement) async {
    await _db.collection('equipment_movements').add(movement.toMap());
  }

  Stream<List<EquipmentMovement>> getMovementsStream() {
    return _db.collection('equipment_movements').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return EquipmentMovement.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }
}
