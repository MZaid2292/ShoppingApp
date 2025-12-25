import 'package:e_commerce/common/widgets/button/zelevated_button.dart';
import 'package:e_commerce/common/widgets/loaders/circular_loader.dart';
import 'package:e_commerce/common/widgets/texts/section_heading.dart';
import 'package:e_commerce/data/repositories/address/address_repository.dart';
import 'package:e_commerce/features/personalization/models/address_model.dart';
import 'package:e_commerce/features/personalization/screens/addresses/add_new_address.dart';
import 'package:e_commerce/features/personalization/screens/addresses/widgets/single_address.dart';
import 'package:e_commerce/utils/constant/sized.dart';
import 'package:e_commerce/utils/helpers/cloud_helper_functions.dart';
import 'package:e_commerce/utils/helpers/network_manager.dart';
import 'package:e_commerce/utils/popups/full_screen_loader.dart';
import 'package:e_commerce/utils/popups/snackbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressController extends GetxController{
  static AddressController get instance => Get.find();


  /// Variables
  final _repository = Get.put(AddressRepository());
  Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  RxBool refreshData = false.obs;

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();

  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

/// Function to add new address of the user
  Future<void> addNewAddress() async{

    try{

      // Start Loading
      ZFullScreenLoader.openLoadingDialog("Storing Address...");

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        ZFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if(!addressFormKey.currentState!.validate()){
        ZFullScreenLoader.stopLoading();
        return;
      }

      // Create Address Model
      AddressModel address = AddressModel(
        id: "",
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        postalCode: postalCode.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        country: country.text.trim(),
        dateTime: DateTime.now(),
       

      );

      // Save Address
      String addressId = await _repository.addAddress(address);

      // Update address id
      address.id = addressId;

      // update selected address
        selectAddress(address);

      // Stop Loading
      ZFullScreenLoader.stopLoading();

      // Show Success Message
      ZSnackBarHelpers.successSnackBar(title: "Congratulation",message: "Your address has been save successfully");

      // Refresh Addresses Data
      refreshData.toggle();

      // Reset fields
      resetFormFields();

      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);


    }catch(e){

      ZFullScreenLoader.stopLoading();
      ZSnackBarHelpers.errorSnackBar(title: "Failed",message: e.toString());
    }
  }

/// Function to get all address of specific user
  Future<List<AddressModel>> getAllAddresses() async{

    try{

      List<AddressModel> addresses = await _repository.fetchUserAddress();
      selectedAddress.value = addresses.firstWhere((address) => address.selectedAddress,orElse: ()=>AddressModel.empty());
      return addresses;

    }catch(e){
      ZSnackBarHelpers.errorSnackBar(title: "Failed",message: e.toString());
      return [];
    }

  }

  /// Function to select Address
  Future<void> selectAddress(AddressModel newSelectedAddress) async{

    try{

      // Start Loading
      Get.defaultDialog(
        title: "",
        onWillPop: () async => false,
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        content: ZCircularLoader(),
      );

      // unselect the already selected address
      if(selectedAddress.value.id.isNotEmpty){
        await _repository.updateSelectedField(selectedAddress.value.id, false);
      }

      // assign selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;


      // Set the Selected Address to true in the firebase
      await _repository.updateSelectedField(selectedAddress.value.id, true);


      Get.back();

    }catch(e){
      Get.back();
      ZSnackBarHelpers.errorSnackBar(title: "Failed",message: e.toString());
    }
  }


  /// Function to Show Bottom Sheet to select address
  Future<void> selectNewAddressBottomSheet(BuildContext context){
    return showModalBottomSheet(
        context: context,
        builder: (context) => Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(ZSizes.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ZSectionHeading(title: "Select Address",showActionButton: false),
                    SizedBox(height: ZSizes.spaceBtwItems),
                    FutureBuilder(
                        future: getAllAddresses(),
                        builder: (context, snapshot) {

                          /// Handle Error, Loading , Empty States
                          final widget = ZCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                          if(widget != null) return widget;

                          return ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) => SizedBox(height: ZSizes.spaceBtwItems),
                              shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) => ZSingleAddress(address: snapshot.data![index], onTap: (){
                              selectAddress(snapshot.data![index]);
                              Get.back();
                            }),


                          );
                        },
                    ),
                    SizedBox(height: ZSizes.spaceBtwSections),
                  ],
                ),
              ),
            ),

            Positioned(
              bottom: ZSizes.defaultSpace,
              left: ZSizes.defaultSpace * 2,
              right: ZSizes.defaultSpace * 2,
                child: ZElevatedButton(onPressed: () => Get.to(() => AddNewAddressScreen()),
                    child: Text("Add New Address")
                ))
          ],
        ),
    );
  }

  /// function to reset all fields of the form
  void resetFormFields(){
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();

    addressFormKey.currentState!.reset();
  }



}