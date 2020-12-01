import 'package:google_sign_in/google_sign_in.dart';
import 'package:money_management/model/user_adding_model/user_adding_model.dart';

class GoogleUserAddingModel extends UserAddingModel {
  String id, email, name, photoUrl, auto_inc_id;
  GoogleSignInAccount googleUser;
  //Map<String, dynamic > _mapped;
  //GoogleUserAddingModel();

  GoogleUserAddingModel._(Map<String, dynamic> json) {
    this.id = json['id'];
    this.email = json['email'];
    this.name = json['name'];
    this.photoUrl = json['photoUrl'];
    this.auto_inc_id = json['auto_inc_id'];
  }

  factory GoogleUserAddingModel.toJSON(Map<String, dynamic> json) {
    return GoogleUserAddingModel._(json);
  }

  GoogleUserAddingModel.toMap(this.googleUser) {
    mapped = _toMap(this.googleUser);
  }

  Map<String, dynamic> _toMap(GoogleSignInAccount user) {
    return <String, dynamic>{
      "id": user.id,
      "email": user.email,
      "name": user.displayName,
      "photoUrl": user.photoUrl,
      "auto_inc_id": auto_inc_id,
    };
  }
}
