import 'package:dharohar/cloud_functions/update_user_info.dart';
import 'package:dharohar/constants/colors.dart';
import 'package:dharohar/data/model/user_model.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  final UserModel user;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  EditProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: AppColor.secondaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Update your details",
          style: TextStyle(
            color: AppColor.secondaryColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: AppColor.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              detailEntryField(
                  'Name', user.fullName ?? "", _nameController, context),
              const SizedBox(height: 15),
              detailEntryField('Phone No.', user.phoneNumber ?? "",
                  _phoneNumberController, context),
              const SizedBox(height: 15),
              detailEntryField('Building Name/No.', user.address ?? "",
                  _buildingController, context),
              const SizedBox(height: 15),
              detailEntryField(
                  'City Name', user.city ?? "", _cityController, context),
              const SizedBox(height: 15),
              detailEntryField(
                  'State', user.state ?? "", _stateController, context),
              const SizedBox(height: 15),
              detailEntryField(
                  'Pin Code', user.pinCode ?? "", _pincodeController, context),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    user.fullName = _nameController.text.isNotEmpty
                        ? _nameController.text
                        : user.fullName;
                    user.phoneNumber = _phoneNumberController.text.isNotEmpty
                        ? _phoneNumberController.text
                        : user.phoneNumber;
                    user.address = _buildingController.text.isNotEmpty
                        ? _buildingController.text
                        : user.address;
                    user.city = _cityController.text.isNotEmpty
                        ? _cityController.text
                        : user.city;
                    user.state = _stateController.text.isNotEmpty
                        ? _stateController.text
                        : user.state;
                    user.pinCode = _pincodeController.text.isNotEmpty
                        ? _pincodeController.text
                        : user.pinCode;
                    updateUserDetails(user).then(
                      (_) => Navigator.pop(context, true),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        AppColor.primaryColor), // Background color
                    elevation:
                        MaterialStateProperty.all<double>(4.0), // Elevation
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // Rounded corners
                      ),
                    ),
                  ),
                  child: const Text(
                    "Update your Details",
                    style: TextStyle(
                      color: AppColor.secondaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget detailEntryField(
    String _detailTitle,
    String _hint,
    TextEditingController _controller,
    BuildContext context,
  ) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '$_detailTitle: ',
          ),
          const SizedBox(width: 15),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.emailAddress, // Set keyboard type
              controller: _controller,
              decoration: InputDecoration(
                hintText: _hint, // Placeholder text
              ),
            ),
          ),
        ],
      ),
    );
  }
}
