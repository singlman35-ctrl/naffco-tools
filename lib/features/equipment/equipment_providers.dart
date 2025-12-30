import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'equipment_service.dart';
import 'equipment_model.dart';

final equipmentServiceProvider = Provider<EquipmentService>(
  (ref) => EquipmentService(),
);

final equipmentStreamProvider = StreamProvider<List<Equipment>>((ref) {
  final service = ref.watch(equipmentServiceProvider);
  return service.getEquipmentStream();
});
