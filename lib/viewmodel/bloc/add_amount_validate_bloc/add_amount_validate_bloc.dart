import 'package:bloc/bloc.dart';
import 'package:money_management/viewmodel/bloc/add_amount_validate_bloc/add_amount_validate_event.dart';

import 'add_amount_validate_state.dart';

class AddAmountValidateBloc
    extends Bloc<AddAmountValidateEvent, AddAmountValidateState> {
  AddAmountValidateBloc() : super(null);
  @override
  Stream<AddAmountValidateState> mapEventToState(
      AddAmountValidateEvent event) async* {}
}
