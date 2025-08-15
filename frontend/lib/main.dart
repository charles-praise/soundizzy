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
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Loading .....')));
        } else if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, '/view');
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${state.error}, please login')));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
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
        );
      },
    );
  }
}
