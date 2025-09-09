import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/pokedex_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const PokedexMusicalApp());
}

class PokedexMusicalApp extends StatelessWidget {
  const PokedexMusicalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PokedexProvider(),
      child: MaterialApp(
        title: 'Pokedex Musical',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          primaryColor: Colors.red[600],
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.red[600],
            elevation: 0,
            centerTitle: true,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(),
            bodyMedium: TextStyle(),
            titleLarge: TextStyle(),
            titleMedium: TextStyle(),
            titleSmall: TextStyle(),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[600],
              foregroundColor: Colors.white,
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red[600]!),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
