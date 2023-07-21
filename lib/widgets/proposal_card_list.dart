import 'package:flutter/material.dart';
import 'proposals_card.dart';
import '../graphql/models.dart';

class ProposalCardList extends StatelessWidget {
  final List<Proposal> proposals;

  const ProposalCardList({super.key, required this.proposals});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: proposals.length,
      itemBuilder: (context, index) {
        return ProposalCard(proposal: proposals[index]);
      },
    );
  }
}
