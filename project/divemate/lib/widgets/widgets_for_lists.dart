import 'package:divemate/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';

Widget floatingButton(Function _fun, String _img) {
  /*
    @params
    _fun: onPressed function of button
    _img: path to image for button text

    @returns
    a FloatingActionButton widget

    */

  return FloatingActionButton.extended(
    backgroundColor: const Color(0xffa9cfd8),
    foregroundColor: Colors.black,
    onPressed: _fun,
    label: RichText(
      text: TextSpan(children: [
        WidgetSpan(
          child: Icon(
            Icons.add,
            size: 24,
          ),
        ),
        WidgetSpan(
          child: ImageIcon(
            AssetImage(_img),
            size: 24,
          ),
        ),
      ]),
    ),
  );
}

final db = DatabaseService(); // Need this here to remove a dive/document

Widget customListViewDives(dynamic _arr, User user, BuildContext context) {
  /*
    @params
    _arr: list of the tiles (dives or docs, etc.)

    @returns
    a ListView widget

    */

  deleteTile(int index) {
    db.removeDive(user, _arr[index].id);
    Toast.show("Successfully Deleted", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  // TODO: Have to sort _arr when actual dives are logged, so latest dive is on top
  return ListView.separated(
    padding: const EdgeInsets.all(8),
    itemCount: _arr.length,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        tileColor: Color(0xff7499a1),
        leading: Icon(
          // users image should go here
          Icons.image,
          size: 60,
        ),
        title: Text(_arr[index].location),
        subtitle: Text(
          "COMMENT FROM DIVE HERE ${_arr[index].comment}",
        ),
        trailing: IconButton(
          onPressed: () => deleteTile(index),
          icon: Icon(Icons.delete_forever),
        ),
        isThreeLine: true,
      );
    },
    separatorBuilder: (BuildContext context, int index) => Divider(),
  );
}

// IMPORTANT: Need a second Listview for documents since they have different properties
Widget customListViewDocuments(dynamic _arr, User user, BuildContext context) {
  /*
    @params
    _arr: list of the tiles (dives or docs, etc.)

    @returns
    a ListView widget

    */

  deleteTile(int index) {
    db.removeDocument(user, _arr[index].id);
    Toast.show("Successfully Deleted", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  // TODO: Have to sort _arr when actual dives are logged, so latest dive is on top
  return ListView.separated(
    padding: const EdgeInsets.all(8),
    itemCount: _arr.length,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        // tileColor: Color(0xffd8b7a9),
        tileColor: Color(0xffbdc3c7),
        leading: Icon(
          // document image should go here
          Icons.image,
          size: 60,
        ),
        title: Text(_arr[index].name),
        subtitle: Text(
          "INFO ON DOCUMENT HERE ${_arr[index].comment}",
        ),
        trailing: IconButton(
          onPressed: () => deleteTile(index),
          icon: Icon(Icons.delete_forever),
        ),
        isThreeLine: true,
      );
    },
    separatorBuilder: (BuildContext context, int index) => Divider(),
  );
}
