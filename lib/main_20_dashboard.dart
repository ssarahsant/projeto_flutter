import 'dart:async';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'api_service.dart'; // Certifique-se de importar a função de API

class SensorDashboard extends StatefulWidget {
  final String localizacao;
  final int idSensorTemperatura;
  final int idSensorUmidade;

  SensorDashboard({
    required this.localizacao,
    required this.idSensorTemperatura,
    required this.idSensorUmidade,
  });

  @override
  _SensorDashboardState createState() => _SensorDashboardState();
}

class _SensorDashboardState extends State<SensorDashboard> {
  double temperatura = 0.0;
  double umidade = 0.0;
  //Timer? timer;
  String token = ''; // O token que será obtido

  @override
  void initState() {
    super.initState();
    _fetchToken(); // Buscando o token ao iniciar
    // Timer para atualização periódica (opcional)
    //timer = Timer.periodic(Duration(seconds: 5), (Timer t) => _getSensorData());
  }

  @override
  void dispose() {
    //timer?.cancel();
    super.dispose();
  }

  // Função para obter o token
  Future<void> _fetchToken() async {
    try {
      token = await fetchToken() ?? '';
      if (token.isNotEmpty) {
        _getSensorData(); // Chama a função de consulta após obter o token
      }
    } catch (e) {
      print('Erro ao obter token: $e');
    }
  }

  // Função para obter os dados dos sensores
  Future<void> _getSensorData() async {
    try {
      // Consulta a temperatura
      double? temp = await fetchTemperatura(widget.idSensorTemperatura, token);
      if (temp != null) {
        setState(() {
          temperatura = temp;
        });
      }

      // Consulta a umidade
      double? hum = await fetchUmidade(widget.idSensorUmidade, token);
      if (hum != null) {
        setState(() {
          umidade = hum;
        });
      }
    } catch (e) {
      print('Erro ao buscar dados dos sensores: $e');
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Localização: ${widget.localizacao}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //    child: Text(
          //      "ID Sensor de Temperatura: ${widget.idSensorTemperatura}",
          //      style: TextStyle(fontSize: 16),
          //    ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //    child: Text(
          //      "ID Sensor de Umidade: ${widget.idSensorUmidade}",
          //      style: TextStyle(fontSize: 16),
          //    ),
          // ),
          ThermometerWithScale(temperatura: temperatura.toInt()),
          SizedBox(height: 2),
          HumidityGauge(umidade: umidade),
        ],
      ),
    );
  }
}

// Resto do código dos widgets ThermometerWithScale e HumidityGauge permanece o mesmo...

// Widget para o termômetro
class ThermometerWithScale extends StatelessWidget {
  final int temperatura;

  const ThermometerWithScale({required this.temperatura});

  @override
  Widget build(BuildContext context) {
    const int tempMin = -5;
    const int tempMax = 45;
    const int tempRange = tempMax - tempMin;
    const double alturaTermometro = 300;
    final double alturaPreenchimento =
        (temperatura - tempMin) / tempRange * alturaTermometro;

    return Card(
      color: Colors.grey[850],
      margin: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.grey[600]!, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Temperatura',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 50,
                  height: alturaTermometro,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[600]!, width: 2),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    color: Colors.blueGrey[700],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: 50,
                          height: alturaPreenchimento,
                          decoration: BoxDecoration(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  height: alturaTermometro,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(51, (index) {
                      int temp = 45 - index;
                      return Row(
                        children: [
                          Container(
                            width: temp % 5 == 0 ? 20 : 10,
                            height: 1,
                            color: Colors.grey[600],
                          ),
                          SizedBox(width: 5),
                          temp % 5 == 0
                              ? Text('$temp°C',
                                  style: TextStyle(
                                      color: Colors.grey[400], fontSize: 12))
                              : SizedBox.shrink(),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Widget para o gauge de umidade
class HumidityGauge extends StatelessWidget {
  final double umidade;

  const HumidityGauge({required this.umidade});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      margin: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.grey[600]!, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Umidade',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 100,
                  ranges: <GaugeRange>[
                    GaugeRange(
                        startValue: 0,
                        endValue: 12,
                        color: Colors.red,
                        startWidth: 60,
                        endWidth: 60),
                    GaugeRange(
                        startValue: 12,
                        endValue: 60,
                        color: Colors.yellow,
                        startWidth: 60,
                        endWidth: 60),
                    GaugeRange(
                        startValue: 60,
                        endValue: 100,
                        color: Colors.green,
                        startWidth: 60,
                        endWidth: 60),
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(
                        value: umidade, needleColor: Colors.grey[300]),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Text(
                        umidade.toStringAsFixed(1) + '%',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      angle: 90,
                      positionFactor: 0.7,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
