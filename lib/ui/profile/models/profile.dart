import 'package:appwrite/models.dart';
import 'package:flutter/foundation.dart';

import '../../../core/utils/interests.dart';

class Profile {
  final String id;
  final String name;
  final String occupation;
  final String location;
  final String? description;
  final String email;
  final DateTime? dateOfBirth;
  final List<String> interests;
  final String? image;

  const Profile({
    this.id = '',
    this.name = '',
    this.occupation = '',
    this.location = '',
    this.description,
    this.email = '',
    this.dateOfBirth,
    this.interests = const [],
    this.image,
  });

  Profile copyWith({
    String? id,
    String? name,
    String? occupation,
    String? location,
    String? description,
    String? email,
    DateTime? dateOfBirth,
    List<String>? interests,
    String? image,
  }) {
    return Profile(
      id: id ?? this.id,
      name: name ?? this.name,
      occupation: occupation ?? this.occupation,
      location: location ?? this.location,
      description: description ?? this.description,
      email: email ?? this.email,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      interests: interests ?? this.interests,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    for (var key in Interests.data.keys) {
      if (interests.contains(key)) {
        map[key] = 'yes';
      }
    }
    return {
      'name': name,
      'occupation': occupation,
      'location': location,
      'description': description,
      'email': email,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'image': image,
      ...map,
    };
  }

  factory Profile.fromDocument(Document doc) {
    final map = doc.data;
    List<String> interests = [];
    for (var key in Interests.data.keys) {
      if (map[key] == 'yes') {
        interests.add(key);
      }
    }
    return Profile(
      id: doc.$id,
      name: map['name'] ?? '',
      occupation: map['occupation'] ?? '',
      location: map['location'] ?? '',
      description: map['description'],
      email: map['email'] ?? '',
      dateOfBirth: DateTime.tryParse(map['dateOfBirth']),
      interests: interests,
      image: map['image'],
    );
  }

  @override
  String toString() {
    return 'Profile(id: $id, name: $name, occupation: $occupation, location: $location, description: $description, email: $email, dateOfBirth: $dateOfBirth, interests: $interests, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Profile &&
        other.id == id &&
        other.name == name &&
        other.occupation == occupation &&
        other.location == location &&
        other.description == description &&
        other.email == email &&
        other.dateOfBirth == dateOfBirth &&
        listEquals(other.interests, interests) &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        occupation.hashCode ^
        location.hashCode ^
        description.hashCode ^
        email.hashCode ^
        dateOfBirth.hashCode ^
        interests.hashCode ^
        image.hashCode;
  }
}
