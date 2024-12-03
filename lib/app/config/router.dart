import 'package:fitpulse_app/app/components/layouts/transition.dart';
import 'package:fitpulse_app/app/screens/exercise/index.dart';
import 'package:fitpulse_app/app/screens/history/index.dart';
import 'package:fitpulse_app/app/screens/planning/index.dart';
import 'package:fitpulse_app/app/screens/register/index.dart';
import 'package:fitpulse_app/app/components/app/footer.dart';
import 'package:fitpulse_app/app/components/app/header.dart';
import 'package:fitpulse_app/app/screens/profile/index.dart';
import 'package:fitpulse_app/app/screens/session/index.dart';
import 'package:fitpulse_app/app/screens/login/index.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

abstract class AppRouter extends StatelessWidget {
  const AppRouter({super.key});

  static late Widget currentRouteWidget;

  // Global routes for the application
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: Header(hide: true),
            body: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: child,
            ),
            bottomNavigationBar: const Footer(hide: true),
          );
        },
        routes: [
          GoRoute(
            path: '/login',
            name: 'login.index',
            pageBuilder: (context, state) {
              currentRouteWidget = const LoginIndex();
              return NoTransitionPage(
                child: currentRouteWidget,
              );
            },
          ),
          GoRoute(
            path: '/register',
            name: 'register.index',
            pageBuilder: (context, state) {
              currentRouteWidget = const RegisterIndex();
              return NoTransitionPage(
                child: currentRouteWidget,
              );
            },
          ),
        ],
      ),
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
            name: 'session.index',
            pageBuilder: (context, state) {
              currentRouteWidget = const SessionIndex();
              return NoTransitionPage(
                child: currentRouteWidget,
              );
            },
          ),
          GoRoute(
            path: '/exercise',
            name: 'exercise.index',
            pageBuilder: (context, state) {
              currentRouteWidget = const ExerciseIndex();
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
            path: '/history',
            name: 'history.index',
            pageBuilder: (context, state) {
              currentRouteWidget = const HistoryIndex();
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
