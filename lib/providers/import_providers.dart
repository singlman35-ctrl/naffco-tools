import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../services/firestore_service.dart';

final importServiceProvider = Provider<FirestoreService>(
  (ref) => FirestoreService(),
);

final importsProvider = AsyncNotifierProvider<ImportsNotifier, List<dynamic>>(
  ImportsNotifier.new,
);

class ImportsNotifier extends AsyncNotifier<List<dynamic>> {
  @override
  Future<List<dynamic>> build() async {
    // To be implemented
    throw UnimplementedError();
  }
}
