import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_ia_care/core/extensions/l10n_extension.dart';
import 'package:timeago/timeago.dart' as timeago;

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
  List<CommentModel> _comments = [];

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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  context.l10n.publicationCommentsBottomSheetTittle,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: BlocConsumer<CommentBloc, CommentState>(
                  listener: (context, state) {
                    if (state is CommentSuccess) {
                      setState(() {
                        _comments = state.comments;
                      });
                    }

                    if (state is CommentCreateSuccess) {
                      setState(() {
                        _comments.insert(0, state.comment);
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is CommentLoading) {
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }

                    if (state is CommentFailure) {
                      if (kDebugMode) {
                        print(state.message);
                      }

                      return Center(
                        child: Text("Erreur lors de la récupération des commentaires."),
                      );
                    }

                    if (_comments.isEmpty) {
                      return Center(
                        child: Text("Aucun commentaire."),
                      );
                    }

                    return ListView.builder(
                      controller: scrollController,
                      itemCount: _comments.length,
                      itemBuilder: (context, index) {
                        CommentModel comment = _comments[index];
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
                          trailing: Text(
                            timeago.format(comment.createdAt),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        );
                      },
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
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          decoration: InputDecoration(
                            hintText: context.l10n.publicationCommentsAddACommentFormFieldLabel,
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
                            context.read<CommentBloc>().add(
                              CommentCreateEvent(
                                publicationId: widget.publicationId,
                                content: text,
                              ),
                            );
                            _commentController.clear();
                            FocusScope.of(context).unfocus();
                          }
                        },
                        child: Text(
                          context.l10n.publicationCommentsAddACommentConfirmButtonLabel,
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
