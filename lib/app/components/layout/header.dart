import 'package:fitpulse_app/app/components/widgets/mapper.dart';
import 'package:fitpulse_app/app/views/exercise/create.dart';
import 'package:fitpulse_app/app/views/planning/create.dart';
import 'package:fitpulse_app/app/views/session/create.dart';
import 'package:fitpulse_app/data/providers/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final bool hide;

  const Header({super.key, this.hide = false});

  @override
  Size get preferredSize => Size.fromHeight(hide ? 0 : 55);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    if (hide) {
      return AppBar(
        backgroundColor: themeData.scaffoldBackgroundColor,
      );
    }

    return AppBar(
      backgroundColor: themeData.scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: buildLeadingWidget(context),
      title: buildTitleWidget(context),
      actions: buildActionsWidget(context),
    );
  }
}

Widget buildLeadingWidget(BuildContext context) {
  GoRouterState routerState = GoRouterState.of(context);
  MediaQueryData mediaQueryData = MediaQuery.of(context);
  ThemeProvider themeProvider = Provider.of(context);
  ThemeData themeData = Theme.of(context);
  GoRouter router = GoRouter.of(context);

  bool canPop = router.canPop();
  String currentRoute = routerState.uri.toString();
  Widget? bottomSheetContent = getBottomSheetContent(currentRoute);

  if (canPop) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 5),
      child: GestureDetector(
        onTap: () => router.pop(),
        child: Icon(Icons.chevron_left_rounded,
            color: themeProvider.color, size: 40),
      ),
    );
  } else if (bottomSheetContent != null) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 5),
      child: GestureDetector(
        onTap: () => showModalBottomSheet(
          context: context,
          backgroundColor: themeData.scaffoldBackgroundColor,
          useSafeArea: true,
          isScrollControlled: true,
          builder: (context) => Padding(
            padding: EdgeInsets.only(
              bottom: mediaQueryData.viewInsets.bottom,
            ),
            child: bottomSheetContent,
          ),
        ),
        child: Icon(Icons.add_outlined, color: themeProvider.color, size: 40),
      ),
    );
  } else {
    return const SizedBox.shrink();
  }
}

Widget? getBottomSheetContent(String currentRoute) {
  switch (currentRoute) {
    case '/':
      return const SessionCreate();
    case '/exercise':
      return const ExerciseCreate();
    case '/planning':
      return const PlanningCreate();
    default:
      return null;
  }
}

Widget buildTitleWidget(BuildContext context) {
  ThemeProvider themeProvider = Provider.of(context);
  GoRouter router = GoRouter.of(context);

  return GestureDetector(
    onTap: () => router.goNamed('session.index'),
    child: Padding(
      padding: const EdgeInsets.only(top: 5),
      child: SvgPicture(
        SvgAssetLoader(
          'lib/assets/images/logo.svg',
          colorMapper: Mapper(c: themeProvider.color),
        ),
      ),
    ),
  );
}

List<Widget> buildActionsWidget(BuildContext context) {
  GoRouterState routerState = GoRouterState.of(context);
  ThemeProvider themeProvider = Provider.of(context);
  GoRouter goRouter = GoRouter.of(context);

  String currentRoute = routerState.uri.toString();

  if (currentRoute != '/profile') {
    return [
      Padding(
        padding: const EdgeInsets.only(top: 2, right: 15),
        child: GestureDetector(
          onTap: () => goRouter.pushNamed('profile.index'),
          child: Icon(Icons.account_circle_rounded,
              color: themeProvider.color, size: 40),
        ),
      ),
    ];
  } else {
    return [];
  }
}