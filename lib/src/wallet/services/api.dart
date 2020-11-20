import 'package:dio/dio.dart';
import 'package:expense_manager/src/commons/models/api_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIService {
  final Dio _dio;

  APIService(this._dio);

  void setHeaders(int userId, String authToken) async {
    final Map<String, dynamic> existingHeaders = _dio.options.headers;
    existingHeaders['Authorization'] = 'Bearer $authToken';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", existingHeaders['Authorization']);
    prefs.setInt("userId", userId);
  }

  Future<ApiResponse> makeRequest(final ApiRequestBuilder apiRequest) async {
    final String generalErrorMessage = "An error occurred, please wait a moment and try again";

    try {
      final Map<String, dynamic> existingHeaders = _dio.options.headers;
      apiRequest.headers.forEach((key, value) {
        existingHeaders[key] = value;
      });
      final Response response = await _dio.request(
        apiRequest.path,
        data: apiRequest.body,
        options: Options(
          method: apiRequest.method,
          headers: existingHeaders,
        ),
      );

//      print(response.statusCode);
//      print(response.data);

      if (response != null && response.data != null) {
        if (response.statusCode >= 200 && response.statusCode < 300) {
          if (apiRequest.path == "auth/login") {
            setHeaders(response.data['id'], response.data['access_token']);
          }
          return ApiResponse(successResponse: SuccessResponse(response.data, apiRequest));
        } else {
          return response.data.runtimeType == String
              ? ApiResponse(errorResponse: ErrorResponse(apiRequest, generalErrorMessage))
              : ApiResponse(errorResponse: ErrorResponse(apiRequest, response.data['message'] ?? generalErrorMessage));
        }
      } else {
        // Crashlytics.instance.log("API Error: ${response.data}");
        return ApiResponse(errorResponse: ErrorResponse(apiRequest, generalErrorMessage));
      }
    } on DioError catch (e) {
      // Crashlytics.instance.log("Network Exception: ${e.toString()} + ${e.response}");
      print(" Error + ${e.toString()} + ${e.response}");
      if (e.response != null) {
        if (e.type == DioErrorType.CONNECT_TIMEOUT) {
          return ApiResponse(errorResponse: ErrorResponse(apiRequest, "Connection timed out"),);
        }
        if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
          return ApiResponse(errorResponse: ErrorResponse(apiRequest, "Connection timed out"),);
        }
        return e.response.data.runtimeType == String
            ? ApiResponse(errorResponse: ErrorResponse(apiRequest, generalErrorMessage))
            : ApiResponse(errorResponse: ErrorResponse(apiRequest, e.response.data['message'] ?? generalErrorMessage));
      }
      return ApiResponse(errorResponse: ErrorResponse(apiRequest, generalErrorMessage),);
    }
  }
}
