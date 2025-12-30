import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../services/firestore_service.dart';

final engineerRequestServiceProvider = Provider<FirestoreService>(
  (ref) => FirestoreService(),
);

final engineerRequestsProvider =
    AsyncNotifierProvider<EngineerRequestsNotifier, List<dynamic>>(
      EngineerRequestsNotifier.new,
    );

class EngineerRequestsNotifier extends AsyncNotifier<List<dynamic>> {
  @override
  Future<List<dynamic>> build() async {
    // To be implemented
    throw UnimplementedError();
  }
}
