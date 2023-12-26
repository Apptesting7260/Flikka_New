
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactController extends GetxController {

  RxList<Contact> contacts = <Contact>[].obs;

  RxBool isLoading = false.obs;

  List<ContactField> fields = ContactField.values.toList();

  Future<void> loadContacts() async {
    var status = await Permission.contacts.status;
    if (status.isGranted) {
      try {
        isLoading(true);
        contacts.value = await FastContacts.getAllContacts(fields: fields);
        if (kDebugMode) {
          print('Contacts: ${contacts.length}');
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error loading contacts: $e');
        }
      } finally {
        isLoading(false);
      }
    } else {
      // Handle permission not granted
      if (kDebugMode) {
        print('Contacts permission not granted');
      }
    }
  }

}