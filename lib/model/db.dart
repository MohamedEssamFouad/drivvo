import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DrivoDB {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDB();
    }
    return _db;
  }

  Future<Database> initDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'drivo.db');
    return await openDatabase(path,
        version: 3,
        onCreate: (Database db, int version) async {
          await db.execute('''
          CREATE TABLE UserCar (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            userId TEXT,
            carModel TEXT
          )
          ''');
          await db.execute('''
          CREATE TABLE CarService (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            serviceType TEXT,
            serviceDate TEXT,
            serviceTime TEXT,
            nextServiceDate TEXT,
            Place TEXT,
            value TEXT
          )
          ''');
          await db.execute('''
          CREATE TABLE ServiceKilometer (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            carId INTEGER,
            kilometers INTEGER,
            note TEXT,
            FOREIGN KEY (carId) REFERENCES CarService(id)
          )
        ''');
          await db.execute('''
  CREATE TABLE ServicePlace(
   id INTEGER PRIMARY KEY AUTOINCREMENT,
   servId INTEGER,
   Location TEXT,
   Name TEXT,
   PlaceLocation TEXT,
   PlaceType TEXT,
   IconIdentifier TEXT
  )
''');
          await db.execute('''
            CREATE TABLE Reminders(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              remId INTEGER,
              Typeserv TEXT,
              serviceDate TEXT,
              Counter TEXT,
              Note TEXT
            
            )
          ''');

        });
  }

  Future<void> updateReminder(int id, Map<String, dynamic> reminderData) async {
    final dbClient = await db;
    await dbClient?.update(
      'Reminders',
      reminderData,
      where: 'id = ?',
      whereArgs: [id],
    );
    print("Reminder updated: $reminderData");
  }
  Future<void>insertServicePlace(Map<String,dynamic>servicee)async{
    final dbClient=await db;
    await dbClient?.insert('ServicePlace', servicee);

  }
  Future<void>insertReminder(Map<String,dynamic>remi)async{
    final dbClient=await db;
    await dbClient?.insert('Reminders', remi);
  }

  Future<int> insertCarService(Map<String, dynamic> service) async {
    final dbClient = await db;
    final int id = await dbClient!.insert('CarService', service);
    return id; // Return the ID of the new row
  }


  Future<List<Map<String, dynamic>>> getCarServices() async {
    final dbClient = await db;
    return dbClient!.query('CarService');
  }

  Future<void> updateCarService(int id, Map<String, dynamic> service) async {
    final dbClient = await db;
    await dbClient?.update(
      'CarService',
      service,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertServiceKilometer(Map<String, dynamic> kilometerData) async {
    final dbClient = await db;
    await dbClient?.insert('ServiceKilometer', kilometerData);
  }

  Future<List<Map<String, dynamic>>> getServiceKilometers() async {
    final dbClient = await db;
    return dbClient!.query('ServiceKilometer');
  }
  Future<Map<String, dynamic>?> getServicePlaceByServId(int servId) async {
    final dbClient = await db;
    final List<Map<String, dynamic>> result = await dbClient!.query(
      'ServicePlace',
      where: 'servId = ?',
      whereArgs: [servId],
    );
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }
  Future<List<Map<String, dynamic>>> getReminders() async {
    final dbClient = await db;
    return dbClient!.query('Reminders');
  }




  Future<void> updateServiceKilometer(int id, Map<String, dynamic> kilometerData) async {
    final dbClient = await db;
    await dbClient?.update(
      'ServiceKilometer',
      kilometerData,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertUserCar(Map<String, dynamic> userCarData) async {
    final dbClient = await db;
    await dbClient!.insert('UserCar', userCarData);
  }

  Future<List<Map<String, dynamic>>> getUserCars() async {
    final dbClient = await db;
    return dbClient!.query('UserCar');
  }

  Future<void> updateUserCar(int id, Map<String, dynamic> userCarData) async {
    final dbClient = await db;
    await dbClient?.update(
      'UserCar',
      userCarData,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
