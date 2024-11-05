import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sigap_mobile/common/component/custom_navigator.dart';
import 'package:sigap_mobile/common/helper/constant.dart';
import 'package:sigap_mobile/generated/assets.dart';
import 'package:sigap_mobile/src/home/home_screen.dart';
import 'package:sigap_mobile/src/login/login_bloc.dart';
import 'package:sigap_mobile/src/login/login_event.dart';
import 'package:sigap_mobile/src/login/login_state.dart';
import 'package:sigap_mobile/utils/utils.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Constant.primaryColor,
                Constant.secondaryColor,
              ],
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              // if (state.isFailure) {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     const SnackBar(content: Text('Login Failed')),
              //   );
              // }
              if (state.isFailure)
                Utils.showFailed(msg: "Login failed. Please try again.");
              if (state.isSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Login Successful')),
                );
                CusNav.nPushReplace(context, HomeScreen());
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                // if (state.isSubmitting) return CircularProgressIndicator();
                // if (state.isSuccess && state.loginResponse != null) {
                //   // Access user data
                //   final userData = state.loginResponse!.data;
                //   return Text("Welcome, ${userData.personilName}");
                // }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 100),
                    Center(
                        child:
                            Image.asset(Assets.imagesImgLogoSigap, height: 70)),
                    SizedBox(height: 40),
                    Text(
                      'Username',
                      style: TextStyle(color: Color(0xffE5E5E5), fontSize: 12),
                    ),
                    Constant.xSizedBox12,
                    TextField(
                      cursorColor: Colors.white,
                      onChanged: (value) =>
                          context.read<LoginBloc>().add(UsernameChanged(value)),
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        prefixIcon: Image.asset(Assets.iconsIcUsername),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Color(0xffB9B9B9)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Color(0xffB9B9B9)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        hintStyle: TextStyle(color: Color(0xffB9B9B9)),
                        hintText: 'Username',
                        alignLabelWithHint: false,
                        errorText:
                            state.isValidUsername ? null : 'Invalid Username',
                      ),
                    ),
                    Constant.xSizedBox24,
                    Text(
                      'Password',
                      style: TextStyle(color: Color(0xffE5E5E5), fontSize: 12),
                    ),
                    Constant.xSizedBox12,
                    TextField(
                      cursorColor: Colors.white,
                      obscureText: true,
                      onChanged: (value) =>
                          context.read<LoginBloc>().add(PasswordChanged(value)),
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        prefixIcon: Image.asset(Assets.iconsIcUsername),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Color(0xffB9B9B9)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Color(0xffB9B9B9)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        hintStyle: TextStyle(color: Color(0xffB9B9B9)),
                        hintText: 'Password',
                        alignLabelWithHint: false,
                        errorText:
                            state.isValidPassword ? null : 'Password too short',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () async {},
                        child: Text(
                          'Lupa Password?',
                          style: TextStyle(
                            color: Color(0xff43C6AC),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    InkWell(
                      onTap: state.isSubmitting
                          ? null
                          : () {
                              context.read<LoginBloc>().add(LoginSubmitted());
                            },
                      child: state.isSubmitting
                          ? Center(
                              child: const CircularProgressIndicator(
                                  color: Colors.white))
                          : Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Constant.primaryColor,
                              ),
                              padding: EdgeInsets.all(16),
                              child: Text(
                                'Sign In',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
