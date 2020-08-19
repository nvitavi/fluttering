import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:registration_app/model/user.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    WidgetsFlutterBinding.ensureInitialized();
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "data_flutter.db");

    // Only copy if the database doesn't exist
    //if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound){
    // Load database from asset and copy
    ByteData data = await rootBundle.load(join('data', 'flutter.db'));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Save copied asset to documents
    await new File(path).writeAsBytes(bytes);
    //}

    var ourDb = await openDatabase(
      path,
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          //"CREATE TABLE user(id INTEGER PRIMARY KEY, first_name TEXT,last_name TEXT, password TEXT,image TEXT)",
          "CREATE TABLE user(id INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT, password TEXT)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
    return ourDb;
  }
}
