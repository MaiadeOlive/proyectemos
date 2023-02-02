import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyectemos/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/firebase/db_firestore_helper.dart';

class ProyectemosRepository extends ChangeNotifier {
  late FirebaseFirestore db;
  late AuthService authService;
  late SharedPreferences sharedPreferences;
  late String? studentInfo;

  ProyectemosRepository({required this.authService}) {
    _startRepository();
  }

  _startRepository() async {
    await _startFirestore();
  }

  _startFirestore() {
    db = DBFirestore.get();
  }

  Future saveAnswers(doc, answer) async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentInfo = sharedPreferences.getString('studentInfo');
    await db
        .collection('educandos/$studentInfo/${authService.userAuth!.email}/')
        .doc(doc)
        .set(answer);

    notifyListeners();
  }

  Future getAnswers(doc) async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentInfo = sharedPreferences.getString('studentInfo');
    List tasksAnswers = [];

    final DocumentReference document = db
        .collection("educandos/$studentInfo/${authService.userAuth!.email}/")
        .doc("/$doc");

    try {
      await document.get().then((snapshot) {
        if (snapshot.data() != null) {
          tasksAnswers.add(snapshot.data());
        }
      });
    } on FirebaseException catch (e) {
      return e.toString();
    }
    notifyListeners();
    return tasksAnswers;
  }

  Future getAllStudentsAnswers() async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentInfo = sharedPreferences.getString('studentInfo');
    List tasksAnswers = [];

    final DocumentReference document =
        db.collection("educandos/").doc("/$studentInfo");

    try {
      await document.get().then((snapshot) {
        if (snapshot.data() != null) {
          tasksAnswers.add(snapshot.data());
        }
      });
    } on FirebaseException catch (e) {
      return e.toString();
    }
    notifyListeners();
    return tasksAnswers;
  }

  removeAnswers(doc) async {
    sharedPreferences = await SharedPreferences.getInstance();
    studentInfo = sharedPreferences.getString('studentInfo');
    await db
        .collection('educandos/$studentInfo${authService.userAuth!.email}/')
        .doc(doc)
        .delete();

    notifyListeners();
  }

  String getUserInfo() {
    return '$studentInfo/${authService.userAuth!.displayName}';
  }

  getUserAuthToken() {
    return authService.userAuth?.getIdToken();
  }
}
