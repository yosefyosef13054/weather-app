import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:requests_inspector/requests_inspector.dart';
import 'package:weatherforecast/controllers/weather_controller.dart';
import 'package:weatherforecast/locetor.dart';
import 'package:weatherforecast/screens/waether_screen.dart';

void main() {
  // setup();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => WheatherController()),
  ], child: const RequestsInspector(enabled: true, child: MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  WheatherController? provider;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider = Provider.of<WheatherController>(context, listen: false);
      provider!.initAppFunctions();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
