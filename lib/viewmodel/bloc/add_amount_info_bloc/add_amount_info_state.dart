import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

class AddAmountInfoState<T> extends Equatable {
  final Box<T> box;

  AddAmountInfoState({this.box});
  @override
  List<Object> get props => [];
}

class AddAmountInfoInitialState<T> extends AddAmountInfoState<T> {
  final Box<T> box;
  AddAmountInfoInitialState({this.box}) : super(box: box);
}

class AddAmountInfoDone<T> extends AddAmountInfoState<T> {
  final Box<T> box;

  AddAmountInfoDone({this.box});
  @override
  List<Object> get props => [box];
}

class AddAmountInfoError extends AddAmountInfoState<int> {
  final String message;

  AddAmountInfoError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
