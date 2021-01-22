import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody_app/widget/app_bar.dart';

class FindFriendView extends StatefulWidget {
  FindFriendView({Key key}) : super(key: key);

  @override
  _FindFriendViewState createState() => _FindFriendViewState();

}

class _FindFriendViewState extends State<FindFriendView> {

  final duplicateItems = List<String>.generate(10, (i) => "Item $i");
  var items = List<String>();

  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FoodyAppBar(),
      body: new Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: new Padding(
              padding: new EdgeInsets.fromLTRB(15.0, 15.0, 10.0, 8.0),
              child: Text (
                "Find Friends",
                style: new TextStyle(
                  color: Colors.black54,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
              ),
              )
            )
          ),
          new Padding(
            padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
            child: new TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search, color: Colors.black54,),
                hintText: 'Search username',
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black26, width: 2.0),
                    borderRadius: BorderRadius.circular(32.0)
              )
              )
            )
          ),
          Expanded(
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return new ListTile(
                      leading: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 44,
                          minHeight: 44,
                          maxWidth: 44,
                          maxHeight: 44
                        ),
                        child: Image.asset('assets/app_logo.png', fit: BoxFit.contain)
                      ),
                      title: Text('${items[index]}'),
                      trailing: IconButton(
                        icon: Icon(Icons.chevron_right)
                      ),
                  );
                }
            )
          )
        ],
      )
    );
  }
}
