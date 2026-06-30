import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/service_locator/service_locator.dart';
import '../../../../core/extensions/theme_extension.dart';
import '../../../../core/secrets/app_secrets.dart';
import '../../domain/entities/publication.dart';
import '../bloc/comments_bloc/comments_bloc.dart';
import '../bloc/publications_bloc/publications_bloc.dart';
import 'autoplay_video.dart';
import 'comments_bottom_sheet.dart';

class PublicationCard extends StatelessWidget {
  final Publication publication;

  const PublicationCard({super.key, required this.publication});

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      clipBehavior: .antiAlias,
      color: context.colorScheme.surfaceContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Media(publication: publication),
          Padding(
            padding: const .all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: publication.author.avatarUrl != null
                          ? NetworkImage(AppSecrets.baseUrl + publication.author.avatarUrl!)
                          : null,
                      child: publication.author.avatarUrl == null
                          ? Text(
                              publication.author.username.isNotEmpty
                                  ? publication.author.username[0].toUpperCase()
                                  : '?',
                            )
                          : null,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      publication.author.username,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  publication.description,
                  style: context.textTheme.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  spacing: 16,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => context.read<PublicationsBloc>().add(
                            PublicationsSetLikedEvent(
                              liked: !publication.hasLiked,
                              id: publication.id,
                            ),
                          ),
                          child: Icon(
                            publication.hasLiked ? Icons.favorite : Icons.favorite_border,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          publication.likes.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              useRootNavigator: true,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return BlocProvider(
                                  create: (context) => sl<CommentsBloc>(),
                                  child: CommentsBottomSheet(publicationId: publication.id),
                                );
                              },
                            );
                          },
                          child: Icon(
                            publication.hasCommented ? Icons.chat : Icons.chat_outlined,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          publication.comments.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Media extends StatelessWidget {
  final Publication publication;

  const Media({super.key, required this.publication});

  @override
  Widget build(BuildContext context) {
    final isVideo = publication.type == PublicationType.video;
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: isVideo
              ? AutoplayVideo(url: AppSecrets.baseUrl + publication.video!)
              : Image.network(
                  AppSecrets.baseUrl + publication.image!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
        ),
      ],
    );
  }
}
