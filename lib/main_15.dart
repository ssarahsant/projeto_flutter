import 'package:flutter/material.dart';
import 'main_16_segunda_tela.dart'; // Importe a Segunda_Tela_App
import 'database_helper.dart'; // Importe o DatabaseHelper
import 'sensor_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Sensor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyAppScreen(), // Inicializa a tela principal
    );
  }
}

class MyAppScreen extends StatefulWidget {
  final Map<String, dynamic>? sensor; // Parâmetro opcional para edição

  const MyAppScreen({Key? key, this.sensor}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyAppScreen> {
  String tipo = '';
  String macAddress = '';
  double? latitude;
  double? longitude;
  String localizacao = '';
  String responsavel = '';
  String unidadeMedida = '';
  bool statusOperacional = true;
  String observacao = '';

  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _macAddressController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _localizacaoController = TextEditingController();
  final TextEditingController _responsavelController = TextEditingController();
  final TextEditingController _unidadeMedidaController = TextEditingController();
  final TextEditingController _observacaoController = TextEditingController();

  final DatabaseHelper _dbHelper = DatabaseHelper(); // Instância do helper do banco de dados

  @override
  void initState() {
    super.initState();
    // Se um sensor foi passado, inicialize os campos para edição
    if (widget.sensor != null) {
      _tipoController.text = widget.sensor!['tipo'];
      _macAddressController.text = widget.sensor!['mac_address'];
      _latitudeController.text = widget.sensor!['latitude']?.toString() ?? '';
      _longitudeController.text = widget.sensor!['longitude']?.toString() ?? '';
      _localizacaoController.text = widget.sensor!['localizacao'];
      _responsavelController.text = widget.sensor!['responsavel'];
      _unidadeMedidaController.text = widget.sensor!['unidade_medida'];
      _observacaoController.text = widget.sensor!['observacao'];
      statusOperacional = widget.sensor!['status_operacional'] == 1;
    }
  }

  @override
  void dispose() {
    _tipoController.dispose();
    _macAddressController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _localizacaoController.dispose();
    _responsavelController.dispose();
    _unidadeMedidaController.dispose();
    _observacaoController.dispose();
    super.dispose();
  }

  Future<void> _salvarDados() async {
    // Criar um objeto Sensor a partir dos dados do formulário
    Sensor sensor = Sensor(
      id: widget.sensor != null ? widget.sensor!['id'] : null,
      tipo: _tipoController.text,
      mac_address: _macAddressController.text,
      latitude: double.tryParse(_latitudeController.text),
      longitude: double.tryParse(_longitudeController.text),
      localizacao: _localizacaoController.text,
      responsavel: _responsavelController.text,
      unidade_medida: _unidadeMedidaController.text,
      status_operacional: statusOperacional ? 1 : 0, // Corrigido para valor binário
      observacao: _observacaoController.text,
    );

    if (widget.sensor == null) {
      // Se não estiver editando, insira um novo sensor
      await _dbHelper.insertSensor(sensor.toMap()); // Assumindo que insertSensor aceita Map
    } else {
      // Se estiver editando, atualize o sensor existente
      await _dbHelper.updateSensor(sensor);
    }

    _mostrarMensagemCadastroSucesso();
  }

  void _mostrarMensagemCadastroSucesso() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cadastro de Sensor'),
          content: Text(widget.sensor == null ? 'Sensor Cadastrado com Sucesso!!!' : 'Sensor Atualizado com Sucesso!!!'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
                _limparCampos(); // Limpa os campos após fechar o diálogo
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyAppScreen()), // Chama a tela principal novamente
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _limparCampos() {
    // Limpar os campos e redefinir as variáveis
    setState(() {
      tipo = '';
      macAddress = '';
      latitude = null;
      longitude = null;
      localizacao = '';
      responsavel = '';
      unidadeMedida = '';
      statusOperacional = true;
      observacao = '';

      // Limpa os controllers
      _tipoController.clear();
      _macAddressController.clear();
      _latitudeController.clear();
      _longitudeController.clear();
      _localizacaoController.clear();
      _responsavelController.clear();
      _unidadeMedidaController.clear();
      _observacaoController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Sensor'),
        backgroundColor: Colors.grey[300],
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Tela Principal'),
              onTap: () {
                Navigator.pop(context); // Fecha o drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_forward),
              title: Text('Segunda Tela'),
              onTap: () {
                Navigator.pop(context); // Fecha o drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Segunda_Tela_App()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),

            // Campo Tipo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _tipoController,
                decoration: InputDecoration(
                  labelText: 'Tipo',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  tipo = value;
                },
              ),
            ),
            SizedBox(height: 10),

            // Campo Mac Address
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _macAddressController,
                decoration: InputDecoration(
                  labelText: 'Mac Address',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  macAddress = value;
                },
              ),
            ),
            SizedBox(height: 10),

            // Campo Latitude
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _latitudeController,
                decoration: InputDecoration(
                  labelText: 'Latitude',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    latitude = double.tryParse(value); // Convertendo String para double
                  });
                },
              ),
            ),

            // Campo Longitude
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _longitudeController,
                decoration: InputDecoration(
                  labelText: 'Longitude',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    longitude = double.tryParse(value); // Convertendo String para double
                  });
                },
              ),
            ),

            // Campo Localização
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _localizacaoController,
                decoration: InputDecoration(
                  labelText: 'Localização',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  localizacao = value;
                },
              ),
            ),
            SizedBox(height: 10),

            // Campo Responsável
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _responsavelController,
                decoration: InputDecoration(
                  labelText: 'Responsável',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  responsavel = value;
                },
              ),
            ),
            SizedBox(height: 10),

            // Campo Unidade de Medida
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _unidadeMedidaController,
                decoration: InputDecoration(
                  labelText: 'Unidade de Medida',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  unidadeMedida = value;
                },
              ),
            ),
            SizedBox(height: 10),

            // Campo Status Operacional
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ativo'),
                Switch(
                  value: statusOperacional,
                  onChanged: (value) {
                    setState(() {
                      statusOperacional = value;
                    });
                  },
                ),
                Text('Inativo'),
              ],
            ),

            // Campo Observação
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _observacaoController,
                decoration: InputDecoration(
                  labelText: 'Observação',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  observacao = value;
                },
              ),
            ),
            SizedBox(height: 20),

            // Botão para salvar dados
            ElevatedButton(
              onPressed: _salvarDados,
              child: Text(widget.sensor == null ? 'Cadastrar' : 'Atualizar'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
