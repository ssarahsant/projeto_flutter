// Classe model do banco de dados
// modela o banco de dados
// os atributos são os campos do banco de dados
import 'dart:ffi';

class Sensor {
  int? id;
  String? tipo;
  String? mac_address;
  double? latitude;
  double? longitude;
  String localizacao; // campo obrigário para solicitar no banco
  String? responsavel;
  String? unidade_medida;
  int? status_operacional;
  String? observacao;

  // Metodo contrutor da classe
  Sensor({
    this.id,
    this.tipo,
    this.mac_address,
    this.latitude,
    this.longitude,
    required this.localizacao, // apenas esse campo é obrgatório
    this.responsavel,
    this.unidade_medida,
    this.status_operacional,
    this.observacao,
  });

  // Convente um map (tipo de variavel) recebido no formulário em um objeto de Sensor
  // convente um json em objeto
  // USADA PARA GRAVAÇÃO
  factory Sensor.fromMap(Map<String, dynamic> json) => Sensor(
        id: json['id'],
        tipo: json['tipo'],
        mac_address: json['mac_address'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        localizacao: json['localizacao'],
        responsavel: json['responsavel'],
        unidade_medida: json['unidade_medida'],
        status_operacional: json['unidade_medida'],
        observacao: json['observacao'],
      );

  // Convente um objeto de sentor em map
  // RECUPERA DO BANCO
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'localizacao': localizacao, // somente localização é obrigatória
    };
    if (tipo != null) map['tipo'] = tipo;
    if (mac_address != null) map['mac_address'] = mac_address;
    if (latitude != null) map['latitude'] = latitude;
    if (longitude != null) map['longitude'] = longitude;
    if (responsavel != null) map['responsavel'] = responsavel;
    if (unidade_medida != null) map['unidade_medida'] = unidade_medida;
    if (observacao != null) map['observacao'] = observacao;
    if (id != null) map['id'] = id;

    return map;
  }
}
