import 'package:bloc/bloc.dart';
import 'package:money_management/viewmodel/bloc/datetime_pick_bloc/datetime_pick_event.dart';
import 'package:money_management/viewmodel/bloc/datetime_pick_bloc/datetime_pick_state.dart';

class DateTimePickBloc extends Bloc<DateTimePickEvent, DateTimePickState> {
  DateTimePickBloc() : super(DateTimePickInitialState());

  @override
  Stream<DateTimePickState> mapEventToState(DateTimePickEvent event) async* {
    if (event is DateTimePickEvent) yield DateTimePickedState(event.dateTime);
  }
}
