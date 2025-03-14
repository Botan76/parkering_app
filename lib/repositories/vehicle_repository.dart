import 'dart:convert';
import 'package:http/http.dart' as http;

class VehicleRepository {
  final String baseUrl = "http://127.0.0.1:8080/vehicles/"; // Server API

  // Add a new vehicle (POST request)
  Future<void> addVehicle(String registrationNumber, String type,
      String ownerPersonalNumber) async {
    var requestBody = {
      'registrationNumber': registrationNumber,
      'type': type,
      'ownerPersonalNumber': ownerPersonalNumber,
    };

    try {
      var response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print("✅ Vehicle added successfully!");
      } else {
        print("❌ Error adding vehicle: ${response.body}");
      }
    } catch (e) {
      print("🚨 Exception occurred while adding vehicle: $e");
    }
  }

  // Get all vehicles (GET request)
  Future<void> getAllVehicles() async {
    try {
      var response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        print("✅ Vehicles: ${response.body}");
      } else {
        print("❌ Error fetching vehicles: ${response.statusCode}");
      }
    } catch (e) {
      print("🚨 Exception occurred while fetching vehicles: $e");
    }
  }

  // Get vehicle by registration number (GET request)
  Future<void> getById(String registrationNumber) async {
    try {
      var response = await http.get(Uri.parse('$baseUrl/$registrationNumber'));

      if (response.statusCode == 200) {
        print("✅ Vehicle found: ${response.body}");
      } else {
        print("❌ Vehicle not found.");
      }
    } catch (e) {
      print("🚨 Exception occurred while fetching vehicle: $e");
    }
  }

  // Delete a vehicle (DELETE request)
  Future<void> deleteVehicle(String registrationNumber) async {
    try {
      var response =
          await http.delete(Uri.parse('$baseUrl/$registrationNumber'));

      if (response.statusCode == 200) {
        print("✅ Vehicle deleted successfully!");
      } else {
        print("❌ Error deleting vehicle: ${response.body}");
      }
    } catch (e) {
      print("🚨 Exception occurred while deleting vehicle: $e");
    }
  }
}
