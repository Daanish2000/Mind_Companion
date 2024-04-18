import 'dart:developer';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:io' as io;

import '../../model/localdb_models/addtask_model.dart';

class DBHelper {
  String mindCompanion = 'mindCompanion';

  String taskId = 'taskId';
  String taskTitle = 'taskTitle';
  String taskDescription = 'taskDescription';
  String taskDate = 'taskDate';
  String taskTime = 'taskTime';
  String taskColor = 'taskColor';
  String isAudio = 'isAudio';
  String isCompleted = 'isCompleted';
  String isInProgress = 'isInProgress';
  String isInToDo = 'isInToDo';
  String isRepeated = 'isRepeated';
  String repeatPattern = 'repeatPattern';

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'notes.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE $mindCompanion ($taskId INTEGER PRIMARY KEY AUTOINCREMENT, $taskTitle TEXT NOT NULL,$taskDescription TEXT NOT NULL,$taskDate TEXT NOT NULL,$taskTime TEXT NOT NULL,$taskColor INTEGER,$isAudio INTEGER,$isCompleted INTEGER,$isInProgress INTEGER,$isInToDo INTEGER,$isRepeated INTEGER,$repeatPattern TEXT NOT NULL)",
    );
  }

  Future<int> insertTask(AddTaskDBModel addTaskDBModel) async {
    var dbClient = await db;
    var id = await dbClient!.insert(mindCompanion, addTaskDBModel.toMap());
    log("ID===$id");
    return id;
  }

  Future<List<AddTaskDBModel>> getTaskListWithTaskId() async {
    var dbClient = await db;

    final List<Map<String, Object?>> queryResult =
        await dbClient!.query(mindCompanion);
    return queryResult.map((e) => AddTaskDBModel.fromMapObject(e)).toList();
  }

  Future deleteTableContent() async {
    var dbClient = await db;
    return await dbClient!.delete(
      mindCompanion,
    );
  }

  Future<int> updateTask(AddTaskDBModel addTaskDBModel) async {
    var dbClient = await db;
    return await dbClient!.update(
      mindCompanion,
      addTaskDBModel.toMap(),
      where: 'taskId = ?',
      whereArgs: [addTaskDBModel.taskId],
    );
  }

  Future<int> deleteTask(int taskId) async {
    var dbClient = await db;
    return await dbClient!.delete(
      mindCompanion,
      where: 'taskId = ?',
      whereArgs: [taskId],
    );
  }

  Future close() async {
    var dbClient = await db;
    dbClient!.close();
  }
}
