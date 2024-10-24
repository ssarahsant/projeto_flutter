// Importações
import 'package:path/path.dart'; // biblioteca para saber onde esta dentro do aplicativo
import 'package:sqflite/sqflite.dart'; // biblioteca para usar o banco sqlite local (sem depender de conexão)
import 'sensor_model.dart'; // importa o model

// Classe para CRUD do banco
// Instancia de banco de dados
class DatabaseHelper {
  // Permite que crie omente uma instancia no banco de dados em toda a aplicação
  // A aplicação usa o mesmo banco de dados
  // declara final (constante) quando não sabe o valor quando compila.
  // _.intance = nome da variavel
  // _internal faz como que cria somente uma instancia do banco de dados
  // static, toda vez que chamar a classe ele ve que existe a variavel e responde a _instance, ao invês de criar outra
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  // Declaração da varivale database do tipo banco de dados, que pode ser nulo quando não foi criado ainda
  static Database? _database;

  // Varivael para o banco de dados
  static const String _databaseName = 'sensors.db';
  // Variavel para a tabela do banco de dadso
  static const String _tableName = 'sensors';

  // Inicializa o banco e retona a instancia do banco
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Criação do método que incializa o banco, toda vez que incializar vai ver se o banco ta criado
  // se o banco não estiver criado ele vai executar o metodo que cria o banco
  // future = esse metodo pode demorar para responder
  // await = espera antes de proseguir o código espera a excecução até receber uma resposta
  // isso serve para o sistema chamar o metodo e esperar ele dar um resposta.
  // o banco de dados pode dar uma resposta ou não, por isspo o código deve esperar para conuar executando
  Future<Database> _initDatabase() async {
    // concatenação para achar o caminho do banco de dados
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      // Se o banco de dados já existe e vpcê altera a versão para um superior (da versão 1 para versão 2)
      // o método onUpgrade é chamado, permitindo que você escreva lógica de migração para atualizar o
      // esquema do banco de dados, sem perder o que já tinha
      // serve para fazer uma gestão de atualizações nos campos, indica a versão quando cria novas tabelas
      // quando a versão altera o código executa o on create
      version: 1,
      // _oncreate será executado caso não exista as tabelas criadas
      // chama o metodo que fará a criação
      onCreate: _onCreate,
    );
  }

  // Metodo para criar as tabelas no banco de dados local
  // Instruções sql direto no banco de dados
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tipo TEXT,
        mac_address TEXT,
        latitute REAL,
        longitude REAL,
        localizacao TEXT NOT NULL,
        responsavel TEXT,
        unidade de medida TEXT,
        status_operacional INTEGER,
        observacao TEXT
      )
    ''');
  }

  // CREATE
  // Metodo para inserir um sensor no banco de dados
  Future<int> insertSensor(Map<String, dynamic> sensorData) async {
    Database db = await database;
    return await db.insert(_tableName, sensorData);
  }

  // UPDATE
  // Metódo para alterar um sensor no banco de dados
  Future<int> updateSensor(Map<String, dynamic> sensorData, int id) async {
    Database db = await database;
    return await db.update(
      _tableName,
      sensorData,
      where: 'id = :',
      whereArgs: [id],
    );
  }

  // DELETE
  // Metódo que exclui um sensor através do ID (apaga sensor especifico)
  Future<int> deleteSensor(int id) async {
    Database db = await database;
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // READ
  // Metodo que cria uma lista com todos os sensores (obtem todos os sensores)

  Future<List<Sensor>> getAllSensors() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      return Sensor.fromMap(maps[i]);
    });
  }

  // READ DE UM ESPEFICO
  // Metódo que lista um sensor espefico através do ID
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
