import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final httpLink = HttpLink("https://example.com");

const String readCounters = r'''
  query ReadRepositories($nRepositories: Int!) {
    viewer {
      repositories(last: $nRepositories) {
        nodes {
          __typename
          id
          name
          viewerHasStarred
        }
      }
    }
  }
''';

ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(cache: GraphQLCache(store: HiveStore()), link: httpLink));

void main() {
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
          document: gql(readCounters),
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

          List? counters = result.data?['counter'];

          if (counters == null) {
            return const Text('no data');
          }

          return ListView.builder(
              itemCount: counters.length,
              itemBuilder: (context, index) {
                final counter = counters[index];
                return Text(counter ?? '');
              });
        });
  }
}
