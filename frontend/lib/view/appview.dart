import '../export.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavigation(),
    );
  }
}

List views = const [
  Discover(),
  AppSearch(),
  Marketplace(),
  Profile(),
];
NavigationBar bottomNavigation() => NavigationBar(destinations: [
      NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
      NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
      NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
      NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
    ]);
