import '../models/vehicle.dart';

class VehicleRepository {
  List<Vehicle> vehicles = [];

  void add(Vehicle vehicle) {
    vehicles.add(vehicle);
    print("Vehicle added successfully.");
  }

  List<Vehicle> getAll() => vehicles;

  Vehicle? getById(String registrationNumber) {
    return vehicles.firstWhere(
      (v) => v.registrationNumber == registrationNumber,
      orElse: () => throw Exception("Vehicle not found"),
    );
  }

  void delete(String registrationNumber) {
    vehicles.removeWhere((v) => v.registrationNumber == registrationNumber);
    print("Vehicle deleted.");
  }
}
