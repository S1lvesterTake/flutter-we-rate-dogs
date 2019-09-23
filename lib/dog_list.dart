//dog_list.dart
// this part want to render listview and builder

import 'package:flutter/material.dart';
import 'dog_card.dart';
import 'dog_model.dart';

class DogList extends StatelessWidget {
  final List<Dog> doggos;
  DogList(this.doggos);

  @override
  Widget build(BuildContext context){
    return _buildList(context);
  }

  ListView _buildList(context){
    return ListView.builder(
      //must have an item count equal to the number of item
      itemCount: doggos.length,
      //a callback that return a widget
      itemBuilder: (context, int){
        //our case, a dogcard for each doggo
        return DogCard(doggos[int]);
      },
    );
  }
}



