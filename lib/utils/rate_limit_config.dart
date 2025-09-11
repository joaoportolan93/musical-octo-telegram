class RateLimitConfig {
  // Configurações de rate limiting para a API do Spotify
  static const int maxRequestsPerMinute = 60; // aumentar throughput
  static const Duration requestCooldown = Duration(milliseconds: 400); // reduzir cooldown entre requests
  static const int maxRetries = 3;
  static const Duration baseRetryDelay = Duration(seconds: 2);
  
  // Configurações de busca
  static const Duration searchDebounceDelay = Duration(milliseconds: 300);
  static const int maxSearchResults = 8;
  
  // Configurações de timeout
  static const Duration requestTimeout = Duration(seconds: 12);
  
  // Mensagens de feedback
  static const String rateLimitMessage = 'Muitas requisições. Aguardando...';
  static const String searchMessage = 'Buscando artistas...';
  static const String searchSubMessage = 'Isso pode levar alguns segundos';
  static const String errorMessage = 'Erro na busca. Tente novamente.';
}
