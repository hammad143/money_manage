import 'package:bloc/bloc.dart';
import 'package:money_management/viewmodel/bloc/curd_bloc/curd_bloc.dart';

class CurdFireBaseBloc extends Bloc<CurdFireBaseEvent, CurdFireBaseState> {
  CurdFireBaseBloc() : super(CurdFireBaseInitState());

  @override
  Stream<CurdFireBaseState> mapEventToState(CurdFireBaseEvent event) async* {}
}
