import 'package:hive/hive.dart';
import 'package:money_management/model/user_adding_model/model.dart';

part 'item_model.g.dart';
//part 'google_user_model.g.dart';

@HiveType(typeId: 4, adapterName: "ItemAddingModelAdapter")
class ItemsAddingModel extends Model {
  @HiveField(0)
  String _title;
  @HiveField(1)
  String _amount;
  @HiveField(2)
  String _date;
  @HiveField(3)
  String _option;
  @HiveField(4)
  String _currency;
  @HiveField(5)
  double _lat;
  @HiveField(6)
  double _long;

  ItemsAddingModel(
      [String title, amount, date, option, currency, double lat, long])
      : this._title = title,
        this._amount = amount,
        this._date = date,
        this._option = option,
        this._currency = currency,
        this._lat = lat,
        this._long = long;
  ItemsAddingModel.toJSON(Map<String, dynamic> map) {
    toJson(map);
  }
  @override
  T toJson<T extends Model>(Map<String, dynamic> map) {
    this._title = map['title'];
    this._amount = map['amount'];
    this._option = map['option'];
    this._date = map['date'];
    this._currency = map['currency'];
    this._lat = map['lat'];
    this._long = map['long'];
    return this as Model;
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': this._title,
      'amount': this._amount,
      'date': this._date,
      'option': this._option,
      'currency': this._currency,
      "lat": this._lat,
      "long": this._long,
    };
  }

  String get title => this._title;
  String get currency => this._currency;
  String get option => this._option;
  String get amount => this._amount;
  String get date => this._date;
}
