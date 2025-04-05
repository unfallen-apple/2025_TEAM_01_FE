import 'dart:convert';
import 'package:http/http.dart' as http;
import './token_storage.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';
import '../dto/LoginResponse.dart';
import '../dto/RegisterResponse.dart';



class ApiService {
  static const String baseUrl = 'https://juhhoho.xyz/api';
  final TokenStorage _tokenStorage = TokenStorage();

  // Username check
  Future<bool> checkUsername(String username) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username}),
    );

    return response.statusCode == 200;
  }

  // Register
  Future<RegisterResponse> register({
    required String username,
    required String password,
    required String nickname,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'nickname': nickname
      }),
    );
    final body = jsonDecode(response.body);
    final responseData = body['response'];

    if (response.statusCode == 200){
      return RegisterResponse(
        isSuccess: true,
        username: responseData['username'],
        password: responseData['password'],
        nickname: responseData['nickname'],
      );
    }
    else{
      return RegisterResponse(
          isSuccess: false
      );
    }
  }

  // Login
  Future<LoginResponse> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Save access token from header
      final accessToken = response.headers['access'];

      if (accessToken != null) {
        await _tokenStorage.saveAccessToken(accessToken);
      }

      // Save refresh token from cookies
      final cookies = response.headers['set-cookie'];
      if (cookies != null) {
        final refreshToken = _extractRefreshTokenFromCookie(cookies);
        if (refreshToken != null) {
          await _tokenStorage.saveRefreshToken(refreshToken);
        }
      }

      final body = jsonDecode(response.body);
      final responseData = body['response'];

      return LoginResponse(
        isSuccess: true,
        userId: responseData['userId'],
        nickname: responseData['nickname'],
      );
    }
    return LoginResponse(isSuccess: false);
  }

  String? _extractRefreshTokenFromCookie(String cookies) {
    final refreshCookie = cookies.split('; ').firstWhere(
          (cookie) => cookie.startsWith('refresh='),
      orElse: () => '',
    );
    return refreshCookie.isNotEmpty ? refreshCookie.split('=')[1] : null;
  }

  // Token reissue
  Future<bool> reissueTokens() async {
    final accessToken = await _tokenStorage.getAccessToken();
    final refreshToken = await _tokenStorage.getRefreshToken();

    if (accessToken == null || refreshToken == null) {
      return false;
    }

    final response = await http.post(
      Uri.parse('$baseUrl/reissue'),
      headers: {
        'Content-Type': 'application/json',
        'access': accessToken,
        'Cookie': 'refresh=$refreshToken',
      },
    );

    if (response.statusCode == 200) {
      // Update tokens
      final newAccessToken = response.headers['access'];
      final cookies = response.headers['set-cookie'];

      if (newAccessToken != null) {
        await _tokenStorage.saveAccessToken(newAccessToken);
      }
      if (cookies != null) {
        final newRefreshToken = _extractRefreshTokenFromCookie(cookies);
        if (newRefreshToken != null) {
          await _tokenStorage.saveRefreshToken(newRefreshToken);
        }
      }
      return true;
    }
    return false;
  }

  // Authenticated request helper
  // Get Rankings
  Future<Map<String, dynamic>> getRankings() async {
    final response = await authenticatedRequest(
      'GET',
      '/rankings',
    );
    return jsonDecode(utf8.decode(response.bodyBytes))['response'];
  }

  Future<Map<String, dynamic>> getProgressInfo(int? userId, double latitude, double longitude) async {
    print("??????");
    print(latitude);
    print(longitude);
    final uri = Uri.parse('/progress/users/$userId').replace(queryParameters: {
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
    });

    final response = await authenticatedRequest(
      'GET',
      uri.toString(),
    );

    return jsonDecode(utf8.decode(response.bodyBytes))['response'];
  }


  // 확장자별 Content-Type 매핑
  String getContentType(String extension) {
    switch (extension.toLowerCase()) {
      case 'png':
        return 'image/png';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'gif':
        return 'image/gif';
      case 'bmp':
        return 'image/bmp';
      case 'webp':
        return 'image/webp';
      case 'tiff':
        return 'image/tiff';
      case 'svg':
        return 'image/svg+xml';
      default:
        return 'application/octet-stream'; // 알 수 없는 확장자일 경우 기본값
    }
  }

  Future<Map<String, dynamic>> uploadImage(File image) async {
    // 파일 이름과 확장자 추출
    String fileName = image.uri.pathSegments.last; // 원본 파일 이름
    String extension = fileName.split('.').last; // 확장자 추출

    // UUID 기반 파일명 생성
    var uuid = Uuid();
    String uniqueFileName = "${uuid.v4()}_$fileName";

    print("unique");
    print(uniqueFileName);

    // Presigned URL 요청 (쿼리 파라미터로 uniqueFileName 추가)
    Uri url = Uri.parse('/presignedUrl/upload')
        .replace(queryParameters: {'imageName': uniqueFileName}); // 쿼리 파라미터 추가

    final response = await authenticatedRequest(
      'GET',
      url.toString(), // URL을 문자열로 전달
    );

    final responseData = jsonDecode(utf8.decode(response.bodyBytes));
    String presignedUrl = responseData['response']['presignedUrl'];

    // Presigned URL로 이미지 업로드 (PUT 요청)
    final putResponse = await http.put(
      Uri.parse(presignedUrl),
      body: await image.readAsBytes(),
      headers: {
        'Content-Type': getContentType(extension), // 확장자에 맞는 Content-Type 설정
      },
    );

    if (putResponse.statusCode != 200) {
      throw Exception('이미지 업로드 실패: ${putResponse.statusCode}');
    }

    // 업로드된 이미지 URL 반환
    return {'uploadedUrl': presignedUrl.split('?')[0]};
  }


  // 퀘스트 제출
  Future<Map<String, dynamic>> submitQuestWithImages(String landmarkName, String stdUrl, String clientUrl) async {
    print("KKKKKKKKKKKKKKKKk");
    print(landmarkName);
    print(clientUrl);
    print(stdUrl);
    final response = await authenticatedRequest(
      'POST',
      '/landmarks/$landmarkName/quest',
      body: jsonEncode({'stdUrl': stdUrl, 'clientUrl': clientUrl}),
    );
    print(response);

    if (response.statusCode != 401 || response.statusCode != 403) {
      print("?????");
      print(jsonDecode(utf8.decode(response.bodyBytes))['response']['score']);
      return jsonDecode(utf8.decode(response.bodyBytes))['response'];
    } else {
      throw Exception('Failed to submit quest');
    }
  }



  Future<http.Response> authenticatedRequest(
      String method,
      String path, {
        Map<String, String>? headers,
        Object? body,
      }) async {
    final accessToken = await _tokenStorage.getAccessToken();

    if (accessToken == null) {
      throw Exception('No access token available');
    }

    final requestHeaders = {
      'Content-Type': 'application/json',
      'access': accessToken,
      ...?headers,
    };

    http.Response response;
    final url = Uri.parse('$baseUrl$path');

    switch (method.toUpperCase()) {
      case 'GET':
        response = await http.get(url, headers: requestHeaders);
        break;
      case 'POST':
        response = await http.post(url, headers: requestHeaders, body: body);
        break;
      case 'PUT':
        response = await http.put(url, headers: requestHeaders, body: body);
        break;
      case 'DELETE':
        response = await http.delete(url, headers: requestHeaders);
        break;
      default:
        throw Exception('Unsupported HTTP method');
    }

    if (response.statusCode == 401) {
      print("token expired... reissue token");
      // Token expired, try to reissue
      final success = await reissueTokens();
      if (success) {
        // Retry the request with new token
        return authenticatedRequest(method, path, headers: headers, body: body);
      }
      throw Exception('Token reissue failed');
    }

    if (response.statusCode == 403) {
      throw Exception('Forbidden');
    }

    return response;
  }
// Future<http.Response> authenticatedRequest(
//     String method,
//     String path, {
//       Map<String, String>? headers,
//       Object? body,
//     }) async {
//   final accessToken = await _tokenStorage.getAccessToken();
//
//   if (accessToken == null) {
//     throw Exception('No access token available');
//   }
//
//   final requestHeaders = {
//     'Content-Type': 'application/json',
//     'access': accessToken,
//     ...?headers,
//   };
//
//   http.Response response;
//   final url = Uri.parse('$baseUrl$path');
//
//   switch (method.toUpperCase()) {
//     case 'GET':
//       response = await http.get(url, headers: requestHeaders);
//       break;
//     case 'POST':
//       response = await http.post(url, headers: requestHeaders, body: body);
//       break;
//     case 'PUT':
//       response = await http.put(url, headers: requestHeaders, body: body);
//       break;
//     case 'DELETE':
//       response = await http.delete(url, headers: requestHeaders);
//       break;
//     default:
//       throw Exception('Unsupported HTTP method');
//   }
//
//   if (response.statusCode == 401) {
//     // Token expired, try to reissue
//     final success = await reissueTokens();
//     if (success) {
//       // Retry the request with new token
//       return authenticatedRequest(method, path, headers: headers, body: body);
//     }
//     throw Exception('Token reissue failed');
//   }
//
//   if (response.statusCode == 403) {
//     throw Exception('Forbidden');
//   }
//
//   return response;
// }
}

class LoginResult {
  final bool isSuccess;
  final int? userId;
  final String? nickname;

  LoginResult({
    required this.isSuccess,
    this.userId,
    this.nickname,
  });
}
