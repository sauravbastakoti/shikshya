class Course {
  final int id;
  final int teacher;
  final String title;
  final String description;
  final String? thumbnail;
  final String validationDate;
  final double price;
  final List<dynamic> chapters;

  Course({
    required this.id,
    required this.teacher,
    required this.title,
    required this.description,
    this.thumbnail,
    required this.validationDate,
    required this.price,
    required this.chapters,
  });

  // Factory method to create a Course from JSON
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      teacher: json['teacher'],
      title: json['title'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      validationDate: json['validation_date'],
      price: json['price'],
      chapters: json['chapters'],
    );
  }

  // Method to convert a list of JSON objects to a list of Courses
  static List<Course> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Course.fromJson(json)).toList();
  }
}
