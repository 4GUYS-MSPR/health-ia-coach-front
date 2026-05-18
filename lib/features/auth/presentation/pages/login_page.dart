import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:health_ia_care/features/auth/presentation/bloc/auth_bloc.dart';
import '../widgets/authentication_text_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final structureCodeController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  bool register = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    structureCodeController.dispose();
    passwordConfirmationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if ((state is AuthLoginSuccess && state.isLogged) || state is AuthSuccess) {
            context.replace('/home');
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          switch (state) {
            case AuthFailure _:
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        spacing: 16,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/logo.png',
                            width: 200.0,
                          ),
                          AuthenticationTextFormField(
                            icon: Icons.person_outline_sharp,
                            label: "Nom de compte",
                            textEditingController: usernameController,
                            isPassword: false,
                          ),
                          if (register == true)
                            AuthenticationTextFormField(
                              icon: Icons.numbers,
                              label: 'Code structure',
                              textEditingController: structureCodeController,
                              isPassword: false,
                            ),
                          AuthenticationTextFormField(
                            icon: Icons.vpn_key,
                            label: "Mot de passe",
                            textEditingController: passwordController,
                            isPassword: true,
                          ),
                          if (register == true)
                            AuthenticationTextFormField(
                              icon: Icons.password,
                              label: 'Confirmer le mot de passe',
                              textEditingController: passwordConfirmationController,
                              isPassword: true,
                            ),
                          FilledButton(
                            onPressed: () {
                              if (register == true) {
                                final username = usernameController.text.trim();
                                final password = passwordController.text.trim();
                                final structureCode = structureCodeController.text.trim();
                                context.read<AuthBloc>().add(
                                  AuthRegisterRequestEvent(
                                    username: username,
                                    password: password,
                                    structureCode: structureCode,
                                  ),
                                );
                              } else {
                                final username = usernameController.text.trim();
                                final password = passwordController.text.trim();
                                context.read<AuthBloc>().add(
                                  AuthLoginRequestEvent(
                                    username: username,
                                    password: password,
                                  ),
                                );
                              }
                            },
                            child: Text(register == true ? 'Créer un compte' : 'Connexion'),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() => register = !register);
                              _formkey.currentState?.reset();
                              usernameController.clear();
                              passwordController.clear();
                              passwordConfirmationController.clear();
                            },
                            child: Text(
                              register == true ? 'Se connecter' : 'Créer un compte',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            default:
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
          }
        },
      ),
    );
  }
}
