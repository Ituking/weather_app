import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Dioインスタンスを提供するProvider
// このProviderは、天気予報APIの通信に使用されるDioクライアントを提供します。
// DioはHTTPクライアントライブラリで、APIとの通信を効率的に行うための機能を提供します。
final dioProvider = Provider<Dio>((ref) {
  return Dio();
});
