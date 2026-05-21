import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_ia_care/features/comment/data/models/comment_model.dart';
import 'package:health_ia_care/features/comment/presentation/bloc/comment_bloc.dart';
import 'package:health_ia_care/features/profile/presentation/widgets/avatar.dart';

class CommentsBottomSheet extends StatefulWidget {
  final int publicationId;
  const CommentsBottomSheet({required this.publicationId, super.key});

  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CommentBloc>().add(
      CommentGetAllEvent(publicationId: widget.publicationId),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Commentaires',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: BlocBuilder<CommentBloc, CommentState>(
                  builder: (context, state) {
                    if (state is CommentLoading) {
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }

                    if (state is CommentSuccess) {
                      return ListView.builder(
                        controller: scrollController,
                        itemCount: state.comments.length,
                        itemBuilder: (context, index) {
                          CommentModel comment = state.comments[index];
                          return ListTile(
                            leading: SizedBox(
                              height: 40,
                              width: 40,
                              child: Avatar(
                                user: comment.user,
                              ),
                            ),
                            title: Text(
                              comment.user.username,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            subtitle: Text(
                              comment.content,
                              style: TextStyle(fontSize: 14),
                            ),
                          );
                        },
                      );
                    }

                    return Center(
                      child: Text("Erreur lors de la récupération des commentaires."),
                    );
                  },
                ),
              ),
              const Divider(height: 1),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 8, bottom: bottomInset + 8, top: 8),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 16,
                        child: Icon(Icons.person, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          decoration: const InputDecoration(
                            hintText: 'Ajouter un commentaire...',
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 14),
                          ),
                          maxLines: null,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          String text = _commentController.text.trim();
                          if (text.isNotEmpty) {
                            print("Envoi du commentaire: $text");
                            _commentController.clear();
                            FocusScope.of(context).unfocus();
                          }
                        },
                        child: Text(
                          'Publier',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
