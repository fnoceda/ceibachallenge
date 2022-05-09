import 'package:ceiba_challenge/data/network/failure.dart';
import 'package:ceiba_challenge/domain/models/post_model.dart';
import 'package:ceiba_challenge/domain/models/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserModel>>> getUsers();
  Future<Either<Failure, List<PostModel>>> getPost({required int userId});
}
