class Campsite {
  String number;
  String siteName;
  String rating;
  String imageURL;
  String state;
  String long;
  String lat;

  Campsite(
      {this.number = '',
      this.siteName = '',
      this.rating = '',
      this.imageURL = '',
      this.state = '',
      this.long = '',
      this.lat = ''});

  factory Campsite.fromJson(Map<String, dynamic> parsedJson) {
    return new Campsite(
      number: parsedJson['number'] ?? '',
      siteName: parsedJson['siteName'] ?? '',
      rating: parsedJson['rating'] ?? '',
      imageURL: parsedJson['imageURL'] ?? '',
      state: parsedJson['state'] ?? '',
      long: parsedJson['longitude'] ?? '',
      lat: parsedJson['latitude'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': this.number,
      'siteName': this.siteName,
      'rating': this.rating,
      'imageURL': this.imageURL,
      'state': this.state,
      'logitude': this.long,
      'latitude': this.lat
    };
  }
}
