import 'dart:convert';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigap_mobile/common/base/base_controller.dart';
import 'package:sigap_mobile/common/helper/constant.dart';
import 'package:sigap_mobile/src/login/login_response.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<UsernameChanged>((event, emit) {
      emit(state.copyWith(
        username: event.username,
        isValidUsername: _isValidUsername(event.username),
      ));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(
        password: event.password,
        isValidPassword: _isValidPassword(event.password),
      ));
    });

    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(
          isSubmitting: true, isFailure: false, isSuccess: false));

      try {
        final response = await _login(state.username, state.password);
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final loginResponse = LoginResponse.fromJson(data);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(
              Constant.kSetPrefToken, loginResponse.data.token ?? '');
          prefs.setString(Constant.kSetPrefCentraToken,
              loginResponse.data.tokenCentra ?? '');
          prefs.setInt(
              Constant.kSetPrefIspusat, loginResponse.data.isPusat ?? 0);
          prefs.setString(
              Constant.kSetPrefCompany, loginResponse.data.companyName ?? '');
          prefs.setInt(
              Constant.kSetPrefCompanyId, loginResponse.data.companyId ?? 0);
          prefs.setString(
              Constant.kSetPrefCabang, loginResponse.data.cabangName ?? '');
          prefs.setInt(
              Constant.kSetPrefCabangId, loginResponse.data.cabangId ?? 0);
          prefs.setString(
              Constant.kSetPrefName, loginResponse.data.username ?? '');
          prefs.setString(
              Constant.kSetPrefDivision, loginResponse.data.jabatan ?? '');
          emit(state.copyWith(
            isSuccess: true,
            isSubmitting: false,
            isFailure: false,
            loginResponse: loginResponse, // Update state with the response data
          ));
        } else {
          emit(state.copyWith(isFailure: true, isSubmitting: false));
        }
      } catch (_) {
        log("ERROR CATCH $_");
        emit(state.copyWith(isFailure: true, isSubmitting: false));
      }
    });
  }

  bool _isValidUsername(String username) {
    return username.isNotEmpty;
  }

  bool _isValidPassword(String password) {
    return password.length >= 6;
  }

  Future<http.Response> _login(String username, String password) async {
    const url = 'https://sigap-api.erdata.id/Auth/LoginMobile';
    var body = {
      'username': username,
      'password': password,
    };
    Response response = await BaseController().post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    return response;
  }
}
