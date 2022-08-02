// ignore_for_file: file_names

class ClothesModel {
  late String name;
  late String quantity;
  late String note;
  String? clothes_for;
  String? gender;
  String? size;
  String? clothe_type;
  String? time;
  late String date;
  late String image;

  ClothesModel(
      String name,
      String quantity,
      String note,
      String clothes_for,
      String gender,
      String size,
      String clothe_type,
      String time,
      String date,
      String image) {
    this.name = name;
    this.quantity = quantity;
    this.note = note;
    this.clothes_for = clothes_for;
    this.gender = gender;
    this.size = size;
    this.clothe_type = clothe_type;
    this.time = time;
    this.date = date;
    this.image=image;
  }
}
