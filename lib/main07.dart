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

// Declaração de Variaveis
String texto = "Cnstruindo App da Turma";
// armazena o dado recebido no input
String localSensor = ''; // Armazena o texto do sensor
// delcraração de uma variavel com uma classe que gerencia o comptamento do input
// serve para ler dados, colooar dados na caixa de texto
final TextEditingController _controller = TextEditingController();// privado //final: e uma contsante que vai defibir dps
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
          //  Caixa DE TEXTO
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0), // horizontal = pading //Espaço
            child:  TextField(
              // indica a variavel que controla o input 
              // *o underline indica que é uma variavel privada so é usada dentro dessa classe Projetoo01
              controller: _controller, // controlador captura o texto
              decoration: InputDecoration(
                labelText: 'Local do Sensor', // Nome do campo de digitação
                border: OutlineInputBorder(),
              ),    
              maxLength: 20,//Limite de caracteres para digitação
              // evento que oorre no input toda vez que sofrer modificar (digitar ou apagar)
              onChanged: (value) {
                  // atualiza a variavel com o valor
                  localSensor = value; //Atualiza variavel ao digitar
              },
            ),
          ),
          // Botão
          ElevatedButton(
            onPressed: () {
              setState(() {
                // atualiza a mensagem com a informação do input
                // isNotempty = verifica senão ta vazio
                texto = localSensor.isNotEmpty
                  ? 'Local do Sensor : $localSensor ' //Atuliza o texto ap clicar no botao 
                  : 'Por favor, Insira um local do sensor'; //mensagem se o cmpo estiver vazio 
                  // ? == if e os : == else;
              });
              // limpa a caixa após o dado ser enviado sem precisar regarregar a pagina
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
