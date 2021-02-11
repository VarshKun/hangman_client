import 'package:flutter/material.dart';

class Category extends StatefulWidget { 
  static Set<String> categoryNames = {
    'General',
    'Animals',
    'Foods',
    'Games',
    'Jobs',
    'Objects',
    'Pokemon'
  };

  final ValueChanged<int> onSelectedIndexChanged;

  Category({Key key, this.onSelectedIndexChanged}) : super(key: key);

  @override
  _Category createState() => _Category();
}

class _Category extends State<Category> {

  int selectedIndex = 0;

  Set<String> categoryPaths = {
    'assets/avatars/general.png',
    'assets/avatars/animal.png',
    'assets/avatars/food.png',
    'assets/avatars/games.png',
    'assets/avatars/jobs.png',
    'assets/avatars/objects.png',
    'assets/avatars/pokemon.png'
  };


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 7,
      itemBuilder: (context, index) {
        return Container(
          width: 140,
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: selectedIndex == index ? Colors.black : Colors.white),
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: selectedIndex == index ? 10: 0,
            shadowColor: Colors.black,
            color: selectedIndex == index ? Colors.yellow[700] : Colors.white,
            child: InkWell(
              onTap: () {
                setState(() 
                {
                  selectedIndex = index;    
                  widget.onSelectedIndexChanged(index);           
                });                          
              },
              splashColor: Colors.yellow[700],
              child: Container(
                //color: Colors.black,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      child: Container(
                        //color: Colors.red,
                        //child: InputDecorator(
                          //decoration: (InputDecoration()),
                          child: Text(
                            Category.categoryNames.elementAt(index),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'NunitoBold',
                              color: Colors.blueGrey
                            ),
                          ),
                       // ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5, vertical: 10),
                          child: CircleAvatar(
                              radius: 60,
                              child: Image.asset(
                                  categoryPaths.elementAt(index))),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}