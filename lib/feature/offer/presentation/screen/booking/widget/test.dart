import 'package:flutter/material.dart';

class NoFadeTabBarView extends StatefulWidget {
  const NoFadeTabBarView({super.key, required this.children});

  final List<Widget> children;

  @override
  State<NoFadeTabBarView> createState() => _NoFadeTabBarViewState();
}

class _NoFadeTabBarViewState extends State<NoFadeTabBarView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = DefaultTabController.of(context);
    controller!.animation!.addListener(() {
      if (controller.indexIsChanging) {
        _pageController.jumpToPage(controller.index);
      }
    });
    return PageView(
      controller: _pageController,
      children: widget.children,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
