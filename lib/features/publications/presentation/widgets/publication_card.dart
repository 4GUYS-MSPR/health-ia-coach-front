import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/secrets/app_secrets.dart';
import '../../../comment/presentation/widgets/comments_bottom_sheet.dart';
import '../../domain/entities/publication.dart';
import '../../domain/entities/publication_type.dart';
import '../bloc/publication_bloc.dart';
import 'autoplay_video.dart';

class PublicationCard extends StatelessWidget {
  final Publication publication;

  const PublicationCard({super.key, required this.publication});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Media(publication: publication),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  publication.description,
                  style: Theme.of(context).textTheme.titleLarge,
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
                          onTap: () => context.read<PublicationBloc>().add(
                            PublicationSetLikedEvent(
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
                                return CommentsBottomSheet(publicationId: publication.id);
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
                    Icon(Icons.share_outlined, size: 20),
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
