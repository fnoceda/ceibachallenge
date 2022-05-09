import 'package:ceiba_challenge/data/network/dio_factory.dart';
import 'package:ceiba_challenge/data/network/error_handler.dart';
import 'package:ceiba_challenge/data/network/failure.dart';
import 'package:ceiba_challenge/domain/models/post_model.dart';
import 'package:ceiba_challenge/domain/models/user_model.dart';
import 'package:ceiba_challenge/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserData implements UserRepository {
  final dio = DioFactory();

  @override
  Future<Either<Failure, List<UserModel>>> getUsers() async {
    List<UserModel> _users = await _getLocalUsers();

    if (_users.isEmpty) {
      return await _getRemoteUsers();
    } else {
      return Right(_users);
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>> getPost(
      {required int userId}) async {
    var client = await dio.getDio();
    final url = '/posts?userId=$userId';

    try {
      final response = await client.get(url);

      print(response);

      if (response.statusCode == ResponseCode.SUCCESS) {
        List<PostModel> res = [];

        res.addAll(
            (response.data as List).map((e) => PostModel.fromMap(e)).toList());

        return Right(res);
      } else {
        return Left(
          Failure(
              code: response.statusCode ?? ApiInternalStatus.FAILURE,
              message: response.statusMessage ?? 'Unknown error'),
        );
      }
    } catch (error) {
      print('va al catch');
      print(error);
      return Left(
        Failure(
            code: ApiInternalStatus.FAILURE, message: ResponseMessage.DEFAULT),
      );
    }
  }

  Future<Either<Failure, List<UserModel>>> _getRemoteUsers() async {
    var client = await dio.getDio();
    final url = '/users';

    try {
      final response = await client.get(url);

      if (response.statusCode == ResponseCode.SUCCESS) {
        List<UserModel> res = [];
        res.addAll((response.data as List).map((e) {
          var user = UserModel.fromMap(e);
          _saveUser(user);
          return user;
        }).toList());

        return Right(res);
      } else {
        return Left(
          Failure(
              code: response.statusCode ?? ApiInternalStatus.FAILURE,
              message: response.statusMessage ?? 'Unknown error'),
        );
      }
    } catch (error) {
      return Left(
        Failure(
            code: ApiInternalStatus.FAILURE, message: ResponseMessage.DEFAULT),
      );
    }
  }

  Future<List<UserModel>> _getLocalUsers() async {
    var box = await Hive.box('bosusers');
    var values = box.values;
    List<UserModel> lista = [];

    for (var valor in values) {
      lista.add(valor);
    }

    return lista;
  }

  Future<void> _saveUser(UserModel user) async {
    var box = await Hive.box('bosusers');

    print(user.toMap());

    box.add(user);
  }
}
