import 'package:blogapp/core/common/entities/user.dart';
import 'package:blogapp/core/usecase/usecase.dart';
import 'package:blogapp/features/auth/domain/usecase/current_user.dart';
import 'package:blogapp/features/auth/domain/usecase/user_login.dart';
import 'package:blogapp/features/auth/domain/usecase/user_logout.dart';
import 'package:blogapp/features/auth/domain/usecase/user_sign_up.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final UserLogout _userLogout;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required UserLogout userLogout,
  }) : _userSignUp = userSignUp,
       _userLogin = userLogin,
       _currentUser = currentUser,
       _userLogout = userLogout,
       super(AuthEventInitial()) {
    // Registramos el handler para el evento AuthSignUp
    on<AuthEvent>(
      (event, emit) => emit(AuthLoading()),
    ); //- Optimización: Loading para cualquier evento
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_onAuthIsUserLoggedIn);
    on<AuthLogout>(_onAuthLogout);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );

    res.fold(
      (failure) => emit(AuthFailure(failure.message)), // Si es Left (Error)
      (uid) => emit(AuthSuccess(uid)), // Si es Right (Éxito)
    );
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    print('--- INTENTANDO LOGIN ---'); // Chivato 1
    final res = await _userLogin(
      UserLoginParams(email: event.email, password: event.password),
    );
    res.fold(
      (l) {
        print('--- ERROR EN LOGIN: ${l.message} ---'); // Chivato 2
        emit(AuthFailure(l.message));
      },
      (r) {
        print('--- LOGIN EXITOSO: ${r.id} ---'); // Chivato 3
        emit(AuthSuccess(r));
      },
    );
  }

  void _onAuthIsUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => emit(AuthSuccess(r)), // Ahora r es un User
    );
  }

  void _onAuthLogout(AuthLogout event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final res = await _userLogout(NoParams());

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (_) => emit(AuthEventInitial()),
    );
  }
}
