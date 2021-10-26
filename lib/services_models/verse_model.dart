class VerseModel {

  int verse_number;
  String text_uthmani;
  String audio_url;


  VerseModel(
      {this.verse_number,
        this.text_uthmani,
        this.audio_url
      });


  factory VerseModel.fromJson(Map<String, dynamic> json) {
    {

      return VerseModel(

          verse_number: json["verse_number"],
          text_uthmani: json["text_uthmani"],
          audio_url: json["audio"]["url"]

      );
    }
  }
}