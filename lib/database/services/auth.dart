import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:store/database/models/user_adress_model.dart';
import 'package:store/database/models/user_model.dart';
import 'package:store/database/services/controller.dart';

class Auth {
  static final controller = Get.put(Controller());
  static final userAddresscollection = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('address');
  //

  static Future<String?> createUser(
      {required String email, required String password}) async {
    try {
      var userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        // Successfully created user, add user info to Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(
          {
            'id': userCredential.user!.uid,
            'profileImage': '',
          },
        );
      }
      // final controller = Get.put(Controller());
      controller.userData.value = await Auth.getUserData();
      return null; // success
    } on FirebaseAuthException catch (e) {
      // Handle specific FirebaseAuth exceptions
      if (e.code == 'email-already-in-use') {
        return 'The email address is already in use by another account.';
      } else if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      }
      return e.message; // Return the error message for other exceptions
    } catch (e) {
      return e.toString(); // Return the error message for general exceptions
    }
  }

  static Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // final controller = Get.put(Controller());
      controller.userData.value = await Auth.getUserData();
      return null; // success
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return 'The email address invalid.';
      } else if (e.code == 'user-not-found') {
        return 'The email address is not linked with any account!';
      } else if (e.code == 'wrong-password') {
        return 'Invalid password';
      }
      return e.message; // Return the error message for other exceptions
    }
  }

  static Future<String?> resetPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'auth/invalid-email') {
        return 'The email address invalid.';
      } else if (e.code == 'auth/missing-android-pkg-name' ||
          e.code == 'auth/missing-continue-uri' ||
          e.code == 'auth/unauthorized-continue-uri') {
        return 'The email address is not linked with account.';
      } else if (e.code == 'auth/user-not-found') {
        return 'The email address is not linked with any account!';
      }
      return e.message; // Return the error message for other exceptions
    }

    return null;
  }

  // get user data
  static Future<UserModel> getUserData() async {
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    return UserModel(profileImage: userData.data()!['profileImage']);
  }

// update user data
  static Future updateUserData(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(data);
  }

  // get user address list
  static Future<List<UserAdressModel>> getUserAddressList() async {
    final adresses = await userAddresscollection.get();
    return adresses.docs
        .map((e) => UserAdressModel(
            id: e.id,
            title: e.data()['title'],
            description: e.data()['description'],
            latitude: e.data()['latitude'],
            longitude: e.data()['longitude']))
        .toList();
  }

  // set new address
  static Future setNewAddress(UserAdressModel address) async {
    await userAddresscollection.add(address.toMap());
  }

  // update address
  static Future updateAddress(
      {required String id, required UserAdressModel address}) async {
    await userAddresscollection.doc(id).update(address.toMap());
  }

  // delete address
  static Future deleteAdress(String id) async {
    await userAddresscollection.doc(id).delete();
  }
}
