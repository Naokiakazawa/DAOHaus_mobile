import 'package:flutter/material.dart';
import '../graphql/models.dart';

class ProposalDetail extends StatelessWidget {
  final Proposal proposal;

  const ProposalDetail({super.key, required this.proposal});

  @override
  Widget build(BuildContext context) {
    debugPrint(proposal.title);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Proposal Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(proposal.description),
      ),
    );
  }
}
