import 'package:flutter/material.dart';
import 'package:health_ia_care/features/publication/domain/entities/publication.dart';
import 'package:health_ia_care/features/publication/domain/entities/publication_type.dart';
import 'package:health_ia_care/features/publication/presentation/widgets/publication_card.dart';

class PublicationListPage extends StatefulWidget {
  const PublicationListPage({super.key});

  @override
  State<PublicationListPage> createState() => _PublicationListPageState();
}

class _PublicationListPageState extends State<PublicationListPage> {
  final List<Publication> publications = [
    Publication(
      id: 1,
      type: PublicationType.image,
      image: '/publication/images/c0391bcf-a49c-4d5e-bd1b-25c2e69aefe6.png',
      description: 'TEST'
    ),
    // Publication(
    //   id: 2,
    //   type: PublicationType.video,
    //   video: '/publication/videos/94890b81-0fbe-4912-80c8-6798506465c7.mov',
    //   description: 'TEST de vidéo'
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: publications.length,
      itemBuilder: (context, index) {
        return PublicationCard(publication: publications[index]);
      },
      padding: EdgeInsets.symmetric(vertical: 10),
      separatorBuilder: (context, index) => const Divider(indent: 10, endIndent: 10,),
    );
  }
}
