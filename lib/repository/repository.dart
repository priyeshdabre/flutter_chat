import 'package:chat_app/repository/local/queries.dart';
import 'package:chat_app/repository/remote/remote_apis.dart';

class Repository {
  final remoteApis = RemoteApis();
  final queries = Queries();
}
