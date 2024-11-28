// api_service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String?> fetchToken() async {
  final response = await http.post(
    //Uri.parse('http://192.168.239.18:8000/api/token/'), //Internet Senai_Campinas
    Uri.parse('http://10.109.71.26:8000/api/token/'), //Internet Senai_Campinas
    
    body: {
      'username': 'smart_user',
      'password': '123456',
    },
  );

  print("Status da resposta: ${response.statusCode}");
  print("Corpo da resposta: ${response.body}");

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print("Dados decodificados: $data");
    return data['access'];
  } else {
    throw Exception('Failed to retrieve token');
  }
}

Future<List<Map<String, dynamic>>> fetchSensores(String token) async {
  final response = await http.get(
    
    //Uri.parse('http://192.168.239.18:8000/api/sensores'),
    Uri.parse('http://10.109.71.26:8000/api/sensores'),
    
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    // Decodificar usando bodyBytes para evitar problemas com UTF-8
    final decodedResponse = utf8.decode(response.bodyBytes);
    final List<dynamic> sensores = jsonDecode(decodedResponse);

    // Converte para List<Map<String, dynamic>> para garantir o tipo
    return List<Map<String, dynamic>>.from(sensores);
  } else {
    throw Exception('Failed to load sensors');
  }
}

// Adicione essas funções ao seu arquivo api_service.dart

// Função para buscar o valor da temperatura
Future<double?> fetchTemperatura(int sensorId, String token) async {
  final response = await http.post(
    //Uri.parse('http://192.168.239.18:8000/api/temperatura_filter/'),
    Uri.parse('http://10.109.71.26:8000/api/temperatura_filter/'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Especificando o tipo de conteúdo
      //Sempre que estiver passando dados JSON 
      //em uma requisição HTTP, você deve incluir o cabeçalho Content-Type: application/json. 
      //Isso assegura que os dados sejam reconhecidos corretamente pelo servidor.
    },
    //Uso de jsonEncode: O método jsonEncode converte o mapa de dados em uma string JSON, que é passada como o corpo da requisição.
    body: jsonEncode({
      'sensor_id': sensorId,
      'latest': true,
    }),
    // body: {
    //   'sensor_id': sensorId,
    //   'latest': true,
    // },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['valor']?.toDouble();
  } else {
    throw Exception('Failed to load temperatura');
  }
}

// Função para buscar o valor da umidade
Future<double?> fetchUmidade(int sensorId, String token) async {
  final response = await http.post(
    //Uri.parse('http://192.168.239.18:8000/api/umidade_filter/'),
    Uri.parse('http://10.109.71.26:8000/api/umidade_filter/'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json', // Especificando o tipo de conteúdo
    },
    body: jsonEncode({
      'sensor_id': sensorId,
      'latest': true,
    }),
    // body: {
    //   'sensor_id': sensorId,
    //   'latest': true,
    // },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['valor']?.toDouble();
  } else {
    throw Exception('Failed to load umidade');
  }
}
