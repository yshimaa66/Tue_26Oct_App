class ChapterModel {

  int number;
  String name;
  String name_english;
  int pages;
  String revelation_place;
  bool bismillah_pre;
  int verses_count;

  ChapterModel(
      {this.number,
        this.name_english,
        this.name,
        this.pages,
        this.revelation_place,
        this.bismillah_pre,
        this.verses_count
      });


  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    {

      return ChapterModel(

          number: json['id']??"",
          revelation_place: json["revelation_place"],
          name: json["name_arabic"],
          name_english: json["name_simple"],
          pages: json["pages"][1],
          verses_count: json["verses_count"],
          bismillah_pre: json["bismillah_pre"]


      );
    }
  }
}