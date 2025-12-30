import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../app/main_layout.dart';
import 'equipment_movement_model.dart';
import 'equipment_movement_providers.dart';

class EquipmentMovementsScreen extends ConsumerWidget {
  const EquipmentMovementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movementsAsync = ref.watch(equipmentMovementsStreamProvider);
    final movementService = ref.read(equipmentMovementServiceProvider);

    void showAddMovementDialog() {
      final equipmentIdController = TextEditingController();
      final fromProjectIdController = TextEditingController();
      final toProjectIdController = TextEditingController();
      final engineerNameController = TextEditingController();
      final movementTypeController = TextEditingController();
      final notesController = TextEditingController();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('إضافة حركة معدات'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: equipmentIdController,
                    decoration: const InputDecoration(
                      labelText: 'Equipment ID',
                    ),
                  ),
                  TextField(
                    controller: fromProjectIdController,
                    decoration: const InputDecoration(
                      labelText: 'From Project ID',
                    ),
                  ),
                  TextField(
                    controller: toProjectIdController,
                    decoration: const InputDecoration(
                      labelText: 'To Project ID',
                    ),
                  ),
                  TextField(
                    controller: engineerNameController,
                    decoration: const InputDecoration(
                      labelText: 'Engineer Name',
                    ),
                  ),
                  TextField(
                    controller: movementTypeController,
                    decoration: const InputDecoration(
                      labelText: 'Movement Type',
                    ),
                  ),
                  TextField(
                    controller: notesController,
                    decoration: const InputDecoration(labelText: 'Notes'),
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
                  final movement = EquipmentMovement(
                    id: '',
                    equipmentId: equipmentIdController.text,
                    fromProjectId: fromProjectIdController.text,
                    toProjectId: toProjectIdController.text,
                    engineerName: engineerNameController.text,
                    movementType: movementTypeController.text,
                    notes: notesController.text,
                    createdAt: Timestamp.now(),
                    updatedAt: Timestamp.now(),
                  );
                  await movementService.addEquipmentMovement(movement);
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

    return MainLayout(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: movementsAsync.when(
              data: (movements) {
                if (movements.isEmpty) {
                  return Center(
                    child: Text(
                      'لا توجد حركات حتى الآن.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  );
                }
                return ListView.separated(
                  itemCount: movements.length,
                  separatorBuilder: (context, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final movement = movements[index];
                    return Card(
                      child: ListTile(
                        title: Text(
                          movement.equipmentId,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('نوع الحركة: ${movement.movementType}'),
                            Text('المهندس: ${movement.engineerName}'),
                          ],
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
              onPressed: showAddMovementDialog,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
