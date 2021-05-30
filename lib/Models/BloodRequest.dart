import 'dart:convert';

import 'package:flutter/cupertino.dart';

class BloodRequest {

  String medicalCenter;
  int bloodBags;
  String bloodGroup;
  String bloodType;
  String reason;
  String phoneNumber;
  String postedBy;
  String city;
  String userID;
  String userDp;
  int bloodBagsArranged; 

  
  BloodRequest({
    @required this.medicalCenter,
    @required this.bloodBags,
    @required this.bloodGroup,
    @required this.bloodType,
    @required this.reason,
    @required this.phoneNumber,
    @required this.postedBy,
    @required this.city,
    @required this.userID,
    @required this.userDp,
    @required this.bloodBagsArranged,
    
  });


  BloodRequest copyWith({
    String medicalCenter,
    int bloodBags,
    String bloodGroup,
    String bloodType,
    String reason,
    String phoneNumber,
    String postedBy,
    String city,
    String userID,
    String userDp,
    int bloodBagsArranged,
  }) {
    return BloodRequest(
      medicalCenter: medicalCenter ?? this.medicalCenter,
      bloodBags: bloodBags ?? this.bloodBags,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      bloodType: bloodType ?? this.bloodType,
      reason: reason ?? this.reason,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      postedBy: postedBy ?? this.postedBy,
      city: city ?? this.city,
      userID: userID ?? this.userID,
      userDp: userDp ?? this.userDp,
      bloodBagsArranged: bloodBagsArranged ?? this.bloodBagsArranged,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'medicalCenter': medicalCenter,
      'bloodBags': bloodBags,
      'bloodGroup': bloodGroup,
      'bloodType': bloodType,
      'reason': reason,
      'phoneNumber': phoneNumber,
      'postedBy': postedBy,
      'city': city,
      'userID': userID,
      'userDp': userDp,
      'bloodBagsArranged': bloodBagsArranged,
    };
  }

  factory BloodRequest.fromMap(Map<String, dynamic> map) {
    return BloodRequest(
      medicalCenter: map['medicalCenter'],
      bloodBags: map['bloodBags'],
      bloodGroup: map['bloodGroup'],
      bloodType: map['bloodType'],
      reason: map['reason'],
      phoneNumber: map['phoneNumber'],
      postedBy: map['postedBy'],
      city: map['city'],
      userID: map['userID'],
      userDp: map['userDp'],
      bloodBagsArranged: map['bloodBagsArranged'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BloodRequest.fromJson(String source) => BloodRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BloodRequest(medicalCenter: $medicalCenter, bloodBags: $bloodBags, bloodGroup: $bloodGroup, bloodType: $bloodType, reason: $reason, phoneNumber: $phoneNumber, postedBy: $postedBy, city: $city, userID: $userID, userDp: $userDp, bloodBagsArranged: $bloodBagsArranged)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BloodRequest &&
      other.medicalCenter == medicalCenter &&
      other.bloodBags == bloodBags &&
      other.bloodGroup == bloodGroup &&
      other.bloodType == bloodType &&
      other.reason == reason &&
      other.phoneNumber == phoneNumber &&
      other.postedBy == postedBy &&
      other.city == city &&
      other.userID == userID &&
      other.userDp == userDp &&
      other.bloodBagsArranged == bloodBagsArranged;
  }

  @override
  int get hashCode {
    return medicalCenter.hashCode ^
      bloodBags.hashCode ^
      bloodGroup.hashCode ^
      bloodType.hashCode ^
      reason.hashCode ^
      phoneNumber.hashCode ^
      postedBy.hashCode ^
      city.hashCode ^
      userID.hashCode ^
      userDp.hashCode ^
      bloodBagsArranged.hashCode;
  }
 }
