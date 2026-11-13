import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_widget/home_widget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Future<void> atualizarWidgetExterno(BuildContext context) async {
    const String androidWidgetName =
        'com.example.flutter_home_widget.MeuHomeWidget';

    try {
      await HomeWidget.saveWidgetData<String>('chave_texto', 'Ideia');

      await HomeWidget.updateWidget(qualifiedAndroidName: androidWidgetName);
      await HomeWidget.requestPinWidget(
        qualifiedAndroidName: androidWidgetName,
      );
    } on PlatformException catch (exception) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Não foi possível criar o widget: ${exception.message ?? exception.code}',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter Home Widget')),
        body: Builder(
          builder: (scaffoldContext) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                const Image(image: AssetImage('assets/icone.png')),
                ElevatedButton(
                  onPressed: () => atualizarWidgetExterno(scaffoldContext),
                  child: const Text('Criar o Widget'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
