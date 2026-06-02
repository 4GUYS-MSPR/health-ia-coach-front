import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/service_locator/service_locator.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../bloc/publication_bloc.dart';
import '../widgets/add_new_publication.dart';

class AddPublicationPage extends StatelessWidget {
  const AddPublicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PublicationBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.publicationAddAPublicationPageTitle),
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: AddPublicationForm(),
        ),
      ),
    );
  }
}
