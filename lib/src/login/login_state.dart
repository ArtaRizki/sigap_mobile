import 'package:equatable/equatable.dart';
import 'package:sigap_mobile/src/login/login_response.dart';

class LoginState extends Equatable {
  final String username;
  final String password;
  final bool isValidUsername;
  final bool isValidPassword;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final LoginResponse? loginResponse;

  const LoginState({
    required this.username,
    required this.password,
    required this.isValidUsername,
    required this.isValidPassword,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    this.loginResponse,
  });

  factory LoginState.initial() {
    return const LoginState(
      username: '',
      password: '',
      isValidUsername: true,
      isValidPassword: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      loginResponse: null,
    );
  }

  LoginState copyWith({
    String? username,
    String? password,
    bool? isValidUsername,
    bool? isValidPassword,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    LoginResponse? loginResponse,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      isValidUsername: isValidUsername ?? this.isValidUsername,
      isValidPassword: isValidPassword ?? this.isValidPassword,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      loginResponse: loginResponse ?? this.loginResponse,
    );
  }

  @override
  List<Object?> get props => [
        username,
        password,
        isValidUsername,
        isValidPassword,
        isSubmitting,
        isSuccess,
        isFailure,
        loginResponse,
      ];
}
