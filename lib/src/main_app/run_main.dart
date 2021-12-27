import 'dart:async';

import 'package:flutter/material.dart';

void runMainApp({required Widget myApp}) {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(myApp);
  }, (error, stackTrace) {
    print(error);
  });
}
