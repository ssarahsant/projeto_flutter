import 'package:flutter/material.dart';
//import 'main_01_segunda_tela_v5.dart'; // Tela de consulta ao BD
import 'main_16_segunda_tela.dart'; // Tela de consulta ao BD
import 'main_19_SelecionarLocalidade.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projeto Smart City',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TelaPrincipal(),
    );
  }
}

class TelaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1.0, // Proporção 1:1 para deixar quadrado
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Segunda_Tela_App()),
                    );
                  },
                  child: FrameButton(
                    title: 'Cadastrar/Editar Sensores',
                    subtitle: '',
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelecionarLocalidade()),
                    );
                  },
                  child: FrameButton(
                    title: 'Consultar Dados Sensores',
                    subtitle: 'Escolha uma localidade para exibir dados',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FrameButton extends StatelessWidget {
  final String title;
  final String subtitle;

  const FrameButton({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[700]!),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          if (subtitle.isNotEmpty) ...[
            SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ],
      ),
    );
  }
}
