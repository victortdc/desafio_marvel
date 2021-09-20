import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:desafio_marvel/app/components/widgets.dart';
import 'package:desafio_marvel/app/models/comics_model.dart';
import 'comics_controller.dart';

class ComicsPage extends StatefulWidget {
  final String title;
  final String id;
  const ComicsPage({Key key, this.title = "Comics", this.id}) : super(key: key);

  @override
  _ComicsPageState createState() => _ComicsPageState();
}

class _ComicsPageState extends ModularState<ComicsPage, ComicsController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    //var comicsList = controller.comicsByChar(widget.id);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
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
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('lib/app/assets/wallpaper.jpg'),
                    fit: BoxFit.cover)),
            child: FutureBuilder(
              future: controller.comicsByChar(widget.id),
              builder: (_, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return Components.loading();
                    break;
                  case ConnectionState.none:
                    return Components.error("No connection has been made");
                    break;
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return Components.error(snapshot.error.toString());
                    }
                    if (!snapshot.hasData) {
                      return Components.error("No data");
                    } else {
                      return Container(
                        child: results(snapshot.data),
                      );
                    }
                }
              },
            )));
  }

  Widget results(List<Comics> comics) {
    return ListView.builder(
      itemCount: comics.length,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            //color: Color(0xff1011334),
            color: Colors.white70,
            child: ListTile(
              leading: Container(
                width: 50,
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage('${comics[index].thumbnail.path}' +
                            '.${comics[index].thumbnail.ext}'))),
              ),
              title: Text('${comics[index].title}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'ComicRegular')),
              subtitle: Text('Pages: ${comics[index].pageCount}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'ComicRegular')),
            ),
          ),
        );
      },
    );
  }
}
