import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/view/tasks_view/tasks.dart';
import 'package:money_management/viewmodel/bloc/datetime_pick_bloc/datetime_pick_bloc.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(kHiveBoxName);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DateTimePickBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: const TextTheme(
            headline6: const TextStyle(
              color: kPureWhite,
              fontSize: kFontDefaultSize,
            ),
            subtitle1: const TextStyle(
              color: kPureWhite,
              fontSize: kFontDefaultSize / 1.5,
            ),
          ),
        ),
        home: MainScreen(),
      ),
    );
  }
}

//Mason is one of the great man
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Main");
    return TaskView();
  }
}
