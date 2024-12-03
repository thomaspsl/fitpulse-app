import 'package:fitpulse_app/app/components/layouts/mapper.dart';
import 'package:fitpulse_app/app/screens/exercise/create.dart';
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
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    if (hide) {
      return AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      );
    }

    var color = Provider.of<ThemeProvider>(context).color;
    final String currentRoute = GoRouterState.of(context).matchedLocation;

    Widget? bottomSheetContent;
    if (currentRoute == '/') {
      bottomSheetContent = const SessionCreate();
    } else if (currentRoute == '/exercise') {
      bottomSheetContent = const ExerciseCreate ();
    }

    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      centerTitle: true,

      // Left part
      leading: bottomSheetContent != null
          ? Container(
        padding: const EdgeInsets.only(top: 7, left: 10),
        child: GestureDetector(
          onTap: () => {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) => bottomSheetContent!,
            )
          },
          child: Icon(
            Icons.add_outlined,
            color: color,
            size: 35,
          ),
        ),
      )
          : null,

      // Center part
      title: GestureDetector(
        onTap: () => GoRouter.of(context).goNamed('session.index'),
        child: Container(
            padding: const EdgeInsets.only(top: 5),
            child: SvgPicture(SvgAssetLoader('lib/assets/images/logo.svg',
                colorMapper: SvgColorMapper(svgColor: color)))),
      ),

      // Right part
      actions: [
        Container(
          padding: const EdgeInsets.only(top: 11, right: 20, bottom: 7),
          child: GestureDetector(
            onTap: () => context.goNamed('profile.index'),
            child: Container(
              padding: const EdgeInsets.only(bottom: 2),
              child: Icon(
                Icons.account_circle_rounded,
                color: color,
                size: 40,
              ),
            ),
          ),
        )
      ],
    );
  }
}
