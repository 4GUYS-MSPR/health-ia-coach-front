import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:health_ia_care/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:health_ia_care/features/profile/presentation/widgets/personal_user_info.dart';
import '../../../../widgets/theme_switch_button.dart';
import 'package:health_ia_care/features/profile/presentation/widgets/display_member_info.dart';
import 'package:health_ia_care/features/profile/presentation/widgets/section_title.dart';


class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
  
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  void initState() {
    super.initState() ;
    WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<AuthBloc>().add(AuthGetUserEvent());
    });
  }
  late String username;
  late String firstName;
  late String lastName;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLogoutSucess){
            context.replace('/login');
          }
        },
        builder: (context, state) {
          if(state is AuthLoginSuccess){
            
          }
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Center(
                  child: Column(
                    children: [
                      Image.asset('assets/profile.png', width: 150.0),
                      SizedBox(height: 30,),
                      SectionTitle(title: 'Mon compte'),
                      SizedBox(height: 20,),
                      PersonalUserInfo(),
                      SizedBox(height: 20,),
                      Divider(
                        color: Theme.of(context).colorScheme.primary,
                        indent: 50, 
                        endIndent: 50,
              
                      ),
                      SizedBox(height: 20,),
                      SectionTitle(title: 'Mes infos'),
                      SizedBox(height: 20,),
                      DisplayMemberInfo(),
                      SizedBox(height: 20,),
                      Divider(
                        color: Theme.of(context).colorScheme.primary,
                        indent: 50, 
                        endIndent: 50,
              
                      ),
                      SizedBox(height: 20,),
                      Text('Paramètres',
                      style: TextStyle(
                        fontSize: 32
                      ),
                      ),
                      SizedBox(height: 20,),
                      SwitchThemeButton(),
                      SizedBox(height: 10,),
                      ElevatedButton(onPressed: () {
                        context.read<AuthBloc>().add(AuthLogoutEvent());
                      }, child: Text('Se déconnecter')),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
