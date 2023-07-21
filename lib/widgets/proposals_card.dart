import 'package:flutter/material.dart';
import '../graphql/models.dart';

class MyCard extends StatelessWidget {
  final Proposal proposal;

  const MyCard({super.key, required this.proposal});

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
