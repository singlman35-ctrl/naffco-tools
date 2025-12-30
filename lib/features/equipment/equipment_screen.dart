import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../app/main_layout.dart';
import 'equipment_providers.dart';
import 'equipment_model.dart';

class EquipmentScreen extends ConsumerWidget {
  const EquipmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final equipmentAsync = ref.watch(equipmentStreamProvider);
    final equipmentService = ref.read(equipmentServiceProvider);

    void showDeleteEquipmentDialog(Equipment equipment) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('تأكيد الحذف'),
            content: const Text('هل تريد حذف هذه المعدّة؟'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('إلغاء'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () async {
                  await equipmentService.deleteEquipment(equipment.id);
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

    void showAddEquipmentDialog() {
      final nameController = TextEditingController();
      final serialController = TextEditingController();
      final categoryController = TextEditingController();
      final projectIdController = TextEditingController();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('إضافة معدّة جديدة'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: serialController,
                  decoration: const InputDecoration(labelText: 'Serial Number'),
                ),
                TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
                TextField(
                  controller: projectIdController,
                  decoration: const InputDecoration(labelText: 'Project ID'),
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
                  await equipmentService.addEquipment(
                    Equipment(
                      id: '',
                      name: nameController.text,
                      serialNumber: serialController.text,
                      category: categoryController.text,
                      projectId: projectIdController.text,
                      createdAt: Timestamp.now(),
                      updatedAt: Timestamp.now(),
                    ),
                  );
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

    void showEditEquipmentDialog(Equipment equipment) {
      final nameController = TextEditingController(text: equipment.name);
      final serialController = TextEditingController(
        text: equipment.serialNumber,
      );
      final categoryController = TextEditingController(
        text: equipment.category,
      );
      final projectIdController = TextEditingController(
        text: equipment.projectId,
      );
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('تعديل المعدّة'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: serialController,
                  decoration: const InputDecoration(labelText: 'Serial Number'),
                ),
                TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
                TextField(
                  controller: projectIdController,
                  decoration: const InputDecoration(labelText: 'Project ID'),
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
                  await equipmentService.updateEquipment(
                    Equipment(
                      id: equipment.id,
                      name: nameController.text,
                      serialNumber: serialController.text,
                      category: categoryController.text,
                      projectId: projectIdController.text,
                      createdAt: equipment.createdAt,
                      updatedAt: Timestamp.now(),
                    ),
                  );
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
          equipmentAsync.when(
            data: (equipmentList) {
              return ListView.builder(
                padding: const EdgeInsets.all(24),
                itemCount: equipmentList.length,
                itemBuilder: (context, index) {
                  final equipment = equipmentList[index];
                  return Card(
                    child: ListTile(
                      title: Text(equipment.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Serial: ${equipment.serialNumber}'),
                          Text('Category: ${equipment.category}'),
                        ],
                      ),
                      onTap: () => showEditEquipmentDialog(equipment),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => showDeleteEquipmentDialog(equipment),
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
              onPressed: showAddEquipmentDialog,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
