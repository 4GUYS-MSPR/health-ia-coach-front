import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_ia_care/features/publication/presentation/bloc/publication_bloc.dart';
import 'package:health_ia_care/features/publication/presentation/widgets/publication_card.dart';

class PublicationListPage extends StatefulWidget {
  const PublicationListPage({super.key});

  @override
  State<PublicationListPage> createState() => _PublicationListPageState();
}

class _PublicationListPageState extends State<PublicationListPage> {
  @override
  void initState() {
    super.initState();
    getAllPublications();
  }

  void getAllPublications() {
    context.read<PublicationBloc>().add(GetPublicationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PublicationBloc, PublicationState>(
      builder: (context, state) {
        if (state is PublicationLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (state is GetPublicationFailure) {
          return Center(child: Text('Erreur: ${state.message}'));
        }
        
        if (state is GetPublicationsSuccess) {
          return ListView.separated(
            itemCount: state.publications.length,
            itemBuilder: (context, index) {
              return PublicationCard(publication: state.publications[index]);
            },
            padding: EdgeInsets.symmetric(vertical: 10),
            separatorBuilder: (context, index) => const Divider(indent: 10, endIndent: 10),
          );
        }
        
        return const SizedBox.shrink();
      },
    );
  }
}
