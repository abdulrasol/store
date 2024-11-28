// import 'package:current_location/current_location.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:icons_plus/icons_plus.dart';
// import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

// import 'package:store/database/models/user_adress_model.dart';
// import 'package:store/database/services/auth.dart';
// import 'package:store/ui/pages/add_new_address.dart';
// import 'package:store/ui/widgets/generic_app_bar.dart';

// class UserAddressList extends StatefulWidget {
//   const UserAddressList({super.key});

//   @override
//   State<UserAddressList> createState() => _UserAddressListState();
// }

// class _UserAddressListState extends State<UserAddressList> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: genericAppBar(
//         context: context,
//         title: 'Shipping Address',
//         withBackAction: true,
//         showSearchIcon: false,
//       ),
//       body: FutureBuilder<List<UserAdressModel>>(
//         future: Auth.getUserAddressList(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return const Center(
//               child: Text('has no data'),
//             );
//           } else if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: ListView.builder(
//                   itemCount: snapshot.data!.length,
//                   itemBuilder: (context, index) {
//                     final btnControll = RoundedLoadingButtonController();
//                     return Card(
//                       margin: const EdgeInsets.all(4),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(snapshot.data![index].title),
//                                 Text(snapshot.data![index].description)
//                               ],
//                             ),
//                             const Expanded(
//                               child: SizedBox(),
//                             ),
//                             IconButton(
//                               onPressed: () async {
//                                 await Get.to(
//                                   () => AddNewAddress(
//                                     longitude: snapshot.data![index].longitude,
//                                     latitude: snapshot.data![index].latitude,
//                                     title: snapshot.data![index].title,
//                                     id: snapshot.data![index].id,
//                                     newOrupdate: false,
//                                   ),
//                                 );
//                                 setState(() {});
//                               },
//                               icon: const Icon(FontAwesome.pencil_solid),
//                             ),
//                             const SizedBox(width: 15),
//                             RoundedLoadingButton(
//                               elevation: 0,
//                               color: Colors.white,
//                               valueColor: Colors.black87,
//                               width: 50,
//                               controller: btnControll,
//                               onPressed: () async {
//                                 await Auth.deleteAdress(
//                                     snapshot.data![index].id);
//                                 btnControll.reset();
//                                 setState(() {});
//                               },
//                               child: const Icon(
//                                 Bootstrap.x_circle_fill,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//             );
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () async {
//           final userLocation = await UserLocation.getValue();
//           final double longitude = userLocation!.longitude ?? 44;
//           final double latitude = userLocation.latitude ?? 32;
//           await Get.to(() => AddNewAddress(
//                 longitude: longitude,
//                 latitude: latitude,
//                 title: '',
//               ));
//           setState(() {});
//         },
//         label: const Text(' New Address'),
//         icon: const Icon(FontAwesome.map_location_dot_solid),
//         backgroundColor: Colors.black87,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class UserAddressList extends StatelessWidget {
  const UserAddressList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('under coding'),
      ),
    );
  }
}
