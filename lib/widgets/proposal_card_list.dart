import 'package:flutter/material.dart';
import 'proposals_card.dart';
import '../graphql/models.dart';

class MyCardList extends StatelessWidget {
  final List<Proposal> proposals;

  const MyCardList({super.key, required this.proposals});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: proposals.length,
      itemBuilder: (context, index) {
        return MyCard(proposal: proposals[index]);
      },
    );
  }
}
