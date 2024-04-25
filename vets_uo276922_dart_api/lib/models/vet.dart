import 'package:bson/bson.dart';

class Vet {
  late ObjectId? id;
  String placeId;
  Location location;
  String name;
  bool openNow;
  String photo;
  int rating;
  String address;
  List<String> services;
  String email;
  String phone;
  String website;

  Vet(
      this.id,
      this.placeId,
      this.location,
      this.name,
      this.openNow,
      this.photo,
      this.rating,
      this.address,
      this.services,
      this.email,
      this.phone,
      this.website);

  Vet.forInsert(
      this.placeId,
      this.name,
      this.address,
      this.email,
      this.phone,
      this.services,
      this.website,
      this.location,
      this.openNow,
      this.photo,
      this.rating);
  Map<String, dynamic> toJsonInsert() => {
        'place_id': placeId,
        'name': name,
        'address': address,
        'email': email,
        'phone': phone,
        'services': services,
        'web_site': website,
        'location': location.toJson(),
        'open_now': openNow,
        'photo': photo,
        'rating': rating,
      };
  Map<String, dynamic> toJson() => {
        '_id': id,
        'place_id': placeId,
        'location': location.toJson(),
        'name': name,
        'open_now': openNow,
        'photo': photo,
        'rating': rating,
        'address': address,
        'services': services,
        'email': email,
        'phone': phone,
        'web_site': website
      };

  static Vet fromJson(Map<String, dynamic> json) => Vet(
        json.containsKey('_id') ? ObjectId.fromHexString(json['_id']) : null,
        json['place_id'],
        Location.fromJson(json['location']),
        json['name'],
        json['open_now'],
        json['photo'],
        json['rating'],
        json['address'],
        List<String>.from(json['services']),
        json['email'],
        json['phone'],
        json['web_site'],
      );
}

class Location {
  double lat;
  double lng;

  Location(this.lat, this.lng);

  Map<String, dynamic> toJson() => {'lat': lat, 'lng': lng};

  static Location fromJson(Map<String, dynamic> json) =>
      Location(json['lat'], json['lng']);
}
