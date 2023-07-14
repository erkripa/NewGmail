import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:new_gmail/modules/home/components/scroll_to_hide.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController scrollController;
  int _currentIndex = 0;
  bool _isVisibleFloat = true;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(listener);

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void listener() {
    final direction = scrollController.position
        .userScrollDirection; // here we can use max scroll to achive after 200 pixcel it will hide bottom nav bar
    if (direction == ScrollDirection.forward) {
      showBootomNav();
    } else if (direction == ScrollDirection.reverse) {
      hideBottomNav();
    }
  }

  void showBootomNav() {
    if (!_isVisibleFloat) {
      setState(() => _isVisibleFloat = true);
    }
  }

  void hideBottomNav() {
    if (_isVisibleFloat) {
      setState(() => _isVisibleFloat = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Gmail"),
        leading: const Icon(Icons.menu),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeTab(scrollController: scrollController),
          const Scaffold(body: Center(child: Text("Second Tab"))),
          const Scaffold(body: Center(child: Text("Third Tab")))
        ],
      ),
      bottomNavigationBar: ScrollHide(
        scrollController: scrollController,
        child: SafeArea(
          child: NavigationBar(
            backgroundColor: const Color(0xFFF2F6F3),
            indicatorColor: const Color(0xFFB9F0CB),
            selectedIndex: 0,
            onDestinationSelected: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: const <NavigationDestination>[
              NavigationDestination(
                selectedIcon: Icon(Icons.window),
                icon: Icon(Icons.window_outlined),
                label: 'Home',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.search),
                icon: Icon(Icons.search_outlined),
                label: '',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.person),
                icon: Icon(Icons.person_outline),
                label: '',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _isVisibleFloat
          ? FloatingActionButton.extended(
              onPressed: () {},
              label: const Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(width: 10),
                  Text("Compose"),
                ],
              ))
          : FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.edit),
            ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              controller: scrollController,
              itemCount: 100,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Title $index"),
                  subtitle: Text("SubTitle $index"),
                  trailing: const Icon(Icons.star_border_outlined),
                );
              }),
        ),
      ],
    );
  }
}
