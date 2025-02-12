import '../models/parking.dart';

class ParkingRepository {
  List<Parking> parkings = [];

  void add(Parking parking) {
    parkings.add(parking);
    print("Parking added successfully.");
  }

  List<Parking> getAll() => parkings;

  Parking? getById(int id) {
    return parkings.isNotEmpty && id >= 0 && id < parkings.length
        ? parkings[id]
        : null;
  }

  void delete(int id) {
    parkings.removeAt(id);
    print("Parking deleted.");
  }
}
