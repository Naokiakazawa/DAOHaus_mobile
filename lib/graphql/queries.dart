const String readProposals = r'''
  query ReadProposals {
    dao(id: "0xf433405d591190283050f217ba3b62a0bca018c0") {
      proposals {
        id
        proposalId
        description
        title
      }
    }
  }
''';
