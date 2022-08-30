import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tradebook/adminScreens/adminHomeScreen.dart';
import 'package:tradebook/view/modules/mainScreens/sectionScreen/sectionsScreen.dart';
import 'package:tradebook/view/modules/mainScreens/subscriptionScreen/subscriptionScreen.dart';
import 'package:tradebook/view/modules/settingsScreen/settingsScreen.dart';
import 'package:tradebook/widgets/components.dart';
import 'package:tradebook/widgets/constants/appBrain.dart';

import '../modules/mainScreens/jobScreen/jobsScreen.dart';
import '../modules/mainScreens/showcaseScreen/showcaseScreen.dart';
import '../modules/userProfileScreen/userProfileScreen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int access = 0;
  int _index = 0;
  final List _screens = [
    const SectionsScreen(),
    const ShowcaseScreen(),
    const SubscriptionScreen(),
    const JobsScreen(),
  ];

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.purple,
                    Colors.deepPurple,
                  ],
                ),
              ),
              child: CircleAvatar(
                child: Image.network(
                  avatarPlaceholderURL,
                ),
              ),
            ),
            defaultListTile(
              onTap: () {
                Navigator.pop(context);
                Get.to(() => const UserProfileScreen());
              },
              leadingIcon: FontAwesomeIcons.user,
              leadingIconColor: Colors.purple,
              title: 'User Profile',
              trailingIcon: Icons.arrow_right,
              trailingIconColor: Colors.purple,
            ),
            defaultListTile(
              onTap: () {},
              leadingIcon: FontAwesomeIcons.bell,
              leadingIconColor: Colors.purple,
              title: 'Notifications',
              trailingIcon: Icons.arrow_right,
              trailingIconColor: Colors.purple,
            ),
            defaultListTile(
              onTap: () {
                Get.to(() => const SettingsScreen());
              },
              leadingIcon: Icons.settings,
              leadingIconColor: Colors.blue,
              title: 'Settings',
              trailingIcon: Icons.arrow_right,
              trailingIconColor: Colors.purple,
            ),
            defaultListTile(
              onTap: () {},
              leadingIcon: FontAwesomeIcons.signOutAlt,
              leadingIconColor: Colors.red,
              title: 'Sign Out',
              trailingIcon: Icons.arrow_right,
              trailingIconColor: Colors.purple,
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 50.0,
                left: 30,
                right: 15.0,
              ),
              child: ListTile(
                onTap: () {
                  access++;

                  if (access == 5) {
                    access = 0;
                    Navigator.pop(context);
                    Get.to(() => const AdminHomeScreen());
                  }
                  print(access);
                },
                leading: const CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(
                    'assets/images/appstore.png',
                  ),
                ),
                title: Text(
                  'Trade Book',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          height: height,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  'assets/images/screenTopShape.png',
                  width: width,
                ),
              ),
              _screens[_index],
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  drawerButton(
                    onTap: () {
                      setState(() {
                        scaffoldKey.currentState?.openDrawer();
                      });
                    },
                    iconColor: Colors.white,
                  ),
                  drawerButton(
                    onTap: () {
                      setState(() {
                        scaffoldKey.currentState?.openEndDrawer();
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        backgroundColor: Colors.white,
        color: Colors.purple,
        height: 50,
        animationDuration: const Duration(microseconds: 200),
        items: [
          bottomNavItemIcon(
            icon: Icons.home,
          ),
          bottomNavItemIcon(
            icon: FontAwesomeIcons.windows,
          ),
          bottomNavItemIcon(
            icon: Icons.subscriptions,
          ),
          bottomNavItemIcon(
            icon: Icons.work,
          ),
        ],
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }

  Widget drawerButton({
    required VoidCallback onTap,
    Color? iconColor,
  }) =>
      Padding(
        padding: const EdgeInsets.only(top: 28.0),
        child: IconButton(
          onPressed: onTap,
          icon: Icon(
            Icons.menu,
            color: iconColor,
          ),
        ),
      );

  Widget bottomNavItemIcon({
    required IconData icon,
  }) =>
      Icon(
        icon,
        color: Colors.white,
        size: 30.0,
      );
}
