import 'package:flutter/material.dart';
import '../graphql/models.dart';

class ProposalCard extends StatelessWidget {
  final Proposal proposal;

  const ProposalCard({super.key, required this.proposal});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(proposal.description),
        subtitle: Text('Proposal ID: ${proposal.proposalId}'),
      ),
    );
  }
}
