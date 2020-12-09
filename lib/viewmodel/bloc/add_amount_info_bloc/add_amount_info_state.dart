import 'package:equatable/equatable.dart';
import 'package:money_management/model/tiles_item_model/item_model.dart';

class AddAmountInfoState extends Equatable {
  final List<ItemsAddingModel> model;
  AddAmountInfoState([this.model = const []]);
  @override
  List<Object> get props => [];
}

class AddAmountInfoInitialState extends AddAmountInfoState {
  final List<ItemsAddingModel> model;

  AddAmountInfoInitialState([this.model = const []]);
  @override
  // TODO: implement props
  List<Object> get props => [model];
}

class AddAmountInfoDone<T> extends AddAmountInfoState {
  final List<ItemsAddingModel> model;

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
