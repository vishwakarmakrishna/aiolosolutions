import 'package:aiolosolutions/blocs/api_response.dart';
import 'package:aiolosolutions/blocs/auth_bloc.dart';
import 'package:aiolosolutions/models/auth_user.dart';
import 'package:aiolosolutions/view/all_states.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late AuthBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = AuthBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<AuthResponse<AuthUser?>>(
        stream: _bloc.authStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data?.status) {
              case AuthStatus.loding:
                return Loading(loadingMessage: snapshot.data?.message);
              case null:
                return LoginPage(
                  bloc: _bloc,
                  email: snapshot.data?.email,
                  password: snapshot.data?.password,
                );
              case AuthStatus.initial:
                return LoginPage(
                  bloc: _bloc,
                  email: snapshot.data?.email,
                  password: snapshot.data?.password,
                );

              case AuthStatus.unauthenticated:
                return LoginPage(
                  bloc: _bloc,
                  email: snapshot.data?.email,
                  password: snapshot.data?.password,
                );
              case AuthStatus.authenticated:
                return LoggedInUser(
                  user: snapshot.data?.data,
                );

              case AuthStatus.error:
                return Error(
                  errorMessage: snapshot.data?.message,
                  onRetryPressed: () => _bloc.initial(),
                );
            }
          }
          return Container();
        },
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class LoggedInUser extends StatelessWidget {
  const LoggedInUser({super.key, this.user});
  final AuthUser? user;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Logged In User'),
          const SizedBox(
            height: 20,
          ),
          Text(
              'Welcome ${user?.data.user.firstName} ${user?.data.user.lastName}'),
          const SizedBox(
            height: 20,
          ),
          Text('Email: ${user?.data.user.email}'),
          const SizedBox(
            height: 20,
          ),
          Text('City: ${user?.data.user.city}'),
          const SizedBox(
            height: 20,
          ),
          // Logout Button
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const AuthScreen(),
                ),
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

// Login Page with email and password

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.bloc, this.email, this.password});
  final AuthBloc bloc;
  final String? email;
  final String? password;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailField;
  late TextEditingController _passwordField;

  @override
  void initState() {
    super.initState();
    _emailField = TextEditingController(text: widget.email);
    _passwordField = TextEditingController(text: widget.password);
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          const Positioned(
            left: -20,
            top: -100,
            child: CircleCorlor(
              color: Color(0xff2e3192),
            ),
          ),
          const Positioned(
            left: -100,
            top: -20,
            child: CircleCorlor(
              color: Color(0xff2e3192),
            ),
          ),
          const Positioned(
            bottom: -20,
            right: -130,
            child: CircleCorlor(
              color: Color(0xff014a7f),
            ),
          ),
          const Positioned(
            bottom: -130,
            right: -20,
            child: CircleCorlor(
              color: Color(0xff014a7f),
            ),
          ),
          Positioned.fill(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _emailField,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person_outline,
                                    color: Colors.black,
                                  ),
                                  hintText: 'Username',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const Divider(
                              color: Colors.grey,
                              height: 1,
                              thickness: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _passwordField,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock_outline_rounded,
                                    color: Colors.black,
                                  ),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 75,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Color(0xff02c1f6),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                widget.bloc.login(
                                  email: _emailField.text,
                                  password: _passwordField.text,
                                );
                              }
                            },
                            icon: const Icon(
                              Icons.trending_flat_sharp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 75.0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey,
                        ),
                        onPressed: () {},
                        child: const Text('Forgot Password?'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        surfaceTintColor: Colors.white,
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.only(
                          right: 10.0,
                        ),
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircleCorlor extends StatelessWidget {
  const CircleCorlor({
    Key? key,
    required this.color,
  }) : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
