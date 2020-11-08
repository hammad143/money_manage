import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/model/google_user_model/google_user_model.dart';
import 'package:money_management/model/list_of_tiles_model/list_of_tiles_model.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/util/unique_key.dart';
import 'package:money_management/view/responsive_setup_view.dart';
import 'package:money_management/view/sync_view.dart';
import 'package:money_management/view/tasks_view/tasks.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_bloc.dart';
import 'package:money_management/viewmodel/bloc/authenticate_user_bloc/auth_bloc.dart';
import 'package:money_management/viewmodel/bloc/datetime_pick_bloc/datetime_pick_bloc.dart';
import 'package:money_management/viewmodel/bloc/form_submitted_bloc/form_submitted_bloc.dart';
import 'package:money_management/viewmodel/bloc/on_dropdown_change_bloc/dropdown_select_change_bloc.dart';
import 'package:uuid/uuid.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ListTilesModelNewAdapter());
  Hive.registerAdapter(GoogleUserModelAdapter());
  await Hive.openBox(kHiveBoxOnBoard);
  await Hive.openBox(kHiveDataName);
  await Hive.openBox(kgenerateKey);
  await Hive.openBox<ListOfTilesModel>(storageKey);
  await Hive.openBox<int>(counterKey);
  await Hive.openBox<int>(kGooglerUserCounterKey);
  await Hive.openBox<bool>(kGoogleAuthKey);
  await Hive.openBox<GoogleUserModelAdapter>(kGoogleUserKey);
  final String id = Uuid().v1();
  StoreUniqueKey.set(id);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DateTimePickBloc()),
        BlocProvider(create: (_) => DropDownSelectChangeBloc()),
        BlocProvider(create: (_) => AddAmountInfoBloc()),
        BlocProvider(create: (_) => CheckFormSubmitBloc()),
        BlocProvider(create: (_) => AuthenticateUserBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  AuthenticateUserBloc _authUserbloc;
  final authGoogleUserBox = Hive.box<bool>(kGoogleAuthKey);
  @override
  void initState() {
    super.initState();
    _authUserbloc = BlocProvider.of<AuthenticateUserBloc>(context);
    //_authUserbloc.add(AuthenticateUserRequestEvent(GoogleSignIn()));
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    if (authGoogleUserBox.get("isLoggedIn") != null) {
      return TaskView();
    } else {
      return SyncView();
    }
  }
}
