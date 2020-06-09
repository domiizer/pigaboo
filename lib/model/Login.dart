

class Login{
  final bool status;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String address;
  final String flag;
  final String customerId;
  Login({this.status,this.firstName,this.lastName,this.phoneNumber,this.address,this.flag,this.customerId});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      status: json['status'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      flag: json['flag'],
      customerId: json['customerId'],
    );
  }

}