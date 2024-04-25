import 'package:vets_uo276922_dart_api/db_manager.dart';
import 'package:vets_uo276922_dart_api/models/vet.dart';

class VetsRepository {
  static DbManager dbManager = DbManager.collection("vets");
  static Future<dynamic> insertOne(Vet vet) async {
    final result = await dbManager.insertOne(vet.toJsonInsert());
    return result;
  }

  static Future<dynamic> findAll() async {
    final result = await dbManager.findAll();
    return result;
  }

  static Future<dynamic> findOne(Map<String, dynamic> filter) async {
    final result = await dbManager.findOne(filter);
    return result;
  }
}
