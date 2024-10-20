import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/data/source/auth/auth_firebase_service.dart';
import 'package:spotify/domain/repository/auth/auth.dart';
import 'package:spotify/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    return  sl<AuthFirebaseService>().signup(createUserReq);
  }

  @override
  Future<void> signin() {
    throw UnimplementedError();
  }
}
