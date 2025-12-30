import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app/main_layout.dart';
import 'material_model.dart';
import 'material_providers.dart';

class MaterialsScreen extends ConsumerWidget {
  const MaterialsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final materialsAsync = ref.watch(materialsStreamProvider);
    final materialsService = ref.read(materialsServiceProvider);

    void showAddMaterialDialog() {
      final nameController = TextEditingController();
      final codeController = TextEditingController();
      final quantityController = TextEditingController();
      final unitController = TextEditingController();
      final projectIdController = TextEditingController();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('إضافة مادة جديدة'),
            content: SingleChildScrollView(
              child: Column(
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
                    controller: quantityController,
                    decoration: const InputDecoration(labelText: 'Quantity'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: unitController,
                    decoration: const InputDecoration(labelText: 'Unit'),
                  ),
                  TextField(
                    controller: projectIdController,
                    decoration: const InputDecoration(labelText: 'Project ID'),
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
                  final material = MaterialModel(
                    id: '',
                    name: nameController.text,
                    code: codeController.text,
                    quantity: double.tryParse(quantityController.text) ?? 0.0,
                    unit: unitController.text,
                    projectId: projectIdController.text,
                    createdAt: Timestamp.now(),
                    updatedAt: Timestamp.now(),
                  );
                  await materialsService.addMaterial(material);
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

    void showEditMaterialDialog(MaterialModel material) {
      final nameController = TextEditingController(text: material.name);
      final codeController = TextEditingController(text: material.code);
      final quantityController = TextEditingController(
        text: material.quantity.toString(),
      );
      final unitController = TextEditingController(text: material.unit);
      final projectIdController = TextEditingController(
        text: material.projectId,
      );
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('تعديل المادة'),
            content: SingleChildScrollView(
              child: Column(
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
                    controller: quantityController,
                    decoration: const InputDecoration(labelText: 'Quantity'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: unitController,
                    decoration: const InputDecoration(labelText: 'Unit'),
                  ),
                  TextField(
                    controller: projectIdController,
                    decoration: const InputDecoration(labelText: 'Project ID'),
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
                  final updated = MaterialModel(
                    id: material.id,
                    name: nameController.text,
                    code: codeController.text,
                    quantity: double.tryParse(quantityController.text) ?? 0.0,
                    unit: unitController.text,
                    projectId: projectIdController.text,
                    createdAt: material.createdAt,
                    updatedAt: Timestamp.now(),
                  );
                  await materialsService.updateMaterial(updated);
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
            child: materialsAsync.when(
              data: (materials) {
                if (materials.isEmpty) {
                  return Center(
                    child: Text(
                      'لا توجد مواد حتى الآن.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  );
                }
                return ListView.separated(
                  itemCount: materials.length,
                  separatorBuilder: (context, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final material = materials[index];
                    return Card(
                      child: ListTile(
                        onTap: () => showEditMaterialDialog(material),
                        title: Text(
                          material.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Code: ${material.code}'),
                            Text('Quantity: ${material.quantity}'),
                            Text('Unit: ${material.unit}'),
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
                                  content: const Text(
                                    'هل تريد حذف هذه المادة؟',
                                  ),
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
                                        await materialsService.deleteMaterial(
                                          material.id,
                                        );
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
              onPressed: showAddMaterialDialog,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
