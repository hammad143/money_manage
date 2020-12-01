import 'package:google_sign_in/google_sign_in.dart';
import 'package:money_management/model/user_adding_model/user_adding_model.dart';

class GoogleUserAddingModel implements UserAddingModel {
  String _userID, email, _name, photoUrl, auto_inc_id, _uniqueKey;
  GoogleSignInAccount _googleUser;

  //Unique Key Setter
  @override
  void set uniqueKey(String _uniqueKey) {
    this._uniqueKey = _uniqueKey;
    print("Setter Called ${_uniqueKey}");
  }

  //UserID Key Setter
  @override
  void set userID(String _userID) {
    this._userID = _userID;
  }

  //DisplayName Key Setter
  @override
  void set name(String _displayName) {
    this._name = _displayName;
  }

  @override
  String get uniqueKey => this._uniqueKey;
  @override
  String get name => this._name;
  @override
  String get userID => _userID;

  @override
  Map<String, dynamic> mapped;

  GoogleUserAddingModel._(Map<String, dynamic> json) {
    this.userID = json['id'];
    this.email = json['email'];
    this.name = json['name'];
    this.photoUrl = json['photoUrl'];
    this.auto_inc_id = json['auto_inc_id'];
    this.uniqueKey = json['uniqueKey'];
    mapped = json;
  }

  factory GoogleUserAddingModel.toJSON(Map<String, dynamic> json) {
    return GoogleUserAddingModel._(json);
  }

  GoogleUserAddingModel.toMap(GoogleSignInAccount googleUser) {
    mapped = _toMap(googleUser);
  }

  Map<String, dynamic> _toMap(GoogleSignInAccount user) {
    return <String, dynamic>{
      "id": user.id,
      "email": user.email,
      "name": user.displayName,
      "photoUrl": user.photoUrl,
      "auto_inc_id": auto_inc_id,
      "uniqueKey": this.uniqueKey,
    };
  }
}
