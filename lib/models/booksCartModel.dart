// ignore_for_file: file_names

class BooksModel {
  late String name;
  late String quantity;
  late String note;
  String? book_type;
  String? bookDetail1;
  String? bookDetail2;
  String? time;
  late String date;
  late String image;

  BooksModel(String name, String quantity, String note, String book_type,
      String bookDetail1, String bookDetail2, String time, String date,String image) {
    this.name = name;
    this.quantity = quantity;
    this.note = note;
    this.book_type = book_type;
    this.bookDetail1 = bookDetail1;
    this.bookDetail2 = bookDetail2;
    this.time = time;
    this.date = date;
    this.image=image;
  }
}
