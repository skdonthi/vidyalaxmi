import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'api_service.g.dart';

@riverpod
Dio apiClient(Ref ref) {
  const gatewayUrl = String.fromEnvironment(
    'GATEWAY_URL',
    defaultValue: 'http://localhost:3000',
  );
  const aiEngineUrl = String.fromEnvironment(
    'AI_ENGINE_URL',
    defaultValue: 'http://localhost:8000',
  );

  final dio = Dio(BaseOptions(
    baseUrl: gatewayUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 30),
  ))
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = Supabase.instance.client.auth.currentSession?.accessToken;
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) {
          handler.next(error);
        },
      ),
    );

  return dio;
}

@riverpod
Dio aiEngineClient(Ref ref) {
  const aiEngineUrl = String.fromEnvironment(
    'AI_ENGINE_URL',
    defaultValue: 'http://localhost:8000',
  );

  return Dio(BaseOptions(
    baseUrl: aiEngineUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 60),
  ))
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = Supabase.instance.client.auth.currentSession?.accessToken;
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );
}
