import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathprovider;

class HiveService {
  static var box;

  static initHive() async {
    var dir = await pathprovider.getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('appData');
  }

  ///   user Role             ///
  static setUserRole(String name) {
    box.put('role', name);
  }

  static getUserRole() {
    return box.get('role');
  }

  static deleteUserRole() {
    box.delete('role');
  }

  ///             user name         ///
  static setUserName(String name) {
    box.put('name', name);
  }

  static String getUserName() {
    return box.get('name');
  }

  ///            user ID      ///
  static setUserID(String id) {
    box.put('id', id);
  }

  static getUserID() {
    return box.get('id');
  }

  static deleteUserID() {
    box.delete('id');
  }

  ///           token        ///

  static setToken(String token) {
    box.put('token', token);
  }

  static getToken() {
    return box.get('token');
  }

  static deleteToken() {
    box.delete('token');
  }

  ///   for Static Student    ///
  static setStaticStudent({
    required String userid,
    required String role,
    required String token,
  }) {
    box.put('staticStudentID', userid);
    box.put('staticStudentRole', role);
    box.put('staticStudentToken', token);
  }

  static Future<List<dynamic>> getStaticStudent() async {
    return [
      box.get('staticStudentID'),
      box.get('staticStudentRole'),
      box.get('staticStudentToken'),
    ];
  }

  static deleteStaticStudent() {
    box.delete('staticStudentID');
    box.delete('staticStudentRole');
    box.delete('staticStudentToken');
  }

  ///   for Static Instructor      ///
  static setStaticInstructor({
    required String userid,
    required String role,
    required String token,
  }) {
    box.put('staticInstructorID', userid);
    box.put('staticInstructorRole', role);
    box.put('staticInstructorToken', token);
  }

  static Future<List<dynamic>> getStaticInstructor() async {
    return [
      box.get('staticInstructorID'),
      box.get('staticInstructorRole'),
      box.get('staticInstructorToken'),
    ];
  }

  static deleteStaticInstructor() {
    box.delete('staticInstructorID');
    box.delete('staticInstructorRole');
    box.delete('staticInstructorToken');
  }

  ///  firebase token
  static setFirebaseToken(String firebaseToken) {
    box.put('firebaseToken', firebaseToken);
  }

  static deleteFirebaseToken() {
    box.delete('firebaseToken');
  }

  static Future<String?> getFirebaseToken() async {
    return await box.get('firebaseToken');
  }

  ///  for language
  static setLanguage(String language) {
    box.put('language', language);
  }

  static getLanguage() {
    return box.get('language', defaultValue: 'en_en');
  }

  ///   for Onboard Screen
  static Future<bool> getOnBoardShowed() async {
    return box?.get('onboard') ?? false;
  }

  static void setOnBoardShowed(bool value) {
    if (value) {
      box?.put('onboard', value);
    } else {
      box?.delete('onboard');
    }
  }
}
