import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

class AddAmountInfoState extends Equatable {
  final Box box;

  AddAmountInfoState({this.box});
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AddAmountInfoInitialState extends AddAmountInfoState {
  final Box box;
  AddAmountInfoInitialState({this.box}) : super(box: box);
}

class AddAmountInfoDone extends AddAmountInfoState {
  final Box<dynamic> box;

  AddAmountInfoDone({this.box});
  @override
  // TODO: implement props
  List<Object> get props => [box];
}
