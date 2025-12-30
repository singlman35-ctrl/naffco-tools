import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'equipment_movement_model.dart';
import 'equipment_movement_service.dart';

final equipmentMovementServiceProvider = Provider<EquipmentMovementService>((
  ref,
) {
  return EquipmentMovementService();
});

final equipmentMovementsStreamProvider =
    StreamProvider<List<EquipmentMovement>>((ref) {
      return ref.watch(equipmentMovementServiceProvider).getMovementsStream();
    });
