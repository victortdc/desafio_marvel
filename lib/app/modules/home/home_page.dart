import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:desafio_marvel/app/components/widgets.dart';
import 'package:desafio_marvel/app/models/character_model.dart';
import 'package:mobx/mobx.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  List<Character> favorites = List<Character>();

  TextEditingController controllerText = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  Future<void> showSnackBar(Color color, String content) {
    final snackContent = SnackBar(
      backgroundColor: color,
      duration: Duration(seconds: 2),
      content: Text(
        content,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
    );
    _scaffoldkey.currentState.showSnackBar(snackContent);
  }

  @override
  void initState() {
    super.initState();
    controllerText.text = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      //backgroundColor: Color(0xffed1d24),
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
          ),
        ],
        backgroundColor: Color(0xffed1d24),
        title: Container(
          padding: EdgeInsets.all(5),
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('lib/app/assets/marvel.png'))),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('lib/app/assets/wpp.jpg'),
                fit: BoxFit.cover)),
        child: Column(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.all(10),
                color: Colors.white70,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Observer(
                      builder: (_) {
                        return Theme(
                          data: ThemeData(
                              primaryColor: Color(0xffed1d24),
                              backgroundColor: Colors.grey[200]),
                          child: TextField(
                            controller: controllerText,
                            decoration: InputDecoration(
                                prefixIcon: IconButton(
                                    icon: Icon(Icons.cancel),
                                    onPressed: () {
                                      controllerText.text = '';
                                      controller.search = null;
                                    }),
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.search,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      controller.search = controllerText.text;
                                    }),
                                border: OutlineInputBorder(),
                                labelText: 'Search'),
                          ),
                        );
                      },
                    )),
              ),
            ),
            Observer(
              builder: (_) {
                return FutureBuilder(
                    future: controller.fetchChar(controller.search),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return Components.loading();
                          break;
                        case ConnectionState.none:
                          print('none');
                          return Components.error(
                              "No connection has been made");
                          break;
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return Components.error(snapshot.error.toString());
                          }
                          if (!snapshot.hasData) {
                            print('noData');
                            return Components.error("No data");
                          } else {
                            return Container(
                              child: results(snapshot.data),
                            );
                          }
                      }
                    });
              },
            )
          ],
        ),
      ),
    );
  }

  Widget results(List<Character> list) {
    if (list.isEmpty && controllerText.text != "") {
      return Center(
          child: Container(
              color: Colors.white70,
              child: Text(
                'Nothing Found',
                style: TextStyle(
                    color: Colors.red, fontSize: 20, fontFamily: 'RobotSlab'),
              )));
    }
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          child: Container(
            //color: Colors.grey[200],
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    //color: Color(0xff1011334),
                    color: Colors.white70,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Container(
                            width: 52,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        '${list[index].thumbnail.path}' +
                                            '.${list[index].thumbnail.ext}'))),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text('${list[index].name}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'ComicRegular')),
                          ),
                          subtitle: list[index].description.isEmpty
                              ? Text("No description available",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Marvel',
                                    fontSize: 17,
                                  ))
                              : Text('${list[index].description}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Marvel',
                                    fontSize: 17,
                                  )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: FlatButton(
                            color: Colors.white,
                            onPressed: () {
                              //controller.favorites.add(list[index]);
                              //Modular.to.pushNamed('/favorites');
                              Modular.to.pushNamed('/comics/${list[index].id}');
                            },
                            child: Text(
                              'See comics from this character!',
                              style: TextStyle(
                                  color: Colors.black, fontFamily: 'RobotSlab'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
