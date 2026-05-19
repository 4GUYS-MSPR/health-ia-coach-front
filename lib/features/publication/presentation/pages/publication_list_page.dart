import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../data/models/publication_model.dart';
import '../bloc/publication_bloc.dart';
import '../widgets/publication_card.dart';

class PublicationListPage extends StatefulWidget {
  const PublicationListPage({super.key});

  @override
  State<PublicationListPage> createState() => _PublicationListPageState();
}

class _PublicationListPageState extends State<PublicationListPage> {
  List<PublicationModel> _publications = [];
  Completer<void>? _refreshCompleter;

  @override
  void initState() {
    super.initState();
    getAllPublications();
  }

  void getAllPublications() {
    context.read<PublicationBloc>().add(GetPublicationsEvent());
  }

  Future<void> _handleRefresh() async {
    _refreshCompleter = Completer<void>();
    getAllPublications();
    return _refreshCompleter!.future;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PublicationBloc, PublicationState>(
      listener: (context, state) {
        if (state is GetPublicationsSuccess) {
          setState(() {
            _publications = state.publications;
          });

          _refreshCompleter?.complete();
          _refreshCompleter = null;
        }

        if (state is GetPublicationFailure) {
          _refreshCompleter?.complete();
          _refreshCompleter = null;
        }

        if (state is PublicationSetLikedSuccess) {
          int index = _publications.indexWhere((p) => p.id == state.publication.id);

          if (index != -1) {
            setState(() {
              _publications = [..._publications];
              _publications[index] = state.publication;
            });
          }
        }
      },
      builder: (context, state) {
        if (state is PublicationLoading && _refreshCompleter == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetPublicationFailure) {
          return Center(child: Text('Erreur: ${state.message}'));
        }

        if (_publications.isEmpty) {
          return Center(child: Text(context.l10n.publicationListNoPublicationLabel));
        }

        return RefreshIndicator(
          onRefresh: _handleRefresh,
          edgeOffset: 10,
          child: ListView.separated(
            itemCount: _publications.length,
            itemBuilder: (context, index) {
              return PublicationCard(publication: _publications[index]);
            },
            padding: EdgeInsets.symmetric(vertical: 10),
            separatorBuilder: (context, index) => const Divider(indent: 10, endIndent: 10),
          ),
        );
      },
    );
  }
}
