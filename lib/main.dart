import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'graphql/models.dart';
import 'graphql/queries.dart';

final httpLink = HttpLink(
    "https://api.thegraph.com/subgraphs/name/hausdao/daohaus-v3-goerli");

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
          debugShowCheckedModeBanner: false,
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

          Map<String, dynamic>? response = result.data;
          if (response == null) {
            return const Text("no data");
          }

          DAO dao = DAO.fromJson(response['dao']);

          return ListView.builder(
              itemCount: dao.proposals.length,
              itemBuilder: (context, index) {
                final proposal = dao.proposals[index];
                return Card(
                    child: ListTile(
                  title: Text(proposal.title),
                  subtitle: Text(proposal.proposalId),
                ));
              });
        });
  }
}
