class Cast {
  bool adult;
  int gender;
  int id;
  // Department knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;
  // Department department;
  String job;

  Cast({
    this.adult,
    this.gender,
    this.id,
    // this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    // this.department,
    this.job,
  });

  Cast.fromJsonMap(Map<String, dynamic> json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    // knownForDepartment = json['knownForDepartment'];
    name = json['name'];
    originalName = json['original_name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    order = json['order'];
    // department = json['department'];
    job = json['job'];
  }

  getProfilePictureImg() {
    return (profilePath != null)
        ? 'https://image.tmdb.org/t/p/w500/$profilePath'
        : '';
  }
}
