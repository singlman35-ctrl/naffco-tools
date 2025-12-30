import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'project_model.dart';
import 'projects_service.dart';

final projectsServiceProvider = Provider<ProjectsService>((ref) {
  return ProjectsService();
});

final projectsStreamProvider = StreamProvider<List<Project>>((ref) {
  return ref.watch(projectsServiceProvider).getProjectsStream();
});
