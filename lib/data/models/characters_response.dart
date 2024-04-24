class CharactersResponse {
  String? error;
  Info? info;
  List<Character>? results;

  CharactersResponse({this.error, this.info, this.results});

  CharactersResponse.fromJson(Map<String, dynamic> json) {
    if (json['error'] is String) {
      error = json['error'];
    }

    if (json["info"] is Map) {
      info = json["info"] == null ? null : Info.fromJson(json["info"]);
    }
    if (json["results"] is List) {
      results = json["results"] == null
          ? null
          : (json["results"] as List)
              .map((e) => Character.fromJson(e))
              .toList();
    }
  }
}

class Character {
  int? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  Origin? origin;
  Location? location;
  String? image;
  List<String>? episode;
  String? url;
  String? created;

  Character(
      {this.id,
      this.name,
      this.status,
      this.species,
      this.type,
      this.gender,
      this.origin,
      this.location,
      this.image,
      this.episode,
      this.url,
      this.created});

  Character.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["status"] is String) {
      status = json["status"];
    }
    if (json["species"] is String) {
      species = json["species"];
    }
    if (json["type"] is String) {
      type = json["type"];
    }
    if (json["gender"] is String) {
      gender = json["gender"];
    }
    if (json["origin"] is Map) {
      origin = json["origin"] == null ? null : Origin.fromJson(json["origin"]);
    }
    if (json["location"] is Map) {
      location =
          json["location"] == null ? null : Location.fromJson(json["location"]);
    }
    if (json["image"] is String) {
      image = json["image"];
    }
    if (json["episode"] is List) {
      episode =
          json["episode"] == null ? null : List<String>.from(json["episode"]);
    }
    if (json["url"] is String) {
      url = json["url"];
    }
    if (json["created"] is String) {
      created = json["created"];
    }
  }
}

class Location {
  String? name;
  String? url;

  Location({this.name, this.url});

  Location.fromJson(Map<String, dynamic> json) {
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["url"] is String) {
      url = json["url"];
    }
  }
}

class Origin {
  String? name;
  String? url;

  Origin({this.name, this.url});

  Origin.fromJson(Map<String, dynamic> json) {
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["url"] is String) {
      url = json["url"];
    }
  }
}

class Info {
  int? count;
  int? pages;
  String? next;
  dynamic prev;

  Info({this.count, this.pages, this.next, this.prev});

  Info.fromJson(Map<String, dynamic> json) {
    if (json["count"] is int) {
      count = json["count"];
    }
    if (json["pages"] is int) {
      pages = json["pages"];
    }
    if (json["next"] is String) {
      next = json["next"];
    }
    prev = json["prev"];
  }
}
