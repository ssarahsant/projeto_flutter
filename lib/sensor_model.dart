class Sensor {
  int? id;
  String? tipo;
  String? mac_address;
  double? latitude;
  double? longitude;
  String localizacao; // obrigatório
  String? responsavel;
  String? unidade_medida;
  int? status_operacional;
  String? observacao;

  Sensor({
    this.id,
    this.tipo,
    this.mac_address,
    this.latitude,
    this.longitude,
    required this.localizacao, // apenas este campo é obrigatório
    this.responsavel,
    this.unidade_medida,
    this.status_operacional,
    this.observacao,
  });

  // Converte um Map para um objeto Sensor
  factory Sensor.fromMap(Map<String, dynamic> json) => Sensor(
        id: json['id'],
        tipo: json['tipo'],
        mac_address: json['mac_address'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        localizacao: json['localizacao'],
        responsavel: json['responsavel'],
        unidade_medida: json['unidade_medida'],
        status_operacional: json['status_operacional'],
        observacao: json['observacao'],
      );

  // Converte um objeto Sensor para um Map
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'localizacao': localizacao, // somente a localização é obrigatória
    };
    if (tipo != null) map['tipo'] = tipo;
    if (mac_address != null) map['mac_address'] = mac_address;
    if (latitude != null) map['latitude'] = latitude;
    if (longitude != null) map['longitude'] = longitude;
    if (responsavel != null) map['responsavel'] = responsavel;
    if (unidade_medida != null) map['unidade_medida'] = unidade_medida;
    if (status_operacional != null) map['status_operacional'] = status_operacional;
    if (observacao != null) map['observacao'] = observacao;
    if (id != null) map['id'] = id;

    return map;
  }
}
