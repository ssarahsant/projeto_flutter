import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart'; // classes que compoem os componentes da tela


main(){
  runApp(Projeto01App());
}

class Projeto01App extends StatefulWidget{
  const Projeto01App ({super.key});
  @override
  Projeto01AppState createState() => Projeto01AppState();
}

class Projeto01AppState extends State<Projeto01App>{ // extendes pq e a classe pai

  //constrtuor da claase , sempre vai estanciar aqui ou seja , sempre vai execuatr esse metodo primeiro
  //seta como esses parametros em que se comportar e mapear os vaores

//criando outro metodo , para construir a home
//para criar a classe e carregar os componentes cria o widget


String texto = "Cnstruindo App da Turma";
// Declaração de variaveis para armazenar os dados de cada campo
String localSensor = ''; // Armazena o texto do sensor
String tipoSensor =''; // Armazena o texto do sensor
String macAdress = ''; //Armazena o texto do sensor
String Latitude = ''; //Armazena o texto do sensor
String Longitude = ''; //Armazena o texto do sensor
String Responsavel = '';//Armazena o texto do sensor
String Observacao = ''; //Armazena o texto do sensor

// Declaração de variaveis para criar um controller de cada campo
final TextEditingController _controller = TextEditingController();// privado //final: e uma contsante que vai defibir dps
final TextEditingController _tipocontroller = TextEditingController();// privado //final: e uma contsante que vai defibir dps
final TextEditingController _macadresscontroller = TextEditingController();// privado //final: e uma contsante que vai defibir dps
final TextEditingController _latitudecontroller = TextEditingController();// privado //final: e uma contsante que vai defibir dps
final TextEditingController _longitudecontroller = TextEditingController();// privado //final: e uma contsante que vai defibir dps
final TextEditingController _responsavelcontroller = TextEditingController();// privado //final: e uma contsante que vai defibir dps
final TextEditingController _observacaocontroller = TextEditingController();// privado //final: e uma contsante que vai defibir dps

// Dispose é um função que liberar os recrusos de memoeria euqnato os controler não estaõ sendo usado
// Boa pratica para não deixar o APP lento
@override
 void dispose(){
  _controller.dispose();
  _tipocontroller.dispose();
  _macadresscontroller.dispose();
  _latitudecontroller.dispose();
  _longitudecontroller.dispose();
  _responsavelcontroller.dispose();
  _observacaocontroller.dispose();

  super.dispose();
 }

  @override
  Widget build(BuildContext context)  {
    return  MaterialApp(
      debugShowCheckedModeBanner: false, //Desativa a tarja de DEBUG
      home: Scaffold(
        appBar:AppBar(
        title: const Text("App da Turma A", style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255,64,60,134),
      ) ,
      body: Center (
        child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Text(
            texto,
          style: TextStyle(fontSize: 24)
          ),
          SizedBox(height: 20),
          // CRIA UM PADDING POR INPUT
          //Aqui vamos inserir a caixa de texto local de sensor
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),//Espaço
            child:  TextField(
              controller: _controller, // controlador captura o texto
              decoration: InputDecoration(
                labelText: 'Local do Sensor', // Nome do campo de digitação
                border: OutlineInputBorder(),
              ),    
              maxLength: 20,//Limite de caracteres para digitação
              onChanged: (value) {
                  localSensor = value; //Atualiza variavel ao digitar
              },
            ),
          ),
      SizedBox(height: 20),
          //Aqui vamos inserir a caixa de texto  tipo de sensor
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),//Espaço
            child:  TextField(
              controller: _tipocontroller, // controlador captura o texto
              decoration: InputDecoration(
                labelText: 'Tipo do Sensor', // Nome do campo de digitação
                border: OutlineInputBorder(),
              ),    
              maxLength: 20,//Limite de caracteres para digitação
              onChanged: (value) {
                  tipoSensor = value; //Atualiza variavel ao digitar
              },
            ),
          ),
          SizedBox(height: 20),
          //Aqui vamos inserir a caixa de texto  mac adress sensor
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),//Espaço
            child:  TextField(
              controller: _macadresscontroller, // controlador captura o texto
              decoration: InputDecoration(
                labelText: 'Mac Adress', // Nome do campo de digitação
                border: OutlineInputBorder(),
              ),    
              maxLength: 14,//Limite de caracteres para digitação
              onChanged: (value) {
                  macAdress = value; //Atualiza variavel ao digitar
              },
            ),
          ),
          SizedBox(height: 20),
             //Aqui vamos inserir a caixa de texto latitude de sensor
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),//Espaço
            child:  TextField(
              controller: _controller, // controlador captura o texto
              decoration: InputDecoration(
                labelText: 'Latitude do Sensor', // Nome do campo de digitação
                border: OutlineInputBorder(),
              ),    
              maxLength: 20,//Limite de caracteres para digitação
              onChanged: (value) {
                  Latitude = value; //Atualiza variavel ao digitar
              },
            ),
          ),
            SizedBox(height: 20),
              //Aqui vamos inserir a caixa de texto longitude do sensor
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),//Espaço
            child:  TextField(
              controller: _controller, // controlador captura o texto
              decoration: InputDecoration(
                labelText: 'Longitude do Sensor', // Nome do campo de digitação
                border: OutlineInputBorder(),
              ),    
              maxLength: 20,//Limite de caracteres para digitação
              onChanged: (value) {
                  Longitude = value; //Atualiza variavel ao digitar
              },
            ),
          ),
        SizedBox(height: 20),
        //Aqui vamos inserir a caixa de texto  resonsavel sensor
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),//Espaço
            child:  TextField(
              controller: _responsavelcontroller, // controlador captura o texto
              decoration: InputDecoration(
                labelText: 'Responsavel do Sensor', // Nome do campo de digitação
                border: OutlineInputBorder(),
              ),    
              maxLength: 20,//Limite de caracteres para digitação
              onChanged: (value) {
                  Responsavel = value; //Atualiza variavel ao digitar
              },
            ),
          ),
          SizedBox(height: 20),
           //Aqui vamos inserir a caixa de texto  resonsavel sensor
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),//Espaço
            child:  TextField(
              controller: _observacaocontroller, // controlador captura o texto
              decoration: InputDecoration(
                labelText: 'Observacao', // Nome do campo de digitação
                border: OutlineInputBorder(),
              ),    
              maxLength: 20,//Limite de caracteres para digitação
              onChanged: (value) {
                  Observacao= value; //Atualiza variavel ao digitar
              },
            ),
          ),
          // cria um espaçamento entre os inputs
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                texto = localSensor.isNotEmpty
                  ? 'Local do Sensor : $localSensor\n' //Atuliza o texto ap clicar no botao 
                  'Tipo: $tipoSensor\n'
                  'Mac Adress: $macAdress\n'
                  'Latitude: $Latitude\n'
                  'Longitude: $Longitude\n'
                  'Responsavel: $Responsavel\n'
                  'Observacao: $Observacao'
                  : 'Por favor, Insira um local do sensor'; //mensagem se o cmpo estiver vazio 
                  // ? == if e os : == else;
              });
              // LIMPAR TODOS OS INPUT ARRUMARRRRRR
              _controller.clear();
              localSensor = '';
            },//Adicionaremos uma funcao de botao aqui
            style: ElevatedButton.styleFrom(
              minimumSize: Size(200,50),
            ),
            child: Text('Clique aqui'),
             )
        ],
      )
      ),

    //acrescentar o rodape
    bottomNavigationBar: BottomAppBar(
      color: Color.fromARGB(255,64,60,134),//Cor de fundo cinza claro
      child:  Padding(
      padding: const EdgeInsets.all(16.0),
      child:Text(
        'Aqui é o Rodapé',
        textAlign: TextAlign.center,
        

      ),

      ),
    ),
    ),
    );
}
}
