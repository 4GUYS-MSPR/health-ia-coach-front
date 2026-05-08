import 'package:flutter/material.dart';
import 'package:health_ia_care/core/secrets/app_secrets.dart';
import 'package:health_ia_care/features/publication/domain/entities/publication.dart';
import 'package:health_ia_care/features/publication/domain/entities/publication_type.dart';
import 'package:health_ia_care/features/publication/presentation/widgets/autoplay_video.dart';

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.favorite_border, size: 20),
                        const SizedBox(width: 4),
                        Text("12", style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(width: 16),
                        Icon(Icons.chat_bubble_outline, size: 20),
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
              ? AutoplayVideo(url: AppSecrets.mediaUrl + publication.video!)
              : Image.network(
                  AppSecrets.mediaUrl + publication.image!,
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
