import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/register_cubit/register_cubit.dart';

class RegisterCompactLayout extends StatelessWidget {
  const RegisterCompactLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inscription")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: context.read<RegisterCubit>().formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: context.read<RegisterCubit>().usernameController,
                  decoration: const InputDecoration(labelText: 'Nom d\'utilisateur'),
                  validator: (val) => val != null && val.isEmpty ? 'Requis' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: context.read<RegisterCubit>().passwordController,
                  decoration: const InputDecoration(labelText: 'Mot de passe'),
                  obscureText: true,
                  validator: (val) => val != null && val.isEmpty ? 'Requis' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: context.read<RegisterCubit>().structureCodeController,
                  decoration: const InputDecoration(labelText: 'Code de structure'),
                  validator: (val) => val != null && val.isEmpty ? 'Requis' : null,
                ),
                const SizedBox(height: 32),
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    if (state is RegisterLoadingState) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: () => context.read<RegisterCubit>().register(),
                      child: const Text('Créer mon compte'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
