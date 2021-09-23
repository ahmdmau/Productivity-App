import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:productivity_app/data/models/project_model.dart';
import 'package:productivity_app/data/models/user_model.dart';
import 'package:productivity_app/data/models/work_model.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> createNewUser(UserModel user, User firebaseUser) async {
    try {
      await _firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .set(user.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUserData(String uid) async {
    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(uid).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return UserModel.fromMap(data);
  }

  // Project
  Future<List<ProjectModel>> getProject(String uid) async {
    QuerySnapshot snapshot = await _firestore
        .collection('project')
        .orderBy('createdAt', descending: true)
        .get();
    final User user = auth.currentUser!;
    final uid = user.uid;
    var documents = snapshot.docs.where((document) {
      var data = document.data() as Map;
      return data['userID'] == uid;
    });

    return documents.map((e) => ProjectModel.fromMap(e.data() as Map)).toList();
  }

  Future<void> createProject(ProjectModel projectModel) async {
    final User user = auth.currentUser!;
    final uid = user.uid;
    _firestore.collection('project').doc().set({
      'id': projectModel.id,
      'userID': uid,
      'projectName': projectModel.projectName,
      'projectLocation': projectModel.projectLocation,
      'createdAt': Timestamp.now()
    });
  }

  // Work
  Future<List<WorkModel>> getWorkByType(
      String projectID, String typeOfWorkId) async {
    final User user = auth.currentUser!;
    final uid = user.uid;
    QuerySnapshot snapshot = await _firestore
        .collection('work')
        .orderBy('createdAt', descending: true)
        .get();

    var documents = snapshot.docs.where((document) {
      var data = document.data() as Map;
      return data['idTypeWork'] == typeOfWorkId &&
          data["userId"] == uid &&
          data["idProject"] == projectID;
    });

    return documents.map((e) {
      return WorkModel.fromMap(e.data() as Map);
    }).toList();
  }

  Future<void> addWork(WorkModel workModel) async {
    _firestore.collection('work').doc().set(workModel.toJson());
  }

  Stream<List<WorkModel>> workStream(String projectID, String typeOfWorkId) {
    final User user = auth.currentUser!;
    final uid = user.uid;
    return _firestore
        .collection("work")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map(
      (QuerySnapshot query) {
        // List<WorkModel> retVal = [];
        var documents = query.docs.where((document) {
          var data = document.data() as Map;
          print("Ahmad ${data.length}");
          return data['idTypeWork'] == typeOfWorkId &&
              data["userId"] == uid &&
              data["idProject"] == projectID;
        });
        return documents.map((e) {
          return WorkModel.fromMap(e.data() as Map);
        }).toList();
      },
    );
  }

  Future<void> deleteCollection(String id) {
    return _firestore.collection('work').where('id', isEqualTo: id).get().then(
      (value) {
        value.docs.forEach(
          (element) {
            print("Deleted");
            element.reference.delete();
          },
        );
      },
    );
  }

  // Future<UserModel> getUser(String uid) async {
  //   try {WorkModel
  // DocumentSnapshot _doc =
  //     await _firestore.collection("users").document(uid).get();

  //     return UserModel.fromDocumentSnapshot(documentSnapshot: _doc);
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }

  // Future<void> addTodo(String content, String uid) async {
  //   try {
  //     await _firestore
  //         .collection("users")
  //         .document(uid)
  //         .collection("todos")
  //         .add({
  //       'dateCreated': Timestamp.now(),
  //       'content': content,
  //       'done': false,
  //     });
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }

  // Stream<List<TodoModel>> todoStream(String uid) {
  //   return _firestore
  //       .collection("users")
  //       .document(uid)
  //       .collection("todos")
  //       .orderBy("dateCreated", descending: true)
  //       .snapshots()
  //       .map((QuerySnapshot query) {
  //     List<TodoModel> retVal = List();
  //     query.documents.forEach((element) {
  //       retVal.add(TodoModel.fromDocumentSnapshot(element));
  //     });
  //     return retVal;
  //   });
  // }

  // Future<void> updateTodo(bool newValue, String uid, String todoId) async {
  //   try {
  //     _firestore
  //         .collection("users")
  //         .document(uid)
  //         .collection("todos")
  //         .document(todoId)
  //         .updateData({"done": newValue});
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }
}
