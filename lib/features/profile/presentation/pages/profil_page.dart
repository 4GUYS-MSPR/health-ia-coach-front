import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../app/service_locator/service_locator.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../../core/shared/widgets/locale/select_locale_dialog.dart';
import '../../../../core/shared/widgets/theme/select_theme_dialog.dart';

import '../bloc/profile_bloc.dart';
import '../widgets/avatar.dart';
import '../widgets/profile_account_section.dart';
import '../widgets/profile_infos_section.dart';

class ProfilPage extends StatelessWidget {
  final VoidCallback onLogout;
  final Widget? recommendationSection;
  
  const ProfilPage({super.key, required this.onLogout, this.recommendationSection});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileBloc>()..add(GetProfileEvent()),
      child: ProfilePageContent(onLogout: onLogout, recommendationSection: recommendationSection),
    );
  }
}

class ProfilePageContent extends StatelessWidget {
  final VoidCallback onLogout;
  final Widget? recommendationSection;
  
  const ProfilePageContent({
    super.key,
    required this.onLogout,
    this.recommendationSection,
  });



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator.adaptive(
        onRefresh: () async => context.read<ProfileBloc>().add(GetProfileEvent()),
        child: MultiBlocListener(
          listeners: [
            BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ProfileFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
            ),
          ],
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading || state is ProfileInitial) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                );
              }

              if (state is ProfileLoaded) {
                final profile = state.profile;
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
                        children: [
                          Avatar(
                            profile: profile,
                            onTapEdit: () async {
                              FilePickerResult? result = await FilePicker.pickFiles(
                                type: FileType.image,
                              );
                              if (!context.mounted) return;
                              if (result != null) {
                                context.read<ProfileBloc>().add(
                                  UpdateAvatarEvent(result.files.first),
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Hi ${profile.firstname}!",
                            style: context.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (recommendationSection != null) ...[
                            recommendationSection!,
                            const SizedBox(height: 16),
                          ],
                          ProfileAccountSection(profile: profile),
                          const SizedBox(height: 8),
                          ProfileInfosSection(profile: profile),
                          const SizedBox(height: 8),
                          Card.filled(
                            margin: EdgeInsets.zero,
                            clipBehavior: Clip.antiAlias,
                            child: ExpansionTile(
                              leading: const Icon(Symbols.settings),
                              shape: const Border.fromBorderSide(BorderSide.none),
                              title: Text(context.l10n.profileSettingsSectionTitle),
                              children: [
                                ListTile(
                                  dense: true,
                                  leading: const Icon(Symbols.routine),
                                  title: const Text("App theme"),
                                  trailing: const Icon(Symbols.chevron_right),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => SelectThemeDialog(),
                                    );
                                  },
                                ),
                                ListTile(
                                  dense: true,
                                  leading: const Icon(Symbols.language),
                                  title: const Text("Language"),
                                  trailing: const Icon(Symbols.chevron_right),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => SelectLocaleDialog(),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Card.filled(
                            margin: EdgeInsets.zero,
                            child: AboutListTile(
                              icon: Icon(Symbols.info),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton.tonalIcon(
                              onPressed: onLogout,
                              icon: const Icon(Symbols.logout),
                              label: Text(context.l10n.profileLogOutButtonLabel),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: 400,
                  child: Center(child: Text("Erreur de récupération des données")),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
