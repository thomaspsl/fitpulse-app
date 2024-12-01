import 'package:fitpulse_app/presentation/screens/profile/index.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      centerTitle: true,

      //Left part
      /*leading: GestureDetector(
        onTap: () => {},
        child: Container(),
      ),*/

      //Center part
      title: GestureDetector(
        onTap: () => GoRouter.of(context).goNamed('programme.index'),
        child: Container(
          padding: const EdgeInsets.only(top: 5),
          child: SvgPicture.asset(
            'lib/assets/images/logo.svg',
            semanticsLabel: 'FitPulse Logo',
            height: 30,
          ),
        ),

      ),

      //Right part
      actions: [
        Container(
          padding: const EdgeInsets.only(top: 11, right: 20, bottom: 7),
          child: GestureDetector(
            onTap: () => {},
            child: Container(
              padding: const EdgeInsets.only(bottom: 2),
              child: Icon(
                Icons.circle,
                color: Theme.of(context).primaryColor,
                size: 32,
              ),
            ),
          ),
        )
      ],
    );
  }
}
