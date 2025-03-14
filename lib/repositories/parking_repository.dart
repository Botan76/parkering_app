import 'dart:convert';
import 'package:http/http.dart' as http;

class ParkingRepository {
  final String baseUrl = "http://localhost:8080/parkings"; // Server API

  // Add a new parking entry (POST request)
  Future<void> addParking(
      String registrationNumber, String parkingSpaceId) async {
    var response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'vehicleRegistration': registrationNumber,
        'parkingSpaceId': parkingSpaceId,
        'startTime': DateTime.now().toIso8601String(),
      }),
    );

    if (response.statusCode == 200) {
      print("Parking added successfully!");
    } else {
      print("Error adding parking: ${response.body}");
    }
  }

  // Get all parking records (GET request)
  Future<void> getAllParkings() async {
    var response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      print("Parkings: ${response.body}");
    } else {
      print("Error fetching parkings: ${response.statusCode}");
    }
  }

  // Get parking by ID (GET request)
  Future<void> getById(String id) async {
    var response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      print("Parking found: ${response.body}");
    } else {
      print("Parking not found.");
    }
  }

  // Delete a parking record (DELETE request)
  Future<void> deleteParking(String id) async {
    var response = await http.delete(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      print("Parking deleted successfully!");
    } else {
      print("Error deleting parking: ${response.body}");
    }
  }
}
