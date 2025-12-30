import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

final authStateProvider = StreamProvider.autoDispose((ref) {
  // To be implemented
  throw UnimplementedError();
});
