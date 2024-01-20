// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// class UsersList {
//   List<User> users;
//   UsersList({required this.users});
//
//   factory UsersList.fromJson(List<dynamic> json) {
//     // var postsJson = json['posts'] as List;
//
//     List<User> usersList = json.map((i) => User.fromJson(i)).toList();
//
//     return UsersList(
//       users: usersList,
//     );
//   }
// }
//
// class User {
//   final int id;
//   final String name;
//   final String username;
//   final String email;
//   final Address address;
//   final String phone;
//   final String website;
//   final Company company;
//
//   User({
//     required this.id,
//     required this.name,
//     required this.username,
//     required this.email,
//     required this.address,
//     required this.phone,
//     required this.website,
//     required this.company,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'] as int,
//       name: json['name'] as String,
//       username: json['username'] as String,
//       email: json['email'] as String,
//       address: Address.fromJson(json['address']),
//       phone: json['phone'] as String,
//       website: json['website'] as String,
//       company: Company.fromJson(json['company']),
//     );
//   }
// }
//
// class Address {
//   final String street;
//   final String suite;
//   final String city;
//   final String zipcode;
//   final LatLng geo;
//
//   Address({
//     required this.street,
//     required this.suite,
//     required this.city,
//     required this.zipcode,
//     required this.geo,
//   });
//
//   factory Address.fromJson(Map<String, dynamic> json) {
//     return Address(
//       street: json['street'] as String,
//       suite: json['suite'] as String,
//       city: json['city'] as String,
//       zipcode: json['zipcode'] as String,
//       geo: LatLng.fromJson(json['geo']),
//     );
//   }
// }
//
// class LatLng {
//   final double lat;
//   final double lng;
//
//   LatLng({
//     required this.lat,
//     required this.lng,
//   });
//
//   factory LatLng.fromJson(Map<String, dynamic> json) {
//     return LatLng(
//       lat: json['lat'] as double,
//       lng: json['lng'] as double,
//     );
//   }
// }
//
// class Company {
//   final String name;
//   final String catchPhrase;
//   final String bs;
//
//   Company({
//     required this.name,
//     required this.catchPhrase,
//     required this.bs,
//   });
//
//   factory Company.fromJson(Map<String, dynamic> json) {
//     return Company(
//       name: json['name'] as String,
//       catchPhrase: json['catchPhrase'] as String,
//       bs: json['bs'] as String,
//     );
//   }
// }
//
// Future<UsersList> getUsersList() async {
//   const url = 'https://jsonplaceholder.typicode.com/users';
//   final response = await http.get(Uri.parse(url));
//
//   if (response.statusCode == 200) {
//     return UsersList.fromJson(json.decode(response.body));
//   } else {
//     throw Exception('Error: ${response.reasonPhrase}');
//   }
// }

import 'dart:convert';

import 'package:http/http.dart' as http;

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final Address address;
  final String phone;
  final String website;
  final Company company;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      address: Address.fromJson(json['address']),
      phone: json['phone'] as String,
      website: json['website'] as String,
      company: Company.fromJson(json['company']),
    );
  }
}

class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo geo;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] as String,
      suite: json['suite'] as String,
      city: json['city'] as String,
      zipcode: json['zipcode'] as String,
      geo: Geo.fromJson(json['geo']),
    );
  }
}

class Geo {
  final String lat;
  final String lng;

  Geo({
    required this.lat,
    required this.lng,
  });

  factory Geo.fromJson(Map<String, dynamic> json) {
    return Geo(
      lat: json['lat'] as String,
      lng: json['lng'] as String,
    );
  }
}

class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'] as String,
      catchPhrase: json['catchPhrase'] as String,
      bs: json['bs'] as String,
    );
  }
}

Future<List<User>> getUsersList() async {
  final url = 'https://jsonplaceholder.typicode.com/users';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    Iterable jsonResponse = json.decode(response.body);
    List<User> users = [
      for (var userJson in jsonResponse) User.fromJson(userJson)
    ];
    return users;
  } else {
    throw Exception(
        "Failed to load users. Status code: ${response.statusCode}, Reason: ${response.reasonPhrase}");
  }
}
