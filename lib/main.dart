/// main.dart

import 'package:flutter/material.dart';
import 'package:we_rate_dogs/dog_list.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'dog_model.dart';
import 'dog_list.dart';
import 'new_dog_form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// MaterialApp is the base Widget for your Flutter Application
    /// Gives us access to routing, context, and meta info functionality.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'We Rate Dogs',
      // Make all our text default to white
      // and backgrounds default to dark
      theme: ThemeData(brightness: Brightness.dark),
      home: MyHomePage(title: 'We Rate Dogs'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Dog> initialDoggos = []
    ..add(Dog('Ruby', 'Portland, OR, USA',
        'Ruby is a very good girl. Yes: Fetch, loungin\'. No: Dogs who get on furniture.'))
    ..add(Dog('Rex', 'Seattle, WA, USA', 'Best in Show 1999'))
    ..add(Dog('Rod Stewart', 'Prague, CZ',
        'Star good boy on international snooze team.'))
    ..add(Dog('Herbert', 'Dallas, TX, USA', 'A Very Good Boy'))
    ..add(Dog('Buddy', 'North Pole, Earth', 'Self proclaimed human lover.'));
  @override
  Widget build(BuildContext context) {
    /// Scaffold is the base for a page.
    /// It gives an AppBar for the top,
    /// Space for the main body, bottom navigation, and more.
    return Scaffold(
      
      appBar: GradientAppBar(
        title: Text(widget.title),
        backgroundColorStart: Colors.black12,
        backgroundColorEnd: Colors.black26,
        // actions:[
        //   IconButton(
        //     icon: Icon(Icons.add),
        //     onPressed: _showNewDogForm,
        //   ),
        // ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNewDogForm,
        child: Icon(
          Icons.add,
          color: Colors.white70,
          ),
        backgroundColor: Colors.lightBlue,
      ),

      /// Container is a convenience widget that lets us style it's
      /// children. It doesn't take up any space itself, so it
      /// can be used as a placeholder in your code.
      body: Container(
        //create gradient decoration
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue, Colors.red],
          ),
        ),
        child: Center(
          child: DogList(initialDoggos),
        ),
      ),
    );
  }

  Future _showNewDogForm()async{
    Dog newDog = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context){
          return AddDogFormPage();
        },
      ),
    );
    // A null check, to make sure that the user didn't abandon the form.
    if (newDog != null){
      // Add a newDog to our mock dog array.
      initialDoggos.add(newDog);
    }
  }

}
