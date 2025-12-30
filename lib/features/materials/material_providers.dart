import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'material_model.dart';
import 'material_service.dart';

final materialsServiceProvider = Provider<MaterialService>((ref) {
  return MaterialService();
});

final materialsStreamProvider = StreamProvider<List<MaterialModel>>((ref) {
  return ref.watch(materialsServiceProvider).getMaterialsStream();
});
