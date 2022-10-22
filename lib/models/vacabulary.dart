class Vocabulary {
  final int? id;
  final String french;
  final String azerbaijani;
  final String russ;
  final String english;
  final String turkish;
  Vocabulary(
      {this.azerbaijani = "",
      this.russ = "",
      this.english = "",
      this.turkish = "",
      this.id,
      required this.french});

  // ignore: unnecessary_new
  factory Vocabulary.fromMap(Map<String, dynamic> json) => new Vocabulary(
        id: json["id"],
        french: json["french"],
        azerbaijani: json["azerbaijani"],
        english: json["english"],
        russ: json["russ"],
        turkish: json["turkish"]
      );
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "french": french,
      "azerbaijani": azerbaijani,
      "russ": russ,
      "english": english,
      "turkish": turkish
    };
  }
}
