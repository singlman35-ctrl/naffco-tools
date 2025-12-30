import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../services/firestore_service.dart';

final projectServiceProvider = Provider<FirestoreService>(
  (ref) => FirestoreService(),
);

final projectsProvider = AsyncNotifierProvider<ProjectsNotifier, List<dynamic>>(
  ProjectsNotifier.new,
);

class ProjectsNotifier extends AsyncNotifier<List<dynamic>> {
  @override
  Future<List<dynamic>> build() async {
    // To be implemented
    throw UnimplementedError();
  }
}
