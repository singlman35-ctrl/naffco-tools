import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'engineer_request_model.dart';
import 'engineer_request_service.dart';

final engineerRequestServiceProvider = Provider<EngineerRequestService>((ref) {
  return EngineerRequestService();
});

final engineerRequestsStreamProvider = StreamProvider<List<EngineerRequest>>((
  ref,
) {
  return ref.watch(engineerRequestServiceProvider).getRequestsStream();
});
