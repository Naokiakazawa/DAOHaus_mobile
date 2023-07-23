import 'package:flutter/material.dart';
import './proposal_detail.dart';
import '../graphql/models.dart';

class ProposalCard extends StatelessWidget {
  final Proposal proposal;

  const ProposalCard({super.key, required this.proposal});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(proposal.title),
        subtitle: Text('Proposal ID: ${proposal.proposalId}'),
        onTap: () => {
          Navigator.of(context).push(MaterialPageRoute(
              builder: ((BuildContext context) => ProposalDetail(
                    proposal: proposal,
                  ))))
        },
      ),
    );
  }
}
