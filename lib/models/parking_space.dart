class ParkingSpace {
  int id;
  String address;
  double pricePerHour;

  ParkingSpace(
      {required this.id, required this.address, required this.pricePerHour});

  @override
  String toString() {
    return 'Parking Space: ID = $id, Address = $address, Price = $pricePerHour/hr';
  }
}
