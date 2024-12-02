import 'package:fitpulse_app/app/components/layouts/color_mapper.dart';
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

    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      centerTitle: true,

      // Center part
      title: GestureDetector(
        onTap: () => GoRouter.of(context).goNamed('programme.index'),
        child: Container(
          padding: const EdgeInsets.only(top: 5),
          child: SvgPicture(
            SvgAssetLoader(
                'lib/assets/images/logo.svg',
              colorMapper: SvgColorMapper(svgColor: color)
            )
          )
        ),
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
                Icons.circle,
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
