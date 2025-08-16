import '../export.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigation(),
    );
  }
}

List _views = const [
  Discover(),
  AppSearch(),
  Marketplace(),
  Profile(),
];
NavigationBar _bottomNavigation() => NavigationBar(destinations: [
      NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
      NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
      NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
      NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
    ]);
