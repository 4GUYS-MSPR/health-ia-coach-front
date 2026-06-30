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
import '../../../../features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import '../widgets/avatar.dart';
import '../widgets/profile_account_section.dart';
import '../widgets/profile_infos_section.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileBloc>()..add(GetProfileEvent()),
      child: const ProfilePageContent(),
    );
  }
}

class ProfilePageContent extends StatelessWidget {
  const ProfilePageContent({super.key});



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
                if (state is ProfileUpdateSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(context.l10n.profileSaveSuccessMessage),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                  );
                }
              },
            ),
          ],
          child: BlocBuilder<ProfileBloc, ProfileState>(
            buildWhen: (previous, current) =>
                current is! ProfileFailure,
            builder: (context, state) {
              if (state is ProfileLoading || state is ProfileInitial) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                );
              }

              final profile = switch (state) {
                ProfileLoaded(:final profile) => profile,
                ProfileUpdateSuccess(:final profile) => profile,
                _ => null,
              };

              if (profile != null) {
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
                            context.l10n.profileHello(profile.firstname),
                            style: context.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 16),
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
                                  title: Text(context.l10n.profileAppThemeTitle),
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
                                  title: Text(context.l10n.profileLanguageTitle),
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
                              onPressed: () {
                                context.read<AuthBloc>().add(AuthLogoutEvent());
                              },
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
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: 400,
                  child: Center(child: Text(context.l10n.profileDataError)),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
