import 'vehicle.dart';
import 'parking_space.dart';

class Parking {
  Vehicle vehicle;
  ParkingSpace parkingSpace;
  DateTime startTime;
  DateTime? endTime;

  Parking(
      {required this.vehicle,
      required this.parkingSpace,
      required this.startTime,
      this.endTime});

  @override
  String toString() {
    String status =
        endTime == null ? "Ongoing" : "Ended at ${endTime.toString()}";
    return 'Parking: Vehicle = ${vehicle.registrationNumber}, Location = ${parkingSpace.address}, Start = ${startTime.toString()}, Status = $status';
  }
}
