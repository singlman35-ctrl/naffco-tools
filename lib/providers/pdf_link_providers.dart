import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../services/firestore_service.dart';

final pdfLinkServiceProvider = Provider<FirestoreService>(
  (ref) => FirestoreService(),
);

final pdfLinksProvider = AsyncNotifierProvider<PdfLinksNotifier, List<dynamic>>(
  PdfLinksNotifier.new,
);

class PdfLinksNotifier extends AsyncNotifier<List<dynamic>> {
  @override
  Future<List<dynamic>> build() async {
    // To be implemented
    throw UnimplementedError();
  }
}
