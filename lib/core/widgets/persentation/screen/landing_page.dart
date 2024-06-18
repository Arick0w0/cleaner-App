import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mae_ban/core/constants/color.dart';
import 'package:mae_ban/core/widgets/persentation/bloc/landing_page_bloc.dart';

class LandingPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomNavItems;
  final List<Widget> bottomNavScreens;
  final int initialTabIndex;

  const LandingPage({
    required this.bottomNavItems,
    required this.bottomNavScreens,
    this.initialTabIndex = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LandingPageBloc()..add(TabChange(tabIndex: initialTabIndex)),
      child: BlocConsumer<LandingPageBloc, LandingPageState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: IndexedStack(
                      index: state.tabIndex,
                      children: bottomNavScreens,
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: bottomNavItems,
              currentIndex: state.tabIndex,
              selectedItemColor: MColors.accent,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                BlocProvider.of<LandingPageBloc>(context)
                    .add(TabChange(tabIndex: index));
              },
            ),
          );
        },
      ),
    );
  }
}
