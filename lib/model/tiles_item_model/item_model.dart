import 'package:money_management/model/user_adding_model/model.dart';

class ItemsAddingModel extends Model {
  String _title, _amount, _date, _option, _currency;

  ItemsAddingModel(String title, amount, date, option, currency)
      : this._title = title,
        this._amount = amount,
        this._date = date,
        this._option = option,
        this._currency = currency;

  @override
  T toJson<T extends Model>(Map<String, dynamic> map) {
    this._title = map['title'];
    this._amount = map['amount'];
    this._option = map['option'];
    this._date = map['date'];
    this._currency = map['currency'];
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
    };
  }
}
