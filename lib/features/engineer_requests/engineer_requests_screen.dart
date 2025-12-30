import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app/main_layout.dart';
import 'engineer_request_model.dart';
import 'engineer_request_providers.dart';

class EngineerRequestsScreen extends ConsumerWidget {
  const EngineerRequestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestsAsync = ref.watch(engineerRequestsStreamProvider);
    final engineerRequestService = ref.read(engineerRequestServiceProvider);

    void showAddRequestDialog() {
      final nameController = TextEditingController();
      final typeController = TextEditingController();
      final descriptionController = TextEditingController();
      final projectIdController = TextEditingController();
      final statusController = TextEditingController(text: 'pending');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('إضافة طلب مهندس'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Engineer Name',
                    ),
                  ),
                  TextField(
                    controller: typeController,
                    decoration: const InputDecoration(
                      labelText: 'Request Type',
                    ),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  TextField(
                    controller: projectIdController,
                    decoration: const InputDecoration(labelText: 'Project ID'),
                  ),
                  TextField(
                    controller: statusController,
                    decoration: const InputDecoration(labelText: 'Status'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('إلغاء'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final request = EngineerRequest(
                    id: '',
                    projectId: projectIdController.text,
                    engineerName: nameController.text,
                    requestType: typeController.text,
                    description: descriptionController.text,
                    status: statusController.text,
                    createdAt: Timestamp.now(),
                    updatedAt: Timestamp.now(),
                  );
                  await engineerRequestService.addEngineerRequest(request);
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

    void showEditRequestDialog(EngineerRequest request) {
      final nameController = TextEditingController(text: request.engineerName);
      final typeController = TextEditingController(text: request.requestType);
      final descriptionController = TextEditingController(
        text: request.description,
      );
      final projectIdController = TextEditingController(
        text: request.projectId,
      );
      final statusController = TextEditingController(text: request.status);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('تعديل طلب المهندس'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Engineer Name',
                    ),
                  ),
                  TextField(
                    controller: typeController,
                    decoration: const InputDecoration(
                      labelText: 'Request Type',
                    ),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  TextField(
                    controller: projectIdController,
                    decoration: const InputDecoration(labelText: 'Project ID'),
                  ),
                  TextField(
                    controller: statusController,
                    decoration: const InputDecoration(labelText: 'Status'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('إلغاء'),
              ),
              ElevatedButton(
                onPressed: () async {
                  final updated = EngineerRequest(
                    id: request.id,
                    projectId: projectIdController.text,
                    engineerName: nameController.text,
                    requestType: typeController.text,
                    description: descriptionController.text,
                    status: statusController.text,
                    createdAt: request.createdAt,
                    updatedAt: Timestamp.now(),
                  );
                  await engineerRequestService.updateEngineerRequest(updated);
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
          Padding(
            padding: const EdgeInsets.all(24),
            child: requestsAsync.when(
              data: (requests) {
                if (requests.isEmpty) {
                  return Center(
                    child: Text(
                      'لا توجد طلبات حتى الآن.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  );
                }
                return ListView.separated(
                  itemCount: requests.length,
                  separatorBuilder: (context, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final request = requests[index];
                    return Card(
                      child: ListTile(
                        onTap: () => showEditRequestDialog(request),
                        title: Text(
                          request.engineerName,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('نوع الطلب: ${request.requestType}'),
                            Text('الحالة: ${request.status}'),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('تأكيد الحذف'),
                                  content: const Text('هل تريد حذف هذا الطلب؟'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text('إلغاء'),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                      ),
                                      onPressed: () async {
                                        await engineerRequestService
                                            .deleteEngineerRequest(request.id);
                                        if (!context.mounted) return;
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('حذف'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('خطأ: $error')),
            ),
          ),
          Positioned(
            bottom: 24,
            right: 24,
            child: FloatingActionButton(
              onPressed: showAddRequestDialog,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
