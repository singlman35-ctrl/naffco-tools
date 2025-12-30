import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../services/firestore_service.dart';

final equipmentMovementServiceProvider = Provider<FirestoreService>(
  (ref) => FirestoreService(),
);

final equipmentMovementsProvider =
    AsyncNotifierProvider<EquipmentMovementsNotifier, List<dynamic>>(
      EquipmentMovementsNotifier.new,
    );

class EquipmentMovementsNotifier extends AsyncNotifier<List<dynamic>> {
  @override
  Future<List<dynamic>> build() async {
    // To be implemented
    throw UnimplementedError();
  }
}
