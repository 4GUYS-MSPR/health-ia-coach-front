import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/shared/widgets/file_picker.dart';
import '../../domain/entities/publication_type.dart';
import '../bloc/publication_bloc.dart';

class AddPublicationForm extends StatefulWidget {
  const AddPublicationForm({super.key});

  @override
  _AddPublicationFormState createState() => _AddPublicationFormState();
}

class _AddPublicationFormState extends State<AddPublicationForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _descriptionController;
  PlatformFile? _selectedMedia;
  String message = '';

  void handleMedia(PlatformFile data) {
    setState(() {
      _selectedMedia = data;
    });
  }

  void addNewPublication() async {
    if (_selectedMedia == null) {
      setState(() {
        message = context.l10n.publicationMediaRequiredLabel;
      });
      return;
    }

    PublicationType type;
    if (['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(_selectedMedia!.extension)) {
      type = PublicationType.image;
    } else if (['mp4', 'mov', 'avi', 'mkv', 'dvr'].contains(_selectedMedia!.extension)) {
      type = PublicationType.video;
    } else {
      setState(() {
        message = context.l10n.publicationInvalidFormatLabel;
      });
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<PublicationBloc>().add(
      AddPublicationEvent(
        type: type,
        description: _descriptionController.text,
        media: _selectedMedia!,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PublicationBloc, PublicationState>(
      listener: (context, state) {
        if (state is AddPublicationSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.l10n.publicationSuccessLabel)),
          );
          setState(() {
            _selectedMedia = null;
            _descriptionController.clear();
            message = '';
          });
        } else if (state is PublicationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.l10n.publicationErrorLabel(state.message))),
          );
        }
      },
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: Column(
          children: <Widget>[
            CustomFilePicker(sendMedia: handleMedia),

            if (message.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.red),
                ),
              ),

            TextFormField(
              decoration: InputDecoration(labelText: context.l10n.publicationAddAPublicationDescriptionFormFieldLabel),
              controller: _descriptionController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return context.l10n.publicationDescriptionRequiredLabel;
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            BlocBuilder<PublicationBloc, PublicationState>(
              builder: (context, state) {
                print(state);
                if (state is PublicationLoading) {
                  return const CircularProgressIndicator();
                }

                return ElevatedButton(
                  onPressed: addNewPublication,
                  child: Text(
                    context.l10n.publicationAddAPublicationConfirmButtonLabel,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
