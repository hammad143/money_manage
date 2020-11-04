import 'package:bloc/bloc.dart';
import 'package:money_management/viewmodel/bloc/form_submitted_bloc/check_form_submit_event.dart';
import 'package:money_management/viewmodel/bloc/form_submitted_bloc/check_form_submit_state.dart';

class CheckFormSubmitBloc extends Bloc<CheckFormSubmitEvent, CheckFormSubmitState> {
  CheckFormSubmitBloc({CheckFormSubmitState initialState = const CheckFormSubmitState(false)}) : super(initialState);

  @override
  Stream<CheckFormSubmitState> mapEventToState(CheckFormSubmitEvent event) async* {
    yield CheckFormSubmitState(event.isFormSubmit);

  }

}