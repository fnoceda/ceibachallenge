import 'package:ceiba_challenge/data/network/failure.dart';
import 'package:ceiba_challenge/domain/models/post_model.dart';
import 'package:ceiba_challenge/domain/models/user_model.dart';
import 'package:ceiba_challenge/domain/repository/repository.dart';
import 'package:flutter/cupertino.dart';

class UserService with ChangeNotifier {
  final UserRepository _userRepository;

  UserService(this._userRepository) {
    getUsers();
  }

  List<UserModel> _users = [];
  List<UserModel> get users => _users;

  List<UserModel> _usersFiltered = [];
  List<UserModel> get usersFiltered => _usersFiltered;

  bool isLoadingUsers = true;

  late Failure _failure;

  Future<void> getUsers() async {
    var result = await _userRepository.getUsers();

    result.fold((l) {
      _failure = l;
      print('ocurrio algun error');
    }, (r) {
      _users = r;
      print('todo bien maestro');
      print(_users.length);
    });

    isLoadingUsers = false;
    notifyListeners();
  }

  Future<List<PostModel>> getPosts({required int userId}) async {
    List<PostModel> lista = [];

    if (userId > 0) {
      var result = await _userRepository.getPost(userId: userId);
      result.fold((l) {
        _failure = l;
        print('ocurrio algun error');
      }, (r) {
        lista = r;
        print('todo bien maestro');
        print(_users.length);
      });
    }

    return lista;
  }

  void findUsers({required String str}) {
    print('findUsers => $str');
    _usersFiltered.clear();
    if (str.trim().isNotEmpty) {
      for (var user in _users) {
        if (user.name!.toLowerCase().contains(str.toLowerCase())) {
          _usersFiltered.add(user);
        }
      }
    }
    print(_usersFiltered.length);
    notifyListeners();
  }
}
