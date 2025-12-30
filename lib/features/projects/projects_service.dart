import 'package:cloud_firestore/cloud_firestore.dart';
import 'project_model.dart';

class ProjectsService {
  final _db = FirebaseFirestore.instance;

  Future<void> addProject(Project project) async {
    await _db.collection('projects').add(project.toMap());
  }

  Future<void> updateProject(Project project) async {
    await _db.collection('projects').doc(project.id).update(project.toMap());
  }

  Future<void> deleteProject(String id) async {
    await _db.collection('projects').doc(id).delete();
  }

  Stream<List<Project>> getProjectsStream() {
    return _db.collection('projects').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Project.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }
}
