import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

class DebugConfig {
  static bool _isInitialized = false;
  
  // Configurar logs para reduzir spam
  static void initialize() {
    if (_isInitialized) return;
    
    if (kDebugMode) {
      // Configurar filtros de log para reduzir spam
      developer.log(
        'DebugConfig inicializado - filtrando logs do DebugService',
        name: 'DebugConfig',
      );
    }
    
    _isInitialized = true;
  }
  
  // Filtrar logs específicos
  static void log(String message, {String? name, Object? error}) {
    if (kDebugMode) {
      // Filtrar mensagens do DebugService
      if (message.contains('DebugService') || 
          message.contains('Cannot send Null') ||
          (error?.toString().contains('DebugService') ?? false)) {
        return; // Não logar esses erros
      }
      
      developer.log(message, name: name ?? 'App', error: error);
    }
  }
  
  // Log de erro filtrado
  static void logError(String message, Object error) {
    if (kDebugMode) {
      if (error.toString().contains('DebugService') ||
          error.toString().contains('Cannot send Null')) {
        return; // Não logar esses erros
      }
      
      developer.log(
        message,
        name: 'Error',
        error: error,
        level: 1000, // Nível de erro
      );
    }
  }
}
