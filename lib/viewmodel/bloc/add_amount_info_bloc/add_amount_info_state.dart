import 'package:equatable/equatable.dart';
import 'package:money_management/model/tiles_item_model/item_model.dart';

class AddAmountInfoState extends Equatable {
  AddAmountInfoState();
  @override
  List<Object> get props => [];
}

class AddAmountInfoInitialState extends AddAmountInfoState {}

class AddAmountInfoDone<T> extends AddAmountInfoState {
  final ItemsAddingModel model;

  AddAmountInfoDone(this.model);
  @override
  List<Object> get props => [model];
}

class AddAmountInfoError extends AddAmountInfoState {
  final String message;

  AddAmountInfoError(this.message);

  @override
  List<Object> get props => [message];
}
