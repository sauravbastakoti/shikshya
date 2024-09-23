import 'package:sikshya/models/post.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  Future<List<Courses>?> getPost() async {
    var client = http.Client();
    var uni = Uri.parse(
        "https://courses-4e473-default-rtdb.firebaseio.com/courses.json");
    var response = await client.get(uni);
    if (response.statusCode == 200) {
      var json = response.body;
      return coursesFromJson(json);
    } else {
      return null;
    }
  }
}
