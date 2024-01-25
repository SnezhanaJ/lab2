import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ),
      home: const ClothesListScreen(),
    );
  }
}

class ClothesListScreen extends StatefulWidget {
  const ClothesListScreen({super.key});

  @override
  State<ClothesListScreen> createState() => _ClothesListScreenState();
}

class _ClothesListScreenState extends State<ClothesListScreen> {
  final List<Clothes> _clothes = [
    Clothes('Jacket'),
    Clothes('Trousers'),
    Clothes('Jeans'),
    Clothes('Dresses'),
    Clothes('Skirts'),
    Clothes('Blouse'),];

  void addNewCourse(){
    showDialog(context: context, builder: (BuildContext context){
      String newClothes="";
      return AlertDialog(
        title: const Text("Add a new clothes item"),
        content: TextField(
          onChanged: (value){
            newClothes = value;
          },
        ),
        actions: [
          ElevatedButton(onPressed: (){
            setState(() {
              if(newClothes.isNotEmpty){
                _clothes .add(Clothes(newClothes));
              }
              Navigator.pop(context);
            });
          },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Set background color to green
              ),
              child: const Text("Add Clothes Item",   style: TextStyle(color: Colors.red),
              ))
        ],
      );
    });
  }

  void editCourse(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String updatedClothes = _clothes[index].name;
        return AlertDialog(
          title: const Text("Edit Clothes",   style: TextStyle(color: Colors.red),
          ),
          content: TextField(
            controller: TextEditingController(text: updatedClothes),
            onChanged: (value) {
              updatedClothes = value;
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (updatedClothes.isNotEmpty) {
                    _clothes[index].name = updatedClothes;
                  }
                  Navigator.pop(context);
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Set background color to green
              ),
              child: const Text("Update Clothes Item",  style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void deleteCourse(int index) {
    setState(() {
      _clothes.removeAt(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("195002"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Which type of clothing do you choose?",
              style: TextStyle(color: Colors.blue, fontSize: 18.0),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _clothes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    _clothes[index].name,
                    style: TextStyle(color: Colors.red),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => editCourse(index),
                        color: Colors.green,
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => deleteCourse(index),
                        color: Colors.green,
                      ),
                      Checkbox(
                        value: _clothes[index].isSelected,
                        onChanged: (bool? value) {
                          setState(() {
                            _clothes[index].isSelected = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    // Handle tap if needed
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewCourse,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add_box_rounded),
      ),
    );
  }
}
  class Clothes{
  String name;
  bool isSelected;
  Clothes(this.name, {this.isSelected = false});
}


