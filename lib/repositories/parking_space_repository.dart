import 'dart:convert';
import 'package:http/http.dart' as http;

class ParkingSpaceRepository {
  final String baseUrl = "http://localhost:8080/parking_spaces"; // Server API

  // Add a new parking space (POST request)
  Future<void> addParkingSpace(
      int id, String address, double pricePerHour) async {
    var response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': id,
        'address': address,
        'pricePerHour': pricePerHour,
      }),
    );

    if (response.statusCode == 200) {
      print("Parking space added successfully!");
    } else {
      print("Error adding parking space: ${response.body}");
    }
  }

  // Get all parking spaces (GET request)
  Future<void> getAllParkingSpaces() async {
    var response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      print("Parking Spaces: ${response.body}");
    } else {
      print("Error fetching parking spaces: ${response.statusCode}");
    }
  }

  // Get parking space by ID (GET request)
  Future<void> getById(String id) async {
    var response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      print("Parking space found: ${response.body}");
    } else {
      print("Parking space not found.");
    }
  }

  // Delete a parking space (DELETE request)
  Future<void> deleteParkingSpace(String id) async {
    var response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      print("Parking space deleted successfully!");
    } else {
      print("Error deleting parking space: ${response.body}");
    }
  }
}
