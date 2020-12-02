import 'package:money_management/model/user_adding_model/user_adding_model.dart';
import 'package:uuid/uuid.dart';

abstract class UserAddingDecorator implements UserAddingModel {
  final UserAddingModel _addingModel;

  UserAddingDecorator(UserAddingModel addingModel)
      : this._addingModel = addingModel;

  @override
  Map<String, dynamic> toMap();
}

class UserMapUpdateDecorator implements UserAddingDecorator {
  @override
  final UserAddingModel _addingModel;
  final int totalDocs;

  UserMapUpdateDecorator(UserAddingModel addingModel, this.totalDocs)
      : this._addingModel = addingModel;

  @override
  Map<String, dynamic> toMap() {
    final map = _addingModel.toMap();
    map.addAll({"uniqueKey": Uuid().v4(), "auto_inc_id": totalDocs});
    return map;
  }

  @override
  String name;

  @override
  String uniqueKey;

  @override
  String userID;
}
