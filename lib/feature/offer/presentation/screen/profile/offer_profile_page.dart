import 'package:flutter/material.dart';
import 'package:mae_ban/core/utils/auth_utils.dart';
import 'package:mae_ban/feature/auth/data/models/user_model.dart';
import 'package:mae_ban/feature/offer/presentation/screen/profile/address/address_view.dart';
import 'package:mae_ban/feature/auth/data/local_storage/local_storage_service.dart';

class OfferProfile extends StatelessWidget {
  final User user;
  final LocalStorageService localStorageService = LocalStorageService();

  OfferProfile({Key? key, required this.user}) : super(key: key);

  void navigateToAddressView(BuildContext context) async {
    final token = await localStorageService.getToken();
    if (token != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddressView(userId: user.id, token: token),
        ),
      );
    } else {
      // Handle the case where token is null, maybe redirect to login
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Token is missing. Please log in again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: IconButton(
            onPressed: () => logout(context), icon: Icon(Icons.logout)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('First Name: ${user.firstName}'),
            Text('Last Name: ${user.lastName}'),
            Text('Phone: ${user.phone}'),
            // Add more fields as needed
            GestureDetector(
              onTap: () => navigateToAddressView(context),
              child: Text(
                'address',
                style: TextStyle(color: Colors.blue),
              ),
            )
          ],
        ),
      ),
    );
  }
}
