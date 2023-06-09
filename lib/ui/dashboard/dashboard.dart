import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:humble/ui/chat/chats_page.dart';
import 'package:humble/ui/home/home_page.dart';
import 'package:humble/ui/profile/account_page.dart';

class Dashboard extends HookWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final index = useState(0);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: index.value,
        onDestinationSelected: (value) {
          index.value = value;
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.favorite),
            icon: Icon(Icons.favorite_outline_rounded),
            label: 'Explore',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.chat_bubble_rounded),
            icon: Icon(Icons.chat_bubble_outline_rounded),
            label: 'Chat',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.account_circle),
            icon: Icon(Icons.account_circle_outlined),
            label: 'Account',
          ),
        ],
      ),
      body: [
        const HomePage(),
        const ChatsPage(),
        const AccountPage(),
      ][index.value],
      
    );
  }
}
