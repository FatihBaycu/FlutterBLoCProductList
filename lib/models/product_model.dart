class ProductModel {
  late int id;
  late String title;
  late double price;
  late String description;
  late String category;
  late String image;

  ProductModel(
      this.id, 
      this.title, 
      this.price, 
      this.description, 
      this.category, 
      this.image);

  ProductModel.fromJson(dynamic json) {
    id = json["id"];
    title = json["title"];
    price = double.tryParse(json["price"].toString())!;
    description = json["description"];
    category = json["category"];
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["title"] = title;
    map["price"] = price;
    map["description"] = description;
    map["category"] = category;
    map["image"] = image;
    return map;
  }

}