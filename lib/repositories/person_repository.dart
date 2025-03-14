import 'dart:convert';
import 'package:http/http.dart' as http;

class PersonRepository {
  final String baseUrl = "http://127.0.0.1:8080/persons/"; // Server URL

  // Add a new person (POST request)
  Future<void> addPerson(String name, String personalNumber) async {
    var response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'personalNumber': personalNumber}),
    );
    print(response.body);
  }

  // Get all persons (GET request)
  Future<void> getAllPersons() async {
    var response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      print("Persons: ${response.body}");
    } else {
      print("Error fetching persons: ${response.statusCode}");
    }
  }

  // Get a person by ID (GET request)
  Future<void> getById(String personalNumber) async {
    var response = await http.get(Uri.parse('$baseUrl/$personalNumber'));
    if (response.statusCode == 200) {
      print("Person found: ${response.body}");
    } else {
      print("Person not found.");
    }
  }

  // Delete a person (DELETE request)
  Future<void> delete(String personalNumber) async {
    var response = await http.delete(Uri.parse('$baseUrl/$personalNumber'));
    print(response.body);
  }
}
