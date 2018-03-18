class CastMember {

  String character;
  String name;
  String profilePicture;

  static final String imageUrl = "https://image.tmdb.org/t/p/w300/";
  String getProfilePicture() => imageUrl + profilePicture;

  CastMember.fromJson(Map jsonMap)
      :
        character = jsonMap['character'],
        name = jsonMap['name'],
        profilePicture = jsonMap['profile_path'];

}