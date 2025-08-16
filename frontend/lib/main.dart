import 'export.dart';

void main(List<String> args) {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => UploadCubit()),
      ],
      child: const Soundizzy(),
    ),
  );
}

// ----------- Soundizzy (Main) ----------------
class Soundizzy extends StatelessWidget {
  const Soundizzy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soundizzy',
      color: AppColors.transparentBackground,
      routes: {
        '/discover': (context) => const Discover(),
        '/marketplace': (context) => const Marketplace(),
        '/search': (context) => const AppSearch(),
        'profile': (context) => const Profile(),
        '/view': (context) => const AppView(),
      },
      theme: AppTheme.lightTheme,
      home: SafeArea(child: const Splash()),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ---------- Splash screen -----------
class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            print('success');
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  'Soundizzy initializing .....',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ),
            LinearProgressIndicator(
              minHeight: 10,
              color: AppColors.LinearProgressIndicatorLightMode,
            )
          ],
        ),
      ),
    );
  }
}
