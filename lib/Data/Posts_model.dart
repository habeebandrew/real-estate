//posts + comments Model
import 'package:flutter/material.dart';
import 'package:pro_2/generated/l10n.dart';

class Post {
  final int id;
  final String userId;
  final String state;
  final String governorate;
  final String region;
  final int budget;
  final String description;
  final String mobilenumber;
  final String profileImage;
  final DateTime createdAt;
  Post({
    required this.id,
    required this.userId,
    required this.state,
    required this.governorate,
    required this.region,
    required this.budget,
    required this.description,
    required this.mobilenumber,
    required this.profileImage,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['user_name'], //user_id user_name
      state: json['state'],
      governorate: json['governorate'],
      region: json['region'],
      budget: json['budget'],
      description: json['description'],
      mobilenumber: json['mobilenumber'],
      profileImage: json['profile_image'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
  String translateState(BuildContext context) {
    switch (state) {
      case 'buy':
        return S.of(context).buy;
      case 'rental':
        return S.of(context).rental;
      default:
        return state;
    }
  }

  String translateGovernorate(BuildContext context) {
    switch (governorate) {
      case 'Damascus':
        return S.of(context).Damascus;
      case 'Rural Damascus':
        return S.of(context).Rural_Damascus;
      case 'Aleppo':
        return S.of(context).Aleppo;
      case 'Rural Aleppo':
        return S.of(context).Rural_Aleppo;
      case 'Homs':
        return S.of(context).Homs;
      case 'Rural Homs':
        return S.of(context).Rural_Homs;
      case 'Latakia':
        return S.of(context).Latakia;
      case 'Rural_Latakia':
        return S.of(context).Rural_Latakia;
      case 'Tartous':
        return S.of(context).Tartous;
      case 'Rural Tartous':
        return S.of(context).Rural_Tartous;
      case 'Hama':
        return S.of(context).Hama;
      case 'Rural Hama':
        return S.of(context).Rural_Hama;
      case 'Idlib':
        return S.of(context).Idlib;
      case 'Rural Idlib':
        return S.of(context).Rural_Idlib;
      case 'Deir ez-Zor':
        return S.of(context).Dei_ez_Zor;
      case 'Rural Deir ez-Zor':
        return S.of(context).Rural_Deir_ez_Zor;
      case 'Raqqa':
        return S.of(context).Raqqa;
      case 'Rural Raqqa':
        return S.of(context).Rural_Raqqa;
      case 'Al-Hasakah':
        return S.of(context).Al_Hasakah;
      case 'Rural Al-Hasakah':
        return S.of(context).Rural_Al_Hasakah;
      case 'Daraa':
        return S.of(context).Daraa;
      case 'Rural Daraa':
        return S.of(context).Rural_Daraa;
      case 'As-Suwayda':
        return S.of(context).As_Suwayda;
      case 'Rural As-Suwayda':
        return S.of(context).Rural_As_Suwayda;
      case 'Quneitra':
        return S.of(context).Quneitra;
      case 'Rural Quneitra':
        return S.of(context).Rural_Quneitra;
      default:
        return governorate;
    }
  }
}

class CommentModel {
  final int id;
  final String createdAt;
  // final String updatedAt;
  final int userId;
  // final int postId;
  final String content;
  final String userName;
  final String userProfileImageUrl;
  CommentModel({
    required this.id,
    required this.createdAt,
    // required this.updatedAt,
    required this.userId,
    // required this.postId,
    required this.content,
    required this.userName,
    required this.userProfileImageUrl,
  });
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      createdAt: json['created_at'],
      // updatedAt: json['updated_at'],
      userId: json['user_id'],
      // postId: json['post_id'],
      content: json['content'],
      userName: json['user_name'], // Assuming the user info is nested
      userProfileImageUrl: json['image'], // Assuming the user info is nested
    );
  }
}
