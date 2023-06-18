class RandomDogImageEntity {
  String? message;
  String? status;

  RandomDogImageEntity({required this.message, required this.status});

  RandomDogImageEntity.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
  }
}
