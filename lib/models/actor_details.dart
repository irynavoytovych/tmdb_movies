class ActorDetails {
  final String? birthday;
  final int id;
  final String name;
  final String? placeOfBirth;
  final double popularity;

  ActorDetails ({
    required this.birthday,
    required this.id,
    required this.name,
    required this.placeOfBirth,
    required this.popularity,
});

  ActorDetails.fromJson(Map <String, dynamic> json)
  : birthday = json['birthday'],
  id = json['id'],
  name = json['name'],
  placeOfBirth = json['place_of_birth'],
  popularity = json['popularity'];
}