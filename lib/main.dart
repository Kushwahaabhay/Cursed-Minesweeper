import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'audio_manager.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize audio manager
  await AudioManager.instance.initialize();
  
  // Set preferred orientations (portrait for better UX on phones)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  
  runApp(const CursedMinesweeperApp());
}

class CursedMinesweeperApp extends StatelessWidget {
  const CursedMinesweeperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AudioManager.instance,
      child: MaterialApp(
        title: 'Cursed Minesweeper',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Retro dark theme
          brightness: Brightness.dark,
          primaryColor: const Color(0xFF00FF00), // Retro green
          scaffoldBackgroundColor: const Color(0xFF0a0a0a),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFF00FF00),
            secondary: Color(0xFFFF00FF),
            surface: Color(0xFF1a1a1a),
            background: Color(0xFF0a0a0a),
          ),
          
          // Pixel font for all text
          textTheme: GoogleFonts.pressStart2pTextTheme(
            ThemeData.dark().textTheme,
          ).apply(
            bodyColor: const Color(0xFF00FF00),
            displayColor: const Color(0xFF00FF00),
          ),
          
          // Elevated button style (retro chunky buttons)
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1a1a1a),
              foregroundColor: const Color(0xFF00FF00),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: const BorderSide(color: Color(0xFF00FF00), width: 2),
              ),
              textStyle: GoogleFonts.pressStart2p(fontSize: 12),
            ),
          ),
          
          // Card style
          cardTheme: CardThemeData(
            color: const Color(0xFF1a1a1a),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: const BorderSide(color: Color(0xFF00FF00), width: 2),
            ),
          ),
          
          // AppBar style
          appBarTheme: AppBarTheme(
            backgroundColor: const Color(0xFF0a0a0a),
            foregroundColor: const Color(0xFF00FF00),
            elevation: 0,
            centerTitle: true,
            titleTextStyle: GoogleFonts.pressStart2p(
              fontSize: 16,
              color: const Color(0xFF00FF00),
            ),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
