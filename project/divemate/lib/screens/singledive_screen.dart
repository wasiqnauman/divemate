import 'package:divemate/screens/divelogs_screen.dart';
import 'package:divemate/screens/documents_screen.dart';
import 'package:divemate/screens/home_screen.dart';
import 'package:divemate/screens/login_screen.dart';
import 'package:divemate/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:provider/provider.dart';
import '../database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import '../database.dart';
import '../widgets/widgets_for_lists.dart';

// import 'package:search_map_place/search_map_place.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';


class AllFieldsFormBloc extends FormBloc<String, String> {
  final db = DatabaseService();

  final divesite = TextFieldBloc();
  final description = TextFieldBloc();
  
  final boolean1 = BooleanFieldBloc();

  final boolean2 = BooleanFieldBloc();

  final select1 = SelectFieldBloc(
    items: ['Recreational', 'Certification', 'Professional'],
  );

  final select2 = SelectFieldBloc(
    items: ['Option 1', 'Option 2'],
  );

  final multiSelect1 = MultiSelectFieldBloc<String, dynamic>(
    items: [
      'Option 1',
      'Option 2',
    ],
  );

  final date1 = InputFieldBloc<DateTime, Object>();

  final dateAndTime1 = InputFieldBloc<DateTime, Object>();

  final time1 = InputFieldBloc<TimeOfDay, Object>();

  AllFieldsFormBloc() {
    addFieldBlocs(fieldBlocs: [
      divesite,
      description,
      boolean1,
      boolean2,
      select1,
      select2,
      multiSelect1,
      date1,
      dateAndTime1,
      time1,
    ]);
  }

  @override
  void onSubmitting() async {
    try {
      await Future<void>.delayed(Duration(milliseconds: 500));

      emitSuccess(canSubmitAgain: true);
    } catch (e) {
      emitFailure();
    }
  }

  @override
  void submit(){
    print("Submitting the form!");
    //db.addDive(user, testDive);
  }
}

class SingleDiveScreen extends StatelessWidget {
  static const id = "single_dive_screen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllFieldsFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<AllFieldsFormBloc>(context);

          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Scaffold(
              appBar: AppBar(
              backgroundColor: Theme.of(context).canvasColor,
              title: Text(
                'Divemate',
                style: TextStyle(fontFamily: 'Billabong', fontSize: 38.0),
              ),
              centerTitle: true,
              ),
              floatingActionButton: floatingButton(
                    () => formBloc.submit(), "assets/icons/log.png"),

              body: FormBlocListener<AllFieldsFormBloc, String, String>(
                onSubmitting: (context, state) {
                  LoadingDialog.show(context);
                },
                onSuccess: (context, state) {
                  LoadingDialog.hide(context);

                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => SuccessScreen()));
                },
                onFailure: (context, state) {
                  LoadingDialog.hide(context);

                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text(state.failureResponse)));
                },
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.divesite,
                          decoration: InputDecoration(
                            labelText: 'Divesite',
                            prefixIcon: Icon(Icons.text_fields),
                          ),
                        ),

                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.description,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            prefixIcon: Icon(Icons.text_fields),
                          ),
                        ),

                        // DateTimeFieldBlocBuilder(
                        //   dateTimeFieldBloc: formBloc.date1,
                        //   format: DateFormat('dd-mm-yyyy'),
                        //   initialDate: DateTime.now(),
                        //   firstDate: DateTime(1900),
                        //   lastDate: DateTime(2100),
                        //   decoration: InputDecoration(
                        //     labelText: 'Date',
                        //     prefixIcon: Icon(Icons.calendar_today),
                        //     helperText: 'Date',
                        //   ),
                        // ),

                        DateTimeFieldBlocBuilder(
                          dateTimeFieldBloc: formBloc.dateAndTime1,
                          canSelectTime: true,
                          format: DateFormat('EEE mm/dd/yy --- h:mma'),
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                          decoration: InputDecoration(
                            labelText: 'When did you take the plunge?',
                            prefixIcon: Icon(Icons.date_range),
                            //helperText: 'Date and Time',
                          ),
                        ),

                        DropdownFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.select1,
                          decoration: InputDecoration(
                            labelText: 'What are you diving for?',
                            prefixIcon: Icon(Icons.sentiment_very_satisfied),
                          ),
                          itemBuilder: (context, value) => value,
                        ),

                        RadioButtonGroupFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.select2,
                          decoration: InputDecoration(
                            labelText: 'RadioButtonGroupFieldBlocBuilder',
                            prefixIcon: SizedBox(),
                          ),
                          itemBuilder: (context, item) => item,
                        ),

                        CheckboxGroupFieldBlocBuilder<String>(
                          multiSelectFieldBloc: formBloc.multiSelect1,
                          itemBuilder: (context, item) => item,
                          decoration: InputDecoration(
                            labelText: 'CheckboxGroupFieldBlocBuilder',
                            prefixIcon: SizedBox(),
                          ),
                        ),

                        

                        TimeFieldBlocBuilder(
                          timeFieldBloc: formBloc.time1,
                          format: DateFormat('hh:mm a'),
                          initialTime: TimeOfDay.now(),
                          decoration: InputDecoration(
                            labelText: 'TimeFieldBlocBuilder',
                            prefixIcon: Icon(Icons.access_time),
                          ),
                        ),
                        SwitchFieldBlocBuilder(
                          booleanFieldBloc: formBloc.boolean2,
                          body: Container(
                            alignment: Alignment.centerLeft,
                            child: Text('CheckboxFieldBlocBuilder'),
                          ),
                        ),
                        CheckboxFieldBlocBuilder(
                          booleanFieldBloc: formBloc.boolean1,
                          body: Container(
                            alignment: Alignment.centerLeft,
                            child: Text('CheckboxFieldBlocBuilder'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          );
        },
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  LoadingDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: EdgeInsets.all(12.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  SuccessScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.tag_faces, size: 100),
            SizedBox(height: 10),
            Text(
              'Success',
              style: TextStyle(fontSize: 54, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacementNamed(HomeScreen.id),
              icon: Icon(Icons.replay),
              label: Text('AGAIN'),
            ),
          ],
        ),
      ),
    );
  }
}












// class SingleDiveScreen extends StatefulWidget {
//   static final String id = 'single_dive_screen';

//   @override
//   _SingleDiveScreenState createState() => _SingleDiveScreenState();
// }

// class _SingleDiveScreenState extends State<SingleDiveScreen> {
  
  
  
  
  
//   LatLng currentPosition = LatLng(0, 0);
//   Completer<GoogleMapController> _controller = Completer();




//   /// Determine the current position of the device.
//   ///
//   /// When the location services are not enabled or permissions
//   /// are denied the `Future` will return an error.
//   Future<Position> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     print("service enabled $serviceEnabled");
//     if (!serviceEnabled) {
//       // Location services are not enabled don't continue
//       // accessing the position and request users of the 
//       // App to enable the location services.
//       return Future.error('Location services are disabled.');
//     }

//     permission = await Geolocator.checkPermission();
//     print("Permission $permission");
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // Permissions are denied, next time you could try
//         // requesting permissions again (this is also where
//         // Android's shouldShowRequestPermissionRationale 
//         // returned true. According to Android guidelines
//         // your App should show an explanatory UI now.
//         return Future.error('Location permissions are denied');
//       }
//     }
    
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately. 
//       return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.');
//     } 

//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     return await Geolocator.getCurrentPosition();
//   }

//   Future<void> _setCurrentLocation() async{
//     print("111!!!");
//     Position p = await _determinePosition();
//     print("222!!!");
//     final GoogleMapController controller = await _controller.future;
//     print("333!!!");
//     controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(p.latitude, p.longitude))));
//   }
  
  
//   @override
//   Widget build(BuildContext context) {
//     Map args = ModalRoute.of(context).settings.arguments as Map;
//     args ??= {'title':'Title', 'description': 'Description'};
    
//     final title = args['title'];
//     final description = args['description'];

//     final CameraPosition _kGooglePlex = CameraPosition(
//       target: currentPosition,
//       zoom: 10,
//     );

//     return Scaffold(
//       appBar: AppBar(
//       backgroundColor: Theme.of(context).canvasColor,
//       title: Text(
//         'Divemate',
//         style: TextStyle(fontFamily: 'Billabong', fontSize: 38.0),
//       ),
//       centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             children: [
//               TextFieldBloc(),
//               Text(description),
//               Text("Gear"),
//               Text("Buddy"),
//               Text("Dive No."),
//               Text("Dive Site"),

//               // SizedBox(
//               //   height: 200,
//               //   width: 200,
//               //   child: GoogleMap(
//               //     mapType: MapType.normal,
//               //     initialCameraPosition: _kGooglePlex,
//               //     zoomControlsEnabled: false,
//               //     onMapCreated: (GoogleMapController controller) {
//               //       _controller.complete(controller);
//               //       _setCurrentLocation();
//               //     },
//               //   ),
//               // ),
//               // SizedBox(
//               //   //width: 200,
//               //   //height: 400,
//               //   child: SearchMapPlaceWidget(
//               //     apiKey: "AIzaSyA2yRBj6DxW3ujkpoSDKKASBHVv_hW2uj4",
//               //     location: null,
//               //     radius: 10,
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }