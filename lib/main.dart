import 'package:chat_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Screens/login_screen.dart';
import 'bloc/authentication/authentication_bloc.dart';
import 'bloc/login/login_bloc.dart';
import 'constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await repository.queries.openAuthBox();
  runApp(RestartWidget(child: MyApp()));
}

class RestartWidget extends StatefulWidget {
  final Widget child;

  RestartWidget({this.child});

  static void restartApp(BuildContext context) {
    final state = context.findAncestorStateOfType<_RestartWidgetState>();
//    final _RestartWidgetState state =
//        context.ancestorStateOfType(const TypeMatcher<_RestartWidgetState>());
    state.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      child: BlocProvider<AuthenticationBloc>(
        create: (BuildContext context) =>
            AuthenticationBloc()..add(AppStarted()),
        child: widget.child,
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (BuildContext context) => LoginBloc())
      ],
      child: MaterialApp(
          title: 'Flutter Chat',
          theme: ThemeData(
            primarySwatch: Colors.teal,
            accentColor: Colors.tealAccent,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              return state is AuthenticationAuthenticated
                  ? HomeScreen()
                  : LoginScreen();
            },
          )),
    );
  }
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case (homeRoute):
        return MaterialPageRoute(
            builder: (_) => HomeScreen(), settings: settings);
      default:
        return MaterialPageRoute(
            builder: (_) => HomeScreen(), settings: settings);
    }
  }
}
