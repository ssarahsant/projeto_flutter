import 'package:flutter/material.dart';
import 'main_20_dashboard.dart'; // Importe a tela do dashboard
import 'api_service.dart'; // Funções de acesso às APIs

class SelecionarLocalidade extends StatefulWidget {
  @override
  _SelecionarLocalidadeState createState() => _SelecionarLocalidadeState();
}

class _SelecionarLocalidadeState extends State<SelecionarLocalidade> {
  List<Map<String, dynamic>> localidadesComSensores = [];
  List<dynamic> sensores = []; // Tornar os sensores acessíveis no escopo da classe
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadLocalidades();
  }

  Future<void> loadLocalidades() async {
    print("Iniciando a função loadLocalidades");
    try {
      final token = await fetchToken();
      print("Token recebido: $token");
      final fetchedSensores = await fetchSensores(token!);

      print("Sensores recebidos: $fetchedSensores");

      // Atualiza o estado da variável sensores
      sensores = fetchedSensores;

      // Filtrar locais com sensores de temperatura e umidade
      final localidades = sensores
          .where((sensor) =>
              sensor['tipo'].toString().toLowerCase() == 'temperatura' ||
              sensor['tipo'].toString().toLowerCase() == 'umidade')
          .map((sensor) => sensor['localizacao'])
          .toSet()
          .toList();

      setState(() {
        localidadesComSensores = localidades
            .map((local) => {
                  'localizacao': local,
                  'sensores': sensores
                      .where((s) => s['localizacao'] == local)
                      .map((s) => {
                            'id': s['id'],
                            'tipo': s['tipo'].toString().toLowerCase(),
                          })
                      .toList(),
                  'hasTemperature': sensores.any((s) =>
                      s['localizacao'] == local &&
                      s['tipo'].toString().toLowerCase() == 'temperatura'),
                  'hasHumidity': sensores.any((s) =>
                      s['localizacao'] == local &&
                      s['tipo'].toString().toLowerCase() == 'umidade'),
                })
            .where((local) => local['hasTemperature'] && local['hasHumidity'])
            .toList();
        isLoading = false;
      });

      print("Localidades com sensores: $localidadesComSensores");
    } catch (error) {
      print("Error: $error");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Image.asset(
                'assets/senai_logo.png',
                height: 40,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, color: Colors.red);
                },
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Projeto Smart City', style: TextStyle(fontSize: 16)),
                  Text('Roberto Mange', style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: localidadesComSensores.length,
              itemBuilder: (context, index) {
                final local = localidadesComSensores[index];
                return Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      local['localizacao'],
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Text(
                      "Sensores: ${local['sensores'].map((s) => '(${s['id']}: ${s['tipo']})').join(', ')}",
                      style: TextStyle(fontSize: 14),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SensorDashboard(
                            localizacao: local['localizacao'],
                            idSensorTemperatura: local['sensores']
                                .firstWhere((s) => s['tipo'] == 'temperatura')['id'],
                            idSensorUmidade: local['sensores']
                                .firstWhere((s) => s['tipo'] == 'umidade')['id'],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
