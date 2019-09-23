import 'package:flutter/material.dart';
import 'dog_model.dart';
import 'dog_detail_page.dart';

class DogCard extends StatefulWidget {
  final Dog dog;

  DogCard(this.dog);

  @override
  _DogCardState createState() => _DogCardState(dog);
}

class _DogCardState extends State<DogCard> {
  Dog dog;
  String renderUrl;

  _DogCardState(this.dog);
 
  @override
  Widget build(BuildContext context) {
    return InkWell(
      //inkwell is as special material widget that make its chidreen tappable
      onTap: showDogDetailPage,
      child:  Padding(
       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
       child: Container(
         height: 115.0,
         child: Stack(
           children: <Widget>[
             Positioned(
               left: 50.0,
               child: dogCard,
             ),
             Positioned(top: 7.5, child: dogImage,)
           ],
         ),
       ),
     ),
    );    
  }

  //the builder method that creates a new page
  showDogDetailPage(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context){
          return DogDetailPage(dog);
        }
      ),
    );
  }

  Widget get dogImage {
   var dogAvatar = Hero(
     tag: dog,
     child: Container(
     width: 100.0,
     height: 100.0,
     decoration: BoxDecoration(
       shape: BoxShape.circle,
       image: DecorationImage(
         fit: BoxFit.cover,
         image: NetworkImage(renderUrl ?? ''),
       ),
     ),
   ),
   );

   //placehodler is static container the same size as the dog image
   var placeholder = Container (
     width: 100.0,
     height: 100.0,
     decoration: BoxDecoration(
       shape: BoxShape.circle,
       gradient: LinearGradient(
         begin: Alignment.topLeft,
         end: Alignment.bottomRight,
         colors: [Colors.black54, Colors.black, Colors.blueGrey[600]],
       ),
     ),
   );

  //this is an animated widget build into flutter
  return AnimatedCrossFade(
    firstChild: placeholder,
    secondChild: dogAvatar,

    crossFadeState: renderUrl == null
    ? CrossFadeState.showFirst
    :CrossFadeState.showSecond,
    //pass the amount of time the fade should it take
    duration: Duration(milliseconds: 1000),
  );

  }

 // State classes run this method when the state is created.
// You shouldn't do async work in initState, so we'll defer it
// to another method.
  void initState() {
    super.initState();
    renderDogPic();
  }

  // IRL, we'd want the Dog class itself to get the image
// but this is a simpler way to explain Flutter basics

  void renderDogPic() async {
    // this make the service call

    await dog.getImageUrl();
    if (mounted) {
      setState(() {
        renderUrl = dog.imageUrl;
      });
    }
  }

  Widget get dogCard{
    // A new container
  // The height and width are arbitrary numbers for styling.
  return Container(
    width: 290.0,
    height: 115.0,
    child: Card(
      color: Colors.black87,
      // Wrap children in a Padding widget in order to give padding.
      child: Padding(
         // The class that controls padding is called 'EdgeInsets'
        // The EdgeInsets.only constructor is used to set
        // padding explicitly to each side of the child.
        padding: const EdgeInsets.only(
          top: 8.0,
          bottom: 8.0,
          left: 64.0,
        ),
         // Column is another layout widget -- like stack -- that
        // takes a list of widgets as children, and lays the
        // widgets out from top to bottom.
        child: Column(
           // These alignment properties function exactly like
          // CSS flexbox properties.
          // The main axis of a column is the vertical axis,
          // `MainAxisAlignment.spaceAround` is equivalent of
          // CSS's 'justify-content: space-around' in a vertically
          // laid out flexbox.
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(widget.dog.name,
            style: Theme.of(context).textTheme.headline,
            ),
            Text(widget.dog.location,
            style: Theme.of(context).textTheme.subhead,
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.star,
                ),
                Text(': ${widget.dog.rating}/10')
              ],
            ),
          ],
        ),
      ),
    ),
  );
  }
}
