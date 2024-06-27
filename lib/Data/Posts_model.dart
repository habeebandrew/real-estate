//posts + comments Model
class Post {
  final int id;
  final String userId;
  final String state;
  final String governorate;
  final String region;
  final int budget;
  final String description;
  final int mobilenumber;
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
      userId: json['user_id'],//user_id user_name
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
      userName: json['user_name'],  // Assuming the user info is nested
      userProfileImageUrl: json['image'], // Assuming the user info is nested
    );
  }
}
