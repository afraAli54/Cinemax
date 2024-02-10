import 'dart:convert';

import 'package:cinemax/bloc/login_bloc/auth_event.dart';
import 'package:cinemax/bloc/login_bloc/auth_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          UserCredential user =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );

          final responseToken = await http.get(
            Uri.parse(
              'https://api.themoviedb.org/3/authentication/token/new',
            ),
            headers: {
              'Authorization':
                  'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0NWExZWU5YzVhNTIzOTY2NjlkY2VkMzZiMjlhNmQ2MSIsInN1YiI6IjY1YzMzMDVhOTVhY2YwMDE2MjFjMTkyOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.HZuafUc_RInT-PAK9Qx4FqcEZcLaJ0kwVc-9Y5IXTOg',
              'Accept': 'application/json',
            },
          );

          if (responseToken.statusCode == 200) {
            final dataToken = json.decode(responseToken.body);
            final requestToken = dataToken['request_token'];

            final responseSession = await http.post(
              Uri.parse(
                'https://api.themoviedb.org/3/authentication/session/new',
              ),
              headers: {
                'Authorization': 'Bearer 45a1ee9c5a52396669dced36b29a6d61',
                'Accept': 'application/json',
                'Content-Type': 'application/json',
              },
              body: json.encode({
                'request_token': requestToken,
              }),
            );

            if (responseSession.statusCode == 200) {
              final dataSession = json.decode(responseSession.body);
              final sessionId = dataSession['session_id'];
              emit(LoginSuccess(sessionId: sessionId));
            } else {
              emit(LoginFailure(errorMessege: 'Login failed.'));
            }
          } else {
            emit(LoginFailure(errorMessege: 'Login failed.'));
          }
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'user-not-found') {
            emit(LoginFailure(errorMessege: 'User not found'));
          } else if (ex.code == 'wrong-password') {
            emit(LoginFailure(errorMessege: 'Wrong password'));
          } else {
            emit(LoginFailure(errorMessege: 'Something went wrong'));
          }
        } catch (e) {
          emit(LoginFailure(errorMessege: 'Something went wrong'));
        }
      } else if (event is SignUpEvent) {
        emit(SignUpLoading());
        try {
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );

          Map<String, dynamic> data = {
            'name': event.userName,
            'email': event.email,
          };
          User? user = userCredential.user;
          if (user != null) {
            String userId = user.uid;
            await FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .set(data);
          } else {}

          emit(SignUpSuccess());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'weak-password') {
            emit(SignUpFailure('Weak password'));
          } else if (ex.code == 'email-already-in-use') {
            emit(SignUpFailure('Email already in use'));
          }
        } catch (e) {
          emit(SignUpFailure('Something went wrong'));
        }
      }
    });
  }
}
