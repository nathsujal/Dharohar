import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dharohar/data/model/user_model.dart';

// Function to update user details
Future<void> updateUserDetails(UserModel user) async {
  try {
    final userRef = await FirebaseFirestore.instance
        .collection('Users') // Document we are using
        .doc(user.sId); // searching our Collection

    // Update the user's data with the provided map
    await userRef.update({
      'name': user.fullName,
      'phoneNumber': user.phoneNumber,
      'building': user.address,
      'city': user.city,
      'state': user.state,
      'pincode': user.pinCode,
    });

    print('User details updated successfully');
  } catch (e) {
    print('Error updating user details: $e');
  }
}
