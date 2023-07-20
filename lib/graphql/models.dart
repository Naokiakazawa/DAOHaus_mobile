class DAO {
  final List<Proposal> proposals;

  DAO({required this.proposals});

  factory DAO.fromJson(Map<String, dynamic> json) {
    return DAO(
      proposals: (json['proposals'] as List)
          .map((item) => Proposal.fromJson(item))
          .toList(),
    );
  }
}

class Proposal {
  final String id;
  final String proposalId;
  final String description;
  final String title;

  Proposal(
      {required this.id,
      required this.proposalId,
      required this.description,
      required this.title});

  factory Proposal.fromJson(Map<String, dynamic> json) {
    return Proposal(
        id: json['id'],
        proposalId: json['proposalId'],
        description: json['description'],
        title: json['title']);
  }
}
