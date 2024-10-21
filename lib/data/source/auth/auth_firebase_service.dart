import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/data/models/auth/sigin_user_req.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserReq createUserReq);

  Future<Either> signin(SigninUserReq signinUserReq);
}

class AuthFirebaseServiceImpl implements AuthFirebaseService {
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signinUserReq.email, password: signinUserReq.password);
      return const Right("Sigin successful");
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (signinUserReq.email.isEmpty || signinUserReq.password.isEmpty) {
        message = 'Please fill all fields';
        return Left(message);
      }
      if (e.code == 'user-not-found' || e.code == 'invalid-email') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        message = 'Wrong password provided for that user.';
      } else {
        message = 'An error occured';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createUserReq.email, password: createUserReq.password);
      return const Right("Signup successful");
    } on FirebaseAuthException catch (e) {
      String message = "";

      if (createUserReq.email.isEmpty ||
          createUserReq.password.isEmpty ||
          createUserReq.fullName.isEmpty) {
        message = 'Please fill all fields';
        return Left(message);
      }
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else {
        message = 'An error occured';
      }

      return Left(message);
    }
  }
}
