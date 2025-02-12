import '../models/parking_space.dart';

class ParkingSpaceRepository {
  List<ParkingSpace> spaces = [];

  void add(ParkingSpace space) {
    spaces.add(space);
    print("Parking space added successfully.");
  }

  List<ParkingSpace> getAll() => spaces;

  ParkingSpace? getById(int id) {
    return spaces.firstWhere(
      (s) => s.id == id,
      orElse: () => ParkingSpace(
          id: -1,
          address: "Not Found",
          pricePerHour: 0), // Temporary dummy object
    );
  }

  void delete(int id) {
    spaces.removeWhere((s) => s.id == id);
    print("Parking space deleted.");
  }
}
