import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../app/main_layout.dart';
import 'project_model.dart';
import 'projects_providers.dart';

class ProjectsScreen extends ConsumerWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectsAsync = ref.watch(projectsStreamProvider);
    final projectsService = ref.read(projectsServiceProvider);

    void showDeleteProjectDialog(Project project) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('تأكيد الحذف'),
            content: const Text('هل تريد حذف هذا المشروع؟'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('إلغاء'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () async {
                  await projectsService.deleteProject(project.id);
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                },
                child: const Text('حذف'),
              ),
            ],
          );
        },
      );
    }

    void showAddProjectDialog() {
      final nameController = TextEditingController();
      final codeController = TextEditingController();
      final locationController = TextEditingController();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('إضافة مشروع جديد'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: codeController,
                  decoration: const InputDecoration(labelText: 'Code'),
                ),
                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: 'Location'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('إلغاء'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final project = Project(
                    id: '',
                    name: nameController.text,
                    code: codeController.text,
                    location: locationController.text,
                    createdAt: Timestamp.now(),
                    updatedAt: Timestamp.now(),
                  );
                  await projectsService.addProject(project);
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                },
                child: const Text('إضافة'),
              ),
            ],
          );
        },
      );
    }

    void showEditProjectDialog(Project project) {
      final nameController = TextEditingController(text: project.name);
      final codeController = TextEditingController(text: project.code);
      final locationController = TextEditingController(text: project.location);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('تعديل المشروع'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: codeController,
                  decoration: const InputDecoration(labelText: 'Code'),
                ),
                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: 'Location'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('إلغاء'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final updatedProject = Project(
                    id: project.id,
                    name: nameController.text,
                    code: codeController.text,
                    location: locationController.text,
                    createdAt: project.createdAt,
                    updatedAt: Timestamp.now(),
                  );
                  await projectsService.updateProject(updatedProject);
                  if (!context.mounted) return;
                  Navigator.of(context).pop();
                },
                child: const Text('حفظ'),
              ),
            ],
          );
        },
      );
    }

    return MainLayout(
      child: Stack(
        children: [
          projectsAsync.when(
            data: (projects) {
              return ListView.builder(
                padding: const EdgeInsets.all(24),
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  final project = projects[index];
                  return Card(
                    child: ListTile(
                      title: Text(project.name),
                      subtitle: Text(project.location),
                      onTap: () => showEditProjectDialog(project),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => showDeleteProjectDialog(project),
                        tooltip: 'حذف',
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) => Center(child: Text('خطأ: $e')),
          ),
          Positioned(
            bottom: 24,
            right: 24,
            child: FloatingActionButton(
              onPressed: showAddProjectDialog,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
