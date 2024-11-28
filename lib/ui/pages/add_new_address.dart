// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:icons_plus/icons_plus.dart';
// import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
// import 'package:store/database/models/user_adress_model.dart';
// import 'package:store/database/services/auth.dart';
// import 'package:store/ui/widgets/decoration.dart';
// import 'package:store/ui/widgets/generic_app_bar.dart';

// class AddNewAddress extends StatelessWidget {
//   final double longitude;
//   final double latitude;
//   final String title;
//   final String id;
//   final bool newOrupdate;

//   const AddNewAddress({
//     super.key,
//     required this.longitude,
//     required this.latitude,
//     required this.title,
//     this.newOrupdate = true,
//     this.id = '',
//   });

//   @override
//   Widget build(BuildContext context) {
//     final controller = TextEditingController(text: title);
//     final GlobalKey<FormState> key = GlobalKey<FormState>();
//     return Scaffold(
//       appBar: genericAppBar(
//         context: context,
//         title: 'add address',
//         withBackAction: true,
//         showSearchIcon: false,
//       ),
//       body: Column(
//         children: [
//           Form(
//               key: key,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   decoration: inputDecoration.copyWith(
//                       prefixIcon: const Icon(
//                         CupertinoIcons.location_solid,
//                         color: Colors.black87,
//                       ),
//                       label: const Text(
//                         'Home, Work or Parents House',
//                         style: TextStyle(color: Colors.black87),
//                       ),
//                       focusColor: Colors.black87),
//                   controller: controller,
//                 ),
//               )),
//           Expanded(
//             child: OpenStreetMapSearchAndPick(
//               locationPinIcon: CupertinoIcons.location_solid,
//               locationPinIconColor: Colors.black87,
//               locationPinText: '',
//               zoomInIcon: Bootstrap.zoom_in,
//               zoomOutIcon: Bootstrap.zoom_out,
//               center: LatLong(latitude, longitude),
//               onPicked: (pickedData) async {
//                 if (newOrupdate) {
//                   if (controller.text != '') {
//                     Auth.setNewAddress(UserAdressModel(
//                       id: '',
//                       title: controller.text,
//                       description:
//                           '${pickedData.address['road']}, ${pickedData.address['neighbourhood']}, ${pickedData.address['state']}',
//                       latitude: pickedData.latLong.latitude,
//                       longitude: pickedData.latLong.longitude,
//                     ));
//                     Get.back();
//                   } else {
//                     Get.defaultDialog(
//                         title: 'Please enter title first',
//                         titlePadding: const EdgeInsets.all(8),
//                         content: const Icon(
//                           Bootstrap.exclamation_circle_fill,
//                           size: 25,
//                         ));
//                   }
//                 } else {
//                   Auth.updateAddress(
//                     id: id,
//                     address: UserAdressModel(
//                       id: id,
//                       title: controller.text,
//                       description:
//                           '${pickedData.address['road']}, ${pickedData.address['neighbourhood']}, ${pickedData.address['state']}',
//                       latitude: pickedData.latLong.latitude,
//                       longitude: pickedData.latLong.longitude,
//                     ),
//                   );
//                   Get.back();
//                 }
//               },
//               buttonColor: Colors.black87,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
class AddNewAddress extends StatelessWidget {
  const AddNewAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('under coding'),
      ),
    );
  }
}
