import 'package:flutter/material.dart';

class NavBarWidget extends StatelessWidget {
  const NavBarWidget({
    super.key,
    required this.pageIndex,
    required this.onTap,
  });

  final int pageIndex;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0.0,
      color: Colors.black,
      padding: EdgeInsets.zero,
      height: 60,
      child: Container(
        width: double.infinity,
        color: Colors.blue,
        child: Row(
          children: [
            NavItemWidget(
              icon: Icons.account_balance_wallet,
              isSelected: pageIndex == 0,
              onTap: () => onTap(0),
            ),
            const Spacer(),
            const Spacer(),
            const Spacer()
          ],
        ),
      ),
    );
  }
}

class NavItemWidget extends StatelessWidget {
  const NavItemWidget({
    super.key,
    required this.icon,
    required this.isSelected,
    this.onTap,
  });

  final IconData icon;
  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.4),
        ),
      ),
    );
  }
}
