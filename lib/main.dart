import 'package:flutter/material.dart';
import 'package:movies_app/src/app_root.dart';
import 'package:hive_flutter/hive_flutter.dart';


    void main() async{
      WidgetsFlutterBinding.ensureInitialized();
      await Hive.initFlutter();
      await Hive.openBox('MyData');
      runApp (AppRoot());
    }
