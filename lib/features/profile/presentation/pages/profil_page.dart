import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:health_ia_care/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:health_ia_care/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:health_ia_care/features/profile/presentation/widgets/avatar.dart';
import 'package:health_ia_care/features/profile/presentation/widgets/personal_user_info.dart';
import '../../../../core/shared/widgets/theme/theme_switch_button.dart';
import 'package:health_ia_care/features/profile/presentation/widgets/display_member_info.dart';
import 'package:health_ia_care/features/profile/presentation/widgets/section_title.dart';
import 'package:health_ia_care/features/profile/presentation/widgets/personal_user_modal_form.dart';
import 'package:health_ia_care/features/profile/presentation/widgets/personal_user_info_modal_form.dart';

import '../../../recommendations/presentation/blocs/recommendations/recommendations_bloc.dart';
import '../../data/models/member_model.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshData();
    });
  }

  Future<void> _refreshData() async {
    context.read<AuthBloc>().add(AuthGetUserEvent());
    context.read<ProfileBloc>().add(DisplayMemberRequestEvent());

    await Future<void>.delayed(const Duration(milliseconds: 500));
  }

  void showRecommandationModal(BuildContext context, MemberModel member) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        context.read<RecommendationsBloc>().add(RecommendationsRequest());
        return Container(
          height: 256,
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: BlocBuilder<RecommendationsBloc, RecommendationsState>(
            builder: (BuildContext context, RecommendationsState state) {
              switch (state) {
                case RecommendationsSuccess _:
                  return Center(
                    child: Text(state.output),
                  );
          
                case RecommendationsFailure _:
                  return Center(
                    child: Text(state.message),
                  );
          
                default:
                  return Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
              }
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator.adaptive(
        onRefresh: _refreshData,
        child: MultiBlocListener(
          listeners: [
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthLogoutSucess) {
                  context.replace('/login');
                }
              },
            ),
            BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ProfileUpdateSuccess) {
                  context.read<AuthBloc>().add(AuthGetUserEvent());
                  context.read<ProfileBloc>().add(DisplayMemberRequestEvent());
                }
              },
            ),
          ],
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading || state is AuthInitial) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                );
              }

              if (state is AuthSuccess || state is AuthUpdateAvatarSuccess) {
                state = state as AuthSuccess;
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
                        children: [
                          Avatar(
                            user: state.user,
                            onTapEdit: () async {
                              FilePickerResult? result = await FilePicker.pickFiles(
                                type: FileType.image,
                              );
                              if (!context.mounted) return;
                              if (result != null) {
                                context.read<AuthBloc>().add(
                                  AuthUpdateAvatarEvent(file: result.files.first),
                                );
                              }
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          SectionTitle(
                            title: 'Mon compte',
                            onTapEdit: () {
                              showModalBottomSheet<void>(
                                context: context,
                                useSafeArea: true,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.9,
                                    child: PersonalUserModalForm(
                                      user: (state as AuthSuccess).user,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          PersonalUserInfo(
                            user: state.user,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            color: Theme.of(context).colorScheme.primary,
                            indent: 50,
                            endIndent: 50,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<ProfileBloc, ProfileState>(
                            builder: (context, profileState) {
                              switch (profileState) {
                                case ProfileMemberUpdateSuccess(member: final member) ||
                                    ProfileGetTrainingSuccess(member: final member):
                                  return Column(
                                    children: [
                                      SectionTitle(
                                        title: 'Mes infos',
                                        onTapEdit: () {
                                          showModalBottomSheet<void>(
                                            context: context,
                                            useSafeArea: true,
                                            isScrollControlled: true,
                                            builder: (BuildContext context) {
                                              return SizedBox(
                                                height: MediaQuery.of(context).size.height * 0.9,
                                                child: PersonalUserInfoModalForm(member: member),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      DisplayMemberInfo(
                                        member: member,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      FilledButton.icon(
                                        label: Text('Demander une recommandation'),
                                        icon: Icon(Icons.dinner_dining),
                                        onPressed: () => showRecommandationModal(context, member),
                                      ),
                                    ],
                                  );

                                default:
                                  return Center(child: CircularProgressIndicator.adaptive());
                              }
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            color: Theme.of(context).colorScheme.primary,
                            indent: 50,
                            endIndent: 50,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Paramètres',
                            style: TextStyle(fontSize: 32),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SwitchThemeButton(),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context.read<AuthBloc>().add(AuthLogoutEvent());
                            },
                            child: Text('Se déconnecter'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: 400,
                  child: const Center(child: Text("Erreur de récupération des données")),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
