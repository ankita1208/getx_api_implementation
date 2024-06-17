import 'package:api_implementation/Controller/BookController.dart';
import 'package:api_implementation/screens/AddEdit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final BookController bookController = Get.put(BookController());

  @override
  void initState() {
    bookController.getTokenFromSharedPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => const AddEdit(isEdit: false),
              );
            },
            icon: const Icon(
              Icons.add_box_rounded,
              color: Color.fromRGBO(233, 99, 108, 25),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (bookController.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(
                  color: Color.fromRGBO(233, 99, 108, 25)));
        } else if (bookController.books.isEmpty) {
          return const Center(child: Text("No books found."));
        } else {
          return ListView.builder(
            itemCount: bookController.books.length,
            itemBuilder: (context, index) {
              return Card(
                color: const Color.fromRGBO(233, 99, 108, 25),
                margin: const EdgeInsets.all(10), // Adds margin around the card
                elevation: 4, // Elevation for the shadow effect
                child: ListTile(
                  leading: const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  title: Text(
                    bookController.books[index].getRating.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    bookController.books[index].getBooksName!,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Get.to(() => AddEdit(
                        isEdit: true, bookModel: bookController.books[index]));
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}
