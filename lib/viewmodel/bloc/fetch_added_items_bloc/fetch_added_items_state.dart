import 'package:equatable/equatable.dart';
import 'package:money_management/model/list_of_tiles_model/list_of_tiles_model.dart';

class FetchAddedItemsState extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchAddedItemInitState extends FetchAddedItemsState {
  final Future<List<ListOfTilesModel>> data;

  FetchAddedItemInitState(this.data);
}

class FetchAddedItemSuccessState extends FetchAddedItemsState {
  final Future<List<ListOfTilesModel>> data;

  FetchAddedItemSuccessState(this.data);
  @override
  // TODO: implement props
  List<Object> get props => [data];
}
