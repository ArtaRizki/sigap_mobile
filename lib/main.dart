import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sigap_mobile/common/helper/constant.dart';
import 'package:sigap_mobile/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:sigap_mobile/splash_screen.dart';
import 'package:sigap_mobile/src/home/home_screen.dart';
import 'package:sigap_mobile/src/login/login_screen.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: Constant.primaryColor, // status bar color
    systemNavigationBarIconBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
  ));
  await WidgetsFlutterBinding.ensureInitialized();

  await requestPermission(Permission.storage);
  await requestPermission(Permission.accessMediaLocation);
  await requestPermission(Permission.manageExternalStorage);
  await requestPermission(Permission.photos);
  runApp(const MyApp());
}

Map<String, WidgetBuilder> get _routes => <String, WidgetBuilder>{
      '/': (context) => SplashScreen(),
      '/login': (context) => LoginScreen(),
      '/home': (context) => HomeScreen(),
    };

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

Future<bool> requestPermission(Permission permission) async {
  PermissionStatus status = await permission.request();
  return [PermissionStatus.granted, PermissionStatus.limited].contains(status);
}

Future<PermissionStatus> getCameraPermission() async {
  var status = await Permission.camera.status;
  var status2 = await Permission.microphone.status;
  if (!status.isGranted) {
    final result = await Permission.camera.request();
    final result2 = await Permission.microphone.request();
    return result2;
  } else {
    return status2;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      restorationScopeId: 'root',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: NavigationService.navigatorKey,
      initialRoute: '/',
      routes: _routes,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        child = EasyLoading.init()(
            context, child); // assuming this is returning a widget
        log(MediaQuery.of(context).size.toString());
        return MediaQuery(
          child: child,
          data: MediaQuery.of(context)
              .copyWith(textScaler: TextScaler.linear(1.0)),
        );
      },
    );
  }
}
