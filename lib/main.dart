import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final httpLink = HttpLink("https://api.thegraph.com/subgraphs/name/hausdao/daohaus-v3-goerli");

const String readProposals = r'''
  query ReadProposals {
    dao(id: "0xf433405d591190283050f217ba3b62a0bca018c0") {
      proposals {
        id
        proposalId
        description
      }
    }
  }
''';

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

  Proposal({required this.id, required this.proposalId, required this.description});

  factory Proposal.fromJson(Map<String, dynamic> json) {
    return Proposal(
      id: json['id'],
      proposalId: json['proposalId'],
      description: json['description'],
    );
  }
}

ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(cache: GraphQLCache(store: HiveStore()), link: httpLink));

void main() async {
  await initHiveForFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: client,
        child: MaterialApp(
          title: 'DAOHaus mobile demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
          document: gql(readProposals),
          variables: const {
            'counterId': 23,
          },
          pollInterval: const Duration(seconds: 30),
        ),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          if (result.isLoading) {
            return const Text("Loading");
          }

          Map<String, dynamic>? response  = result.data;
          debugPrint('====== $response');
          if (response == null) {
            return const Text("no data");
          }

          DAO dao = DAO.fromJson(response['dao']);


          return ListView.builder(
              itemCount: dao.proposals.length,
              itemBuilder: (context, index) {
                final proposal = dao.proposals[index];
                return Text(proposal.description);
              });
        });
  }
}
