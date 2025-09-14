import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'services/pokedex_provider.dart';
import 'screens/home_screen.dart';
import 'utils/debug_config.dart';

void main() {
  // Configurações para reduzir erros do DebugService
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar configurações de debug
  DebugConfig.initialize();
  
  // Suprimir logs específicos do DebugService
  if (kDebugMode) {
    // Redirecionar debugPrint para filtrar logs problemáticos
    debugPrint = (String? message, {int? wrapWidth}) {
      if (message != null && 
          !message.contains('DebugService') && 
          !message.contains('Cannot send Null') &&
          !message.contains('Error serving requests')) {
        print(message);
      }
    };
    
    // Configurar para reduzir spam de logs
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }
  
  runApp(const MelodyDexApp());
}

class MelodyDexApp extends StatelessWidget {
  const MelodyDexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PokedexProvider(),
      child: Consumer<PokedexProvider>(
        builder: (context, provider, _) => MaterialApp(
  title: 'MelodyDex',
        debugShowCheckedModeBanner: false,
        // Configurações para reduzir erros do DebugService
        builder: (context, child) {
          // Interceptar e filtrar erros de debug
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            // Filtrar erros específicos do DebugService
            if (errorDetails.exception.toString().contains('DebugService') ||
                errorDetails.exception.toString().contains('Cannot send Null')) {
              return const SizedBox.shrink(); // Não mostrar esses erros
            }
            return ErrorWidget(errorDetails.exception);
          };
          return child!;
        },
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
        darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF121212),
          colorScheme: const ColorScheme.dark().copyWith(
            primary: Colors.red[400],
            secondary: Colors.red[300],
            surface: const Color(0xFF1E1E1E),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.red[400],
            elevation: 0,
            centerTitle: true,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
        ),
        themeMode: provider.themeMode,
        home: const HomeScreen(),
      ),
      ),
    );
  }
}
