import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_playground/binding/general_bindings.dart';
import 'package:flutter_firebase_playground/presentation/theme/theme.dart';
import 'package:flutter_firebase_playground/presentation/theme/util.dart';
import 'package:get/get.dart';

import 'data/crypto_api.dart';
import 'domain/repo/crypto_repository.dart';
import 'presentation/ui/crypto_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(CryptoRepository(CryptoApi()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "Space Mono", "Space Mono");

    MaterialTheme theme = MaterialTheme(textTheme);
    return GetMaterialApp(
      title: 'Flutter Firebase Playground',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: const CryptoPage(),
      initialBinding: GeneralBindings(),
    );
  }
}
