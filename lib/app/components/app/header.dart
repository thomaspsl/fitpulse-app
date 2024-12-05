import 'package:fitpulse_app/app/components/layouts/mapper.dart';
import 'package:fitpulse_app/app/screens/exercise/create.dart';
import 'package:fitpulse_app/app/screens/planning/create.dart';
import 'package:fitpulse_app/app/screens/session/create.dart';
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
    if (hide) {
      return AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      );
    }

    var theme = Provider.of<ThemeProvider>(context);

    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,

      // Left part
      leading: _buildLeadingWidget(context, theme.color),

      // Center part
      title: GestureDetector(
        onTap: () => GoRouter.of(context).goNamed('session.index'),
        child: Container(
          padding: const EdgeInsets.only(top: 5),
          child: SvgPicture(
            SvgAssetLoader(
              'lib/assets/images/logo.svg',
              colorMapper: SvgColorMapper(svgColor: theme.color),
            ),
          ),
        ),
      ),

      // Right part
      actions: _buildActionsWidget(context, theme.color),
    );
  }

  Widget _buildLeadingWidget(BuildContext context, Color color) {
    final GoRouter router = GoRouter.of(context);
    final bool canPop = router.canPop();

    final String currentRoute = GoRouterState.of(context).matchedLocation;

    Widget? bottomSheetContent;
    if (currentRoute == '/') {
      bottomSheetContent = const SessionCreate();
    } else if (currentRoute == '/exercise') {
      bottomSheetContent = const ExerciseCreate();
    } else if (currentRoute == '/planning') {
      bottomSheetContent = const PlanningCreate();
    }

    if (canPop) {
      return Padding(
        padding: const EdgeInsets.only(top: 5, left: 5),
        child: GestureDetector(
          onTap: () => GoRouter.of(context).pop(),
          child: Icon(Icons.chevron_left_rounded, color: color, size: 40),
        ),
      );
    } else if (bottomSheetContent != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 5, left: 5),
        child: GestureDetector(
          onTap: () => {
            showModalBottomSheet(
              context: context,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              useSafeArea: true,
              isScrollControlled: true,
              builder: (context) => bottomSheetContent!,
            ),
          },
          child: Icon(Icons.add_outlined, color: color, size: 40),
        ),
      );
    } else {
      return Container();
    }
  }

  List<Widget> _buildActionsWidget(BuildContext context, Color color) {
    final String currentRoute = GoRouterState.of(context).uri.toString();

    if (currentRoute != '/profile') {
      return [
        Padding(
          padding: const EdgeInsets.only(top: 2, right: 15),
          child: GestureDetector(
            onTap: () => GoRouter.of(context).pushNamed('profile.index'),
            child: Icon(Icons.account_circle_rounded, color: color, size: 40),
          ),
        ),
      ];
    } else {
      return [];
    }
  }
}
