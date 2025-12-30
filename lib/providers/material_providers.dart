import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../services/firestore_service.dart';

final materialServiceProvider = Provider<FirestoreService>(
  (ref) => FirestoreService(),
);

final materialsProvider =
    AsyncNotifierProvider<MaterialsNotifier, List<dynamic>>(
      MaterialsNotifier.new,
    );

class MaterialsNotifier extends AsyncNotifier<List<dynamic>> {
  @override
  Future<List<dynamic>> build() async {
    // To be implemented
    throw UnimplementedError();
  }
}
