import 'package:path/path.dart';

//em caso de problemas coma a biblioteca abaixo tente executar no terminal
//flutter pub add sqflite
import 'package:sqflite/sqflite.dart';
import 'sensor_model.dart';

class DatabaseHelper {
  //O código usa o padrão Singleton para garantir que apenas uma instância de DatabaseHelper
  //exista durante toda a execução do aplicativo.
  // Isso é especialmente útil para gerenciar conexões de banco de dados,
  //evitando múltiplas conexões simultâneas que podem causar inconsistências e aumentar o uso de recursos.

  //Essa linha inicializa _instance chamando o construtor privado DatabaseHelper._internal().
  //Como é static, essa instância é compartilhada e acessível em toda a aplicação,
  //garantindo que apenas uma instância de DatabaseHelper será criada.
  //DatabaseHelper é o tipo da variável _instance e ela recebe a instancia criada no método _internal()
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  //Quando alguém cria um objeto DatabaseHelper,
  //esse construtor é chamado, e ele sempre retorna a instância _instance.
  //Isso impede a criação de múltiplas instâncias,
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  //Resumindo as 3 linhas acima garantem que uma única instancia do BD seja criada

  static Database? _database;

  static const String _databaseName = 'sensors.db';
  static const String _tableName = 'sensors';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      //Se o banco de dados já existe e você altera a versão para uma superior (por exemplo, de 1 para 2),
      //o método onUpgrade é chamado, permitindo que você escreva lógica de migração para atualizar o esquema do banco de dados sem perder
      version: 1,
      //_onCreate será executado caso não exista as tabelas criadas.
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tipo TEXT,
        mac_address TEXT,
        latitude REAL,
        longitude REAL,
        localizacao TEXT NOT NULL, 
        responsavel TEXT,
        unidade_medida TEXT,
        status_operacional INTEGER,
        observacao TEXT
      )
    ''');
  }

  // Inserir um sensor no banco de dados
  Future<int> insertSensor(Map<String, dynamic> sensorData) async {
    Database db = await database;
    return await db.insert(_tableName, sensorData);
  }

  // Atualizar um sensor no banco de dados
  // Future<int> updateSensor(Map<String, dynamic> sensorData, int id) async {
  //   Database db = await database;
  //   return await db.update(
  //     _tableName,
  //     sensorData,
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );
  // }

  // Future<int> updateSensor(Map<String, dynamic> sensorData, int id) async {
  //   Database db = await database;
  //   return await db.update(
  //     _tableName,
  //     sensorData,
  //     where: 'id = ?',
  //     whereArgs: [id],
  //   );
  // }

  // Future<int> updateSensor(Map<String, dynamic> sensor) async {
  //   Database db = await database;
  //   return await db.update(
  //     'sensors',
  //     sensor,
  //     where: 'id = ?',
  //     whereArgs: [sensor['id']],
  //   );
  // }

  

  // Future<int> updateSensor(Sensor sensor) async {
  //   Database db = await database;
  //   return await db.update(
  //     _tableName,
  //     sensor.toMap(), // Converte o objeto Sensor para um Map
  //     where: 'id = ?',
  //     whereArgs: [sensor.id],
  //   );
  // }

  Future<int> updateSensor(Sensor sensor) async {
  Database db = await database;
  return await db.update(
    _tableName,
    sensor.toMap(), // Converte o objeto Sensor para um Map
    where: 'id = ?',
    whereArgs: [sensor.id],
   );
  }




  // Excluir um sensor pelo ID
  Future<int> deleteSensor(int id) async {
    Database db = await database;
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Obter todos os sensores
  Future<List<Sensor>> getAllSensors() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      return Sensor.fromMap(maps[i]);
    });
  }

  // Obter um sensor pelo ID
  Future<Sensor?> getSensorById(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> result = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return Sensor.fromMap(result.first);
    }
    return null;
  }
}
