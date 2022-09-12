import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/cupertino.dart';
import 'features/feature/core/root.dart';
import 'service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  runApp(const Root());
}
