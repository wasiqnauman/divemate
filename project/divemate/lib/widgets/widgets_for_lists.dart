import 'package:divemate/database.dart';
import 'package:divemate/models.dart';
import 'package:divemate/screens/singledive_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:toast/toast.dart';

const months = ["?", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
const buttonColor = Color(0xffa9cfd8);

Widget floatingTextButton(Function _fun, String _text) {
  /**
    @params
    _fun: onPressed function of button
    _img: button text

    @returns
    a FloatingActionButton widget

    */

  return FloatingActionButton.extended(
    backgroundColor: buttonColor,
    foregroundColor: Colors.black,
    onPressed: _fun,
    label: Text(_text),
  );
}


Widget floatingButton(Function _fun, String _img) {
  /**
    @params
    _fun: onPressed function of button
    _img: path to image for button text

    @returns
    a FloatingActionButton widget

    */

  return FloatingActionButton.extended(
    backgroundColor: buttonColor,
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


Widget customListViewDives(List<Dive> _divelist, User user, BuildContext context) {
  /*
    @params
    _divelist: list of the tiles (dives or docs, etc.)

    @returns
    a ListView widget

    */
  
  print("DIVELIST = ${_divelist.toString()}");
  _divelist.sort((Dive a, Dive b)=>a.startDatetime.compareTo(b.startDatetime));

  deleteTile(int index) { 
    db.removeDive(user, _divelist[index].id);
    Toast.show("Successfully Deleted", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  bool isSameDate(int i){
    if(i==0){return true;}
    DateTime a = _divelist[i].startDatetime;
    DateTime b = _divelist[i-1].startDatetime;
    return (a.year == b.year) && (a.month == b.month) && (a.day == b.day);
  }

  final separatorFont = TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade900.withAlpha(190));

  return ListView.separated(
    padding: const EdgeInsets.all(8),
    itemCount: _divelist.length,
    itemBuilder: (BuildContext context, int index) {

      var previewIcon;
      print("Imag!");
      print(_divelist[index].img);
      if(_divelist[index]?.img == null || _divelist[index]?.img == "" || _divelist[index]?.img == "LINK_TO_IMG"){
        previewIcon = Icon(Icons.image, size: 60);
      }
      else{
        previewIcon = Image.network(_divelist[index].img, width: 60, height: 60,);
      }

      

      var listTile = ListTile(
        tileColor: Color(0xff7499a1).withAlpha(110),
        focusColor: Colors.blue.withAlpha(90),
        hoverColor: Colors.blue.withAlpha(90),
        selectedTileColor: Colors.blue.withAlpha(90),

        leading: previewIcon,
        title: Text(_divelist[index].location,),
        subtitle: Text(_divelist[index].comment,),
        trailing: IconButton(
          onPressed: () => deleteTile(index),
          icon: Icon(Icons.delete_forever),
        ),
        isThreeLine: true,
        onTap: (){Navigator.pushNamed(context, SingleDiveScreen.id, arguments: {'dive':_divelist[index]});},
      );
      
      if(index == 0){
        var seprator = Column(
          children: [
            Text(months[_divelist[index].startDatetime.month] + " " + _divelist[index].startDatetime.day.toString() + ", " + _divelist[index].startDatetime.year.toString(),
              style: separatorFont,
            ),
            listTile,
          ],
        );
        return seprator;
      }
      else{
        return listTile;
      }
    },
    separatorBuilder: (BuildContext context, int index){
      if(!isSameDate(index+1)){
        return Column(
          children: [
            Divider(),
            Text(months[_divelist[index+1].startDatetime.month] + " " + _divelist[index+1].startDatetime.day.toString() + ", " + _divelist[index+1].startDatetime.year.toString(),
              style: separatorFont,
            ),
          ],
        ); //Divider(),
      }
      else{
        return Padding(padding: EdgeInsets.all(2),);
      }
    }
  );
}

// IMPORTANT: Need a second Listview for documents since they have different properties
Widget customListViewDocuments(dynamic _doclist, User user, BuildContext context) {
  /*
    @params
    _doclist: list of the tiles (dives or docs, etc.)

    @returns
    a ListView widget

    */

  deleteTile(int index) {
    db.removeDocument(user, _doclist[index].id);
    Toast.show("Document Deleted", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  return ListView.separated(
    padding: const EdgeInsets.all(8),
    itemCount: _doclist.length,
    itemBuilder: (BuildContext context, int index) {

      var previewIcon;
      print(_doclist[index].img);
      if(_doclist[index].img == null){
        previewIcon = Icon(Icons.image, size: 60);
      }
      else{
        previewIcon = Image.network(_doclist[index].img);
      }
      

      return ListTile(
        // tileColor: Color(0xffd8b7a9),
        tileColor: Color(0xffbdc3c7),
        leading: previewIcon,
        title: Text(_doclist[index].name),
        subtitle: Text(
          "${_doclist[index].comment}\nType:",
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
