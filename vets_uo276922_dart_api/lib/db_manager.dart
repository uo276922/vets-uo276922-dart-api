import 'package:mongo_dart/mongo_dart.dart';

class DbManager {
  String _dbName = "vets-dart-api";
  String _collectionName = " users";
  late dynamic _collection;
  late Db _db;
  DbManager(String dbName, String collectionName) {
    _dbName = dbName;
    _collectionName = collectionName;
  }
  DbManager.collection(String collectionName) {
    _collectionName = collectionName;
  }
  Future<void> connect() async {
    final dbUrl =
        'mongodb+srv://uo276922:admin@vets-dart-api.ferpyu6.mongodb.net/$_dbName';

    _db = await Db.create(dbUrl);
    await _db.open();
    _collection = _db.collection(_collectionName);
//return _db.collection(_collectionName);
  }

  Future<void> close() async {
    await _db.close();
  }

  Future<List<Map<String, dynamic>>> findAll() async {
    try {
      await connect();
      final data = await _collection.find().toList();
      return data;
    } catch (error) {
      List<Map<String, dynamic>> errorList = [];
      Map<String, dynamic> error = {
        "error": "Se ha producido un error al recupera los datos"
      };
      errorList.add(error);
      return errorList;
    } finally {
      await close();
    }
  }
}
