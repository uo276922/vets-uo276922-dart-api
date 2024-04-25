import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:vets_uo276922_dart_api/models/vet.dart';
import 'package:vets_uo276922_dart_api/repositories/vet_repository.dart';
import 'package:mongo_dart/mongo_dart.dart';

final vetRouter = Router()
  ..get('/vets', _vetsHandler)
  ..post('/vets/create', _vetsCreateHandler)
  ..get('/vets/<id>', _getVetHandler);

Future<Response> _vetsHandler(Request request) async {
  final users = await VetsRepository.findAll();
  return Response.ok(json.encode(users));
}

Future<Response> _getVetHandler(Request request) async {
  dynamic vetId = ObjectId.fromHexString(request.params['id'].toString());
  final users = await VetsRepository.findOne({"_id": vetId});
  return Response.ok(json.encode(users));
}

Future<Response> _vetsCreateHandler(Request request) async {
  print("entra");
  final vetRequestBody = await request.readAsString();
  final vet = Vet.fromJson(json.decode(vetRequestBody));
  final List<Map<String, String>> vetValidateErrors = await validateVet(vet);
  dynamic vetCreated;
  if (vetValidateErrors.isEmpty) {
    vetCreated = await VetsRepository.insertOne(vet);
// if hubo un error al insertar el registro
    if (vetCreated.containsKey("error")) vetValidateErrors.add(vetCreated);
  }
  if (vetValidateErrors.isNotEmpty) {
    final encodedError = jsonEncode(vetValidateErrors);
    return Response.badRequest(
        body: encodedError, headers: {'content-type': 'application/json'});
  } else {
    return Response.ok('Clinica creado correctamente $vetCreated');
  }
}

validateVet(Vet vet) async {
  List<Map<String, String>> errors = [];
  final vetFound = await VetsRepository.findOne({"name": vet.name});
  if (vetFound != null) {
    errors.add({"name": "The vet already exist with this name"});
  }
  if (vet.name.isEmpty) {
    errors.add({"name": "Name is a required field"});
  }
  if (vet.photo.isEmpty) {
    errors.add({"photo": "Photo is a required field"});
  }
  if (vet.address.isEmpty) {
    errors.add({"address": "Address is a required field"});
  }
  if (vet.email.isEmpty) {
    errors.add({"email": "Email is a required field"});
  }
  if (vet.phone.isEmpty) {
    errors.add({"phone": "Phone is a required field"});
  }
  if (vet.website.isEmpty) {
    errors.add({"web_site": "Web site is a required field"});
  }
  return errors;
}
