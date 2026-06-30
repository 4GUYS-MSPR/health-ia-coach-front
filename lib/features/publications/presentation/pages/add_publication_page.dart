import 'package:flutter/material.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../widgets/add_new_publication.dart';

class AddPublicationPage extends StatelessWidget {
  const AddPublicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageContent();
  }
}

class PageContent extends StatelessWidget {
  const PageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.publicationAddAPublicationPageTitle),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: AddPublicationForm(),
      ),
    );
  }
}
