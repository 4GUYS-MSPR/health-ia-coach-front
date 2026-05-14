import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:health_ia_care/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:health_ia_care/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:health_ia_care/features/profile/presentation/widgets/personal_user_info.dart';
import '../../../../widgets/theme_switch_button.dart';
import 'package:health_ia_care/features/profile/presentation/widgets/display_member_info.dart';
import 'package:health_ia_care/features/profile/presentation/widgets/section_title.dart';
import 'package:health_ia_care/features/profile/presentation/widgets/personal_user_modal_form.dart';
import 'package:health_ia_care/features/profile/presentation/widgets/personal_user_info_modal_form.dart';

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

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLogoutSucess){
                context.replace('/login');
              }
            },
          ),
          BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileUpdateSuccess) {
                context.read<AuthBloc>().add(AuthGetUserEvent());
              }
            },
          ),
        ],
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading || state is AuthInitial) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (state is AuthSuccess) {
              final user = state.user;
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
                          SectionTitle(title: 'Mon compte',
                            onTapEdit: (){
                              showModalBottomSheet<void>(
                                context: context,
                                useSafeArea: true,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.9,
                                    child: PersonalUserModalForm(
                                      user: state.user,
                                      )
                                    );
                                },
                              );
                            }
                          ),
                          SizedBox(height: 20,),
                          PersonalUserInfo(
                            user: user,
                          ),
                          SizedBox(height: 20,),
                          Divider(
                            color: Theme.of(context).colorScheme.primary,
                            indent: 50, 
                            endIndent: 50,
                  
                          ),
                          SizedBox(height: 20,),
                          SectionTitle(title: 'Mes infos',
                          onTapEdit: (){
                            showModalBottomSheet<void>(
                                context: context,
                                useSafeArea: true,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.9,
                                    child: PersonalUserInfoModalForm());
                                },
                              );
                            },
                          ),
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
            }
            return const Scaffold(
              body: Center(child: Text("Erreur de récupération des données")),
            );
          },
        ),
      ),
    );
  }
}