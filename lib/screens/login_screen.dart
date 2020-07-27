import 'package:chat_app/bloc/login/login_bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:chat_app/extensions.dart';

class LoginScreen extends HookWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.teal, Colors.white],
                begin: Alignment.topRight,
                end: Alignment.centerLeft,
                tileMode: TileMode.repeated,
                stops: [0.0, 0.70])),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter email';
                    } else if (!value.isValidEmail) {
                      return 'Enter valid email';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  controller: passwordController,
                  validator: (value) => value.isEmpty ? 'Enter password' : null,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                SizedBox(
                  height: 10,
                ),
                BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      _formKey.currentState.reset();
                      emailController.clear();
                      passwordController.clear();
                      Navigator.of(context).pushReplacementNamed(homeRoute);
                    }
                  },
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return RaisedButton(
                        child: state is LoginLoading
                            ? CircularProgressIndicator()
                            : Text('Login'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: state is LoginLoading
                            ? null
                            : () {
                                if (_formKey.currentState.validate()) {
                                  BlocProvider.of<LoginBloc>(context).add(
                                      LoginButtonPressed(emailController.text,
                                          passwordController.text));
                                }
                              },
                      );
                    },
                  ),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () => BlocProvider.of<LoginBloc>(context)
                      .add(LoginWithGoogle()),
                  child: Text('SignIn with Google'),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed(registerRoute),
                      child: Text(
                        'Create an account?',
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
