class RateLimitConfig {
  // Configurações de rate limiting para a API do Spotify
  static const int maxRequestsPerMinute = 30;
  static const Duration requestCooldown = Duration(milliseconds: 2000);
  static const int maxRetries = 3;
  static const Duration baseRetryDelay = Duration(seconds: 2);
  
  // Configurações de busca
  static const Duration searchDebounceDelay = Duration(milliseconds: 500);
  static const int maxSearchResults = 5;
  
  // Configurações de timeout
  static const Duration requestTimeout = Duration(seconds: 30);
  
  // Mensagens de feedback
  static const String rateLimitMessage = 'Muitas requisições. Aguardando...';
  static const String searchMessage = 'Buscando artistas...';
  static const String searchSubMessage = 'Isso pode levar alguns segundos';
  static const String errorMessage = 'Erro na busca. Tente novamente.';
}
