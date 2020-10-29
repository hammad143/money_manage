import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:money_management/util/constants/constants.dart';

class AddAmountInfoState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AddAmountInfoInitialState extends AddAmountInfoState {
  final box = Hive.box(kHiveDataName);
}

class AddAmountInfoDone extends AddAmountInfoState {
  final hiveBox;

  AddAmountInfoDone({this.hiveBox});
}
