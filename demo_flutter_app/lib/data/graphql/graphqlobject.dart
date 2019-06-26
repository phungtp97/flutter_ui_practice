import 'package:demo_flutter_app/utils/constants/apiendpoint.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter/material.dart';

class GraphQlObject {
  static HttpLink httpLink = HttpLink(
    uri: ApiEndPoint.BASE_URL,
  );
  static AuthLink authLink = AuthLink();
  static Link link = httpLink as Link;

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: link,
    ),
  );
}
