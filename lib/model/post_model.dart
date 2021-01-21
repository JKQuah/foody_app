class PostModel {
  int id;
  int userId;
  String username;
  String postImages;
  String location;
  String caption;
  double services;
  double cleanliness;
  double taste;
  double price;

  PostModel({
    this.id,
    this.userId,
    this.username,
    this.postImages,
    this.location,
    this.caption,
    this.services,
    this.cleanliness,
    this.taste,
    this.price,
  });
}
