import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/view/tasks_view/tasks.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_bloc.dart';
import 'package:money_management/viewmodel/bloc/datetime_pick_bloc/datetime_pick_bloc.dart';
import 'package:money_management/viewmodel/bloc/on_dropdown_change_bloc/dropdown_select_change_bloc.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(kHiveBoxOnBoard);
  await Hive.openBox(kHiveDataName);
  await Hive.openBox(kHiveStorage);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _box = Hive.box(kHiveStorage);
  @override
  void initState() {
    super.initState();

    final listOfItems = _box.get("storage");
    if (listOfItems == null) {
      print("Put");
      _box.put("storage", []);
    }
  }

  @override
  void dispose() {
    _box.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DateTimePickBloc(),
        ),
        BlocProvider(
          create: (_) => DropDownSelectChangeBloc(),
        ),
        BlocProvider(
          create: (_) => AddAmountInfoBloc(),
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
    FocusScope.of(context).unfocus();
    print("Main");
    return TaskView();
  }
}
