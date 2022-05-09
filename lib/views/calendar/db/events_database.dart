// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:touchandlist/views/calendar/model/event.dart';

// class EventsDatabase {
//   static final EventsDatabase instance = EventsDatabase._init();

//   static Database? _database;

//   EventsDatabase._init();

//   Future<Database> get database async {
//     if (_database != null) return _database!;

//     _database = await _initDB('events.db');
//     return _database!;
//   }

//   Future<Database> _initDB(String filePath) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, filePath);

//     return await openDatabase(path, version: 1, onCreate: _createDB);
//   }

//   Future _createDB(Database db, int version) async {
//     const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
//     const textType = 'TEXT NOT NULL';
//     const boolType = 'BOOLEAN DEFAULT 0';
//     const integerType = 'INTEGER NOT NULL';

//     await db.execute('''
// CREATE TABLE $tableEvents ( 
//   ${EventFields.id} $idType,
//   ${EventFields.title} $textType,
//   ${EventFields.description} $textType,
//   ${EventFields.starts} $textType,
//   ${EventFields.ends} $textType,
//   ${EventFields.isAllDay} $boolType,
//   ${EventFields.ownerUserId} $textType
//   )
// ''');
//   }

//   Future<Event> create(Event event) async {
//     final db = await instance.database;

//     // final json = note.toJsonSql();
//     // final columns =
//     //     '${NoteFields.title}, ${NoteFields.description}, ${NoteFields.time}';
//     // final values =
//     //     '${json[NoteFields.title]}, ${json[NoteFields.description]}, ${json[NoteFields.time]}';
//     // final id = await db
//     //     .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

//     final id = await db.insert(tableEvents, event.toJsonSql());
//     return event.copy(id: id);
//   }

//   Future<Event> readEvent(int id) async {
//     final db = await instance.database;

//     final maps = await db.query(
//       tableEvents,
//       columns: EventFields.values,
//       where: '${EventFields.id} = ?',
//       whereArgs: [id],
//     );

//     if (maps.isNotEmpty) {
//       return Event.fromJson(maps.first);
//     } else {
//       throw Exception('ID $id not found');
//     }
//   }

//   Future<List<Event>> readAllEvents() async {
//     final db = await instance.database;
//     final result = await db.query(
//       tableEvents,
//     );
//     return result.map((json) => Event.fromJson(json)).toList();
//   }

//   Future<int> update(Event event) async {
//     final db = await instance.database;

//     return db.update(
//       tableEvents,
//       event.toJsonSql(),
//       where: '${EventFields.id} = ?',
//       whereArgs: [event.id],
//     );
//   }

//   Future<int> delete(int id) async {
//     final db = await instance.database;

//     return await db.delete(
//       tableEvents,
//       where: '${EventFields.id} = ?',
//       whereArgs: [id],
//     );
//   }

//   Future close() async {
//     final db = await instance.database;

//     db.close();
//   }
// }
