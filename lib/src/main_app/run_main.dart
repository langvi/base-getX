import 'dart:async';

import 'package:base_getx/src/exceptions/handle_exception.dart';
import 'package:flutter/material.dart';

void runMainApp({required Widget myApp}) {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(myApp);
  }, (error, stackTrace) {
    print(error);
    HandleExceptionApp.instance.handleExceptionAsync(error, stackTrace);
  });
}
