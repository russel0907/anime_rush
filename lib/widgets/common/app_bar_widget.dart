import 'package:flutter/material.dart';
import '../../config/theme.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final Widget? bottom;
  final bool showAvatar;

  const AppBarWidget({
    super.key,
    this.actions,
    this.bottom,
    this.showAvatar = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom != null ? 80.0 : 0),
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.navBarDark,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/images/icon-2.png'),
      ),
      actions: actions ??
          (showAvatar
              ? [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                      child: const CircleAvatar(
                        radius: 20.0,
                        backgroundImage:
                            AssetImage('assets/images/circle-avatar.png'),
                      ),
                    ),
                  ),
                ]
              : []),
      title: const SizedBox.shrink(),
      bottom: bottom != null
          ? PreferredSize(
              preferredSize: const Size.fromHeight(80.0),
              child: bottom!,
            )
          : null,
    );
  }
}
