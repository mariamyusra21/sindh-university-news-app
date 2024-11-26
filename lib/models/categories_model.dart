class CategoriesModel {
  final String categoryName;
  final String categoryId;
  String? sindhiName;
  String? urduName;

  CategoriesModel(
      {required this.categoryName,
      required this.categoryId,
      this.sindhiName,
      this.urduName});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
          categoryName: json['NAME'],
          categoryId: json['NOTIFY_TYPE_ID'],
          sindhiName: json['SINDHI'],
          urduName: json['URDU']);
}
