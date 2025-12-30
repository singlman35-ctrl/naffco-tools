import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../services/firestore_service.dart';

final equipmentServiceProvider = Provider<FirestoreService>(
  (ref) => FirestoreService(),
);

final equipmentProvider =
    AsyncNotifierProvider<EquipmentNotifier, List<dynamic>>(
      EquipmentNotifier.new,
    );

class EquipmentNotifier extends AsyncNotifier<List<dynamic>> {
  @override
  Future<List<dynamic>> build() async {
    // To be implemented
    throw UnimplementedError();
  }
}
