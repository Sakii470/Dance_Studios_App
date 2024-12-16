// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mimiqit_app/l10n/generated/l10n.dart';
import 'package:mimiqit_app/di/service_locator.dart';
import 'package:mimiqit_app/presentation/bloc/dance_studio_event.dart';
import 'package:mimiqit_app/themes/app_theme.dart';
import 'package:mimiqit_app/presentation/bloc/dance_studio_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimiqit_app/presentation/bloc/dance_studio_state.dart';
import 'package:mimiqit_app/presentation/pages/dance_studio_list_page.dart';
import 'package:mimiqit_app/presentation/pages/dance_studio_map_page.dart';
import 'package:mimiqit_app/presentation/dance_studio_details_view.dart';
import 'package:mimiqit_app/presentation/widgets/app_bottom_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupServiceLocator(); // Initialize GetIt
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DanceStudioBloc>(
      create: (_) => getIt<DanceStudioBloc>()..add(FetchDanceStudios()),
      child: MaterialApp(
        title: 'Dance Studios', // Initial title before localization
        theme: AppTheme.darkTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        localizationsDelegates: const [
          S.delegate, // Delegat wygenerowany przez intl_utils
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/details': (context) => const DanceStudioDetailsView(),
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const DanceStudioListPage(),
      const DanceStudioMapPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DanceStudioBloc, DanceStudioState>(
      builder: (context, state) {
        int currentIndex = 0; // Default to "Studios" tab

        if (state is DanceStudioLoaded) {
          currentIndex = state.currentIndex;
        }

        // Determine AppBar title based on currentIndex
        String appBarTitle =
        currentIndex == 0 ? S.of(context).appTitle : S.of(context).appTitleMap;

        // Determine if back button should be shown
        bool showBackButton = currentIndex == 1;

        return Scaffold(
          appBar: AppBar(
            title: Text(appBarTitle),
            leading: showBackButton
                ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                // Switch back to "Studios" tab when back arrow is pressed
                context.read<DanceStudioBloc>().add(ChangeTab(0));
              },
            )
                : null,
          ),
          body: _pages[currentIndex],
          bottomNavigationBar: AppBottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              if (index != currentIndex) {
                context.read<DanceStudioBloc>().add(ChangeTab(index));
              }
            },
          ),
        );
      },
    );
  }
}
