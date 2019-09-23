import 'package:flutter/material.dart';
import 'dog_model.dart';

//create new statefull class
class AddDogFormPage extends StatefulWidget {
  @override 
  // class will containe our AddDogFromPageState 
  _AddDogFormPageState createState() => _AddDogFormPageState();
}

class _AddDogFormPageState extends State<AddDogFormPage> {
  //one TextEditingController for each form input
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  
  @override
  Widget build(BuildContext context){
    //new page need scafolding
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new dog'),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        color: Colors.black54,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 32.0,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  //insert out text controller
                  controller: nameController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Name the Pup',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    labelText: "Pup's location"
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: "All about the Pup"
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Builder(
                  builder: (context){
                    return RaisedButton(
                      onPressed: ()=>submitPup(context),
                      color: Colors.indigoAccent,
                      child: Text('Submit Pup'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submitPup(BuildContext context){
    if (nameController.text.isEmpty){
      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Pups need name!'),
        ),
      );
    }else if (locationController.text.isEmpty){
      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Where is Pups location!'),
        ),
      );
    } else if (descriptionController.text.isEmpty){
       Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Pups need description!'),
        ),
      );
    } else {
      //create a new dog 
      var newDog = Dog(nameController.text, locationController.text, descriptionController.text);
      Navigator.of(context).pop(newDog);
    }
  }
}

