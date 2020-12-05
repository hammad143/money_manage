import 'package:money_management/model/user_adding_model/model.dart';
import 'package:uuid/uuid.dart';

abstract class DocAddingDecorator implements Model {
  final Model _model;

  DocAddingDecorator(Model model) : this._model = model;

  @override
  Map<String, dynamic> toMap() {
    return _model.toMap();
  }
}

class UserMapUpdateDecorator extends DocAddingDecorator {
  @override
  final Model _model;
  final int totalDocs;

  UserMapUpdateDecorator(Model model, this.totalDocs)
      : this._model = model,
        super(model);

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();

    map.addAll({"uniqueKey": Uuid().v4(), "auto_inc_id": totalDocs});
    return map;
  }

  @override
  T toJson<T extends Model>(Map<String, dynamic> map) {}

/*  @override
  String name;

  @override
  String uniqueKey;

  @override
  String userID;*/
}

class ItemAddingDecorator extends DocAddingDecorator {
  final int _totalDocs;
  ItemAddingDecorator(Model model, int totalDocs)
      : this._totalDocs = totalDocs,
        super(model);

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll({"auto_inc_item": _totalDocs});
    return map;
  }

  @override
  T toJson<T extends Model>(Map<String, dynamic> map) {}
}
