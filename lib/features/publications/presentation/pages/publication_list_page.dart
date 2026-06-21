import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../bloc/publications_bloc/publications_bloc.dart';
import '../widgets/publication_card.dart';

class PublicationListPage extends StatefulWidget {
  const PublicationListPage({super.key});

  @override
  State<PublicationListPage> createState() => _PublicationListPageState();
}

class _PublicationListPageState extends State<PublicationListPage> {
  @override
  void initState() {
    super.initState();
    context.read<PublicationsBloc>().add(GetPublicationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PublicationsBloc, PublicationsState>(
        builder: (context, state) {
          if (state is PublicationsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetPublicationsFailure) {
            return Center(child: Text('Erreur: ${state.message}'));
          }

          if (state is GetPublicationsSuccess) {
            final publications = state.publications;

            if (publications.isEmpty) {
              return Center(child: Text(context.l10n.publicationListNoPublicationLabel));
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<PublicationsBloc>().add(GetPublicationsEvent());
              },
              edgeOffset: 10,
              child: ListView.separated(
                itemCount: publications.length,
                itemBuilder: (context, index) {
                  return PublicationCard(publication: publications[index]);
                },
                padding: const EdgeInsets.all(16),
                separatorBuilder: (context, index) => const SizedBox(height: 8),
              ),
            );
          }

          return Text(state.toString());
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'publication_list_fab',
        onPressed: () {},
        child: const Icon(Symbols.add),
      ),
    );
  }
}
