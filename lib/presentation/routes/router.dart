import 'package:fitpulse_app/presentation/screens/plannifieur/index.dart';
import 'package:fitpulse_app/presentation/screens/profile/index.dart';
import 'package:fitpulse_app/presentation/screens/programme/index.dart';
import 'package:fitpulse_app/presentation/screens/planning/index.dart';
import 'package:fitpulse_app/presentation/screens/seance/create.dart';
import 'package:fitpulse_app/presentation/screens/seance/index.dart';
import 'package:fitpulse_app/presentation/widgets/transition.dart';
import 'package:fitpulse_app/presentation/widgets/footer.dart';
import 'package:fitpulse_app/presentation/widgets/header.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

abstract class AppRouter extends StatelessWidget {
  const AppRouter({super.key});

  static late Widget currentRouteWidget;

  // Global routes for the application
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: const Header(),
            body: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: child,
            ),
            bottomNavigationBar: const Footer(),
          );
        },
        routes: [
          GoRoute(
            path: '/',
            name: 'programme.index',
            pageBuilder: (context, state) {
              currentRouteWidget = const ProgrammeIndex();
              return NoTransitionPage(
                child: currentRouteWidget,
              );
            },
          ),
          GoRoute(
            path: '/seance',
            name: 'seance.index',
            pageBuilder: (context, state) {
              currentRouteWidget = const SeanceIndex();
              return NoTransitionPage(
                child: currentRouteWidget,
              );
            },
            routes: [
              GoRoute(
                path: '/create',
                name: 'seance.create',
                pageBuilder: (context, state) {
                  currentRouteWidget = const SeanceCreate();
                  return NoTransitionPage(
                    child: currentRouteWidget,
                  );
                },
              ),
            ]
          ),
          GoRoute(
            path: '/plannifieur',
            name: 'plannifieur.index',
            pageBuilder: (context, state) {
              currentRouteWidget = const PlannifieurIndex();
              return NoTransitionPage(
                child: currentRouteWidget,
              );
            },
          ),
          GoRoute(
            path: '/planning',
            name: 'planning.index',
            pageBuilder: (context, state) {
              currentRouteWidget = const PlanningIndex();
              return NoTransitionPage(
                child: currentRouteWidget,
              );
            },
          ),
          GoRoute(
            path: '/profile',
            name: 'profile.index',
            pageBuilder: (context, state) => CustomTransitionPage(
              transitionsBuilder: (context, animation, secondaryAnimation,
                  child) =>
                  bookTransition(context, animation, secondaryAnimation, child,
                      currentRouteWidget, 1),
              child: const ProfileIndex(),
            ),
          ),
        ],
      ),
    ],
  );
}


