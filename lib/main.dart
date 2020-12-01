import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_management/model/google_user_model/google_user_model.dart';
import 'package:money_management/model/list_of_tiles_model/list_of_tiles_model.dart';
import 'package:money_management/util/boxes/box.dart';
import 'package:money_management/util/constants/constants.dart';
import 'package:money_management/util/notifier.dart';
import 'package:money_management/view/responsive_setup_view.dart';
import 'package:money_management/view/sync_view.dart';
import 'package:money_management/view/tasks_view/tasks.dart';
import 'package:money_management/viewmodel/bloc/add_amount_info_bloc/add_amount_info_bloc.dart';
import 'package:money_management/viewmodel/bloc/authenticate_user_bloc/auth_bloc.dart';
import 'package:money_management/viewmodel/bloc/authorized_users_bloc/authorized_users_bloc.dart';
import 'package:money_management/viewmodel/bloc/curd_bloc/curd_bloc.dart';
import 'package:money_management/viewmodel/bloc/datetime_pick_bloc/datetime_pick_bloc.dart';
import 'package:money_management/viewmodel/bloc/fetch_added_items_bloc/fetch_added_items_bloc.dart';
import 'package:money_management/viewmodel/bloc/form_submitted_bloc/form_submitted_bloc.dart';
import 'package:money_management/viewmodel/bloc/location_bloc/location_bloc.dart';
import 'package:money_management/viewmodel/bloc/make_authorize_bloc/make_authorize.dart';
import 'package:money_management/viewmodel/bloc/notifier_item_added_bloc/notifier_item_added_bloc.dart';
import 'package:money_management/viewmodel/bloc/on_dropdown_change_bloc/dropdown_select_change_bloc.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ListTilesModelNewAdapter());
  Hive.registerAdapter(GoogleUserModelAdapter());
  await Firebase.initializeApp();
  await Boxes.open(IsUserAuthorizedBox());
  await Boxes.open(SelectedCurrencyBox());
  await Boxes.open(UserAuthorizedKeyBox());
  await Boxes.open(UserDisplayNameBox());
  await Boxes.open(LastAddedItemKeyBox());
  await Boxes.open(StoreGoogleUserModelBox<GoogleUserModelAdapter>());
  await Boxes.open(StoreListTileModelBox<ListOfTilesModel>());
  await Boxes.open(AuthenticateUserBox<bool>());
  await Boxes.open(StoreUserIDBox());
  await Boxes.open(GenerateRandomKeyBox());
  // Notification Init

  await FlutterLocalNotifier.init();
  //Run App
  runApp(MyApp());
}

/*
* http://ip-api.com/json/192.142.202.177
* */

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DateTimePickBloc()),
        BlocProvider(create: (_) => DropDownSelectChangeBloc()),
        BlocProvider(create: (_) => AddAmountInfoBloc()),
        BlocProvider(create: (_) => CheckFormSubmitBloc()),
        BlocProvider(create: (_) => AuthenticateUserBloc()),
        BlocProvider(create: (_) => MakeAuthorizeBloc()),
        BlocProvider(create: (_) => CurdFireBaseBloc()),
        BlocProvider(create: (_) => NotifierItemAddedBloc()),
        BlocProvider(create: (_) => AuthorizedUsersBloc()),
        BlocProvider(create: (_) => FetchAddedAmountBloc()),
        BlocProvider(create: (_) => LocationBloc()),
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

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    final isLoggedIn = AuthenticateUserBox<bool>()
        .getBox()
        .get(AuthenticateUserBox.IS_USER_LOGGED_IN, defaultValue: false);

    return isLoggedIn ? TaskView() : SyncView();
  }
}
