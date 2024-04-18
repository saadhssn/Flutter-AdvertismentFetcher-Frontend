import 'package:flutter/material.dart';

import 'UserModel.dart';


class userProvider extends ChangeNotifier{
  UserModel? _user;
  UserModel? get user => _user;

void setUser(UserModel user){
  _user = user;
  notifyListeners();
}
}