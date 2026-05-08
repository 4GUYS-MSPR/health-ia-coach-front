import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_ia_care/app/service_locator/service_locator.dart';
import 'package:health_ia_care/features/publication/presentation/bloc/publication_bloc.dart';
import 'package:health_ia_care/features/publication/presentation/widgets/add_new_publication.dart';

class AddPublicationPage extends StatelessWidget {
  const AddPublicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PublicationBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Ajouter une publication"),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: AddPublicationForm(),
        ),
      ),
    );
  }
}