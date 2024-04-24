import 'package:shelf/shelf.dart';
import 'package:vets_uo276922_dart_api/user_token_service.dart' as jwt_service;
import 'dart:convert';

Middleware tokenValidatorMiddleware = (Handler innerHandler) {
  final excludedRoutes = ['users/login', 'users/signUp'];

  return (Request request) async {
    if (excludedRoutes.contains(request.url.path)) {
      return await innerHandler(request);
    }
    final dynamic token =
        request.headers.containsKey("token") ? request.headers["token"] : "";
    final Map<String, dynamic> verifiedToken =
        jwt_service.UserTokenService.verifyJwt(token);
    if (verifiedToken['authorized'] == false) {
      return Response.unauthorized(json.encode(verifiedToken));
    }
    return await innerHandler(request);
  };
};
