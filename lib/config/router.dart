import 'package:go_router/go_router.dart';
import 'package:itunes/config/route_path.dart';
import 'package:itunes/views/description.dart';
import 'package:itunes/views/entities.dart';
import 'package:itunes/views/results.dart';
import 'package:itunes/views/search.dart';
import 'package:itunes/views/splash.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (_, __) => '/${RoutePath.splash.name}',
    ),
    GoRoute(
      path: '/${RoutePath.splash.name}',
      name: RoutePath.splash.name,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/${RoutePath.search.name}',
      name: RoutePath.search.name,
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/${RoutePath.entities.name}',
      name: RoutePath.entities.name,
      builder: (context, state) => EntitiesScreen(
        media: state.extra as String,
      ),
    ),
    GoRoute(
      path: '/${RoutePath.results.name}',
      name: RoutePath.results.name,
      builder: (context, state) => const ResultsScreen(),
    ),
    GoRoute(
      path: '/${RoutePath.description.name}',
      name: RoutePath.description.name,
      builder: (context, state) => DescriptionScreen(
        values: state.extra as ValuesToShow,
      ),
    ),
  ],
);
