
class Scores {

  int collegeScore;
  String email;
  int parksScore;
  int riddlesScore;

  Scores({
    required this.collegeScore,
    required this.email,
    required this.parksScore,
    required this.riddlesScore
  });

  Map<String, dynamic> toJson() => {
    'collegescore' : collegeScore,
    'email' : email,
    'parksscore' : parksScore,
    'riddlesscore' : riddlesScore
  };

  static Scores fromJson(Map<String, dynamic> json) => Scores(
      collegeScore: json['collegescore'] as int,
      email: json['email'] as String,
      parksScore: json['parksscore'] as int,
      riddlesScore: json['riddlesscore'] as int
  );

}


