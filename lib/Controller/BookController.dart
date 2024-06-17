import 'dart:convert';

import 'package:get/get.dart';

import '../Utilities/SharedPrefUtils.dart';
import '../Utilities/SnackbarUtil.dart';
import '../apiService/api_service.dart';
import '../model/BooksModel.dart';
import 'package:uuid/uuid.dart';

class BookController extends GetxController {
  ApiService apiService = ApiService();
  String? token;

  List<BookModel> books = [];
  var isLoading = false.obs;
  final Uuid uuid = Uuid();

  void getTokenFromSharedPref() async {
    token = await SharedPrefUtil.getStringFromPref('token');
    if (token != null) {
      // Token retrieved successfully, now fetch books
      getAllBooks();
    } else {
      // Handle case where token is not found
      print('Token not found in SharedPreferences');
    }
  }

  void getAllBooks() async {
    try {
      isLoading(true);
      final response = await apiService.getAllBooks(token!);
      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        List<BookModel> fetchedBooks =
            jsonList.map((e) => BookModel.fromJson(e)).toList();
        books.assignAll(fetchedBooks);
      } else {
        print('Failed to fetch books: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching books: $e');
    } finally {
      isLoading(false);
    }
  }

  void handleValidation(String bookName, String author, String rating) {
    if (bookName.isEmpty || author.isEmpty || rating.isEmpty) {
      SnackbarUtil.showSnackBar(Get.context!, "Please fill in all fields");
      return;
    }
  }

  void hitAddBookApi(
      String bookName, String author, String rating, String isbn) async {
    handleValidation(bookName, author, rating);

    try {
      BookModel bookModel = BookModel(
          title: "",
          author: author,
          id: uuid.v4(),
          rating: double.tryParse(rating),
          booksName: bookName,
          ISBN: isbn);
      isLoading(true);
      final response = await apiService.addBook(token!, bookModel);
      if (response.statusCode == 200) {
        SnackbarUtil.showSnackBar(Get.context!, 'Book added successfully!');
        Get.back();
      } else {
        print('Failed to add book: ${response.statusCode}');
        SnackbarUtil.showSnackBar(Get.context!, 'Failed to add book');
      }
    } catch (e) {
      print('Error fetching books: $e');
      SnackbarUtil.showSnackBar(Get.context!, 'Failed to add book $e');
    } finally {
      isLoading(false);
    }
  }

  void hitEditBookApi(String bookName, String author, String rating,
      String isbn, String id) async {
    handleValidation(bookName, author, rating);

    try {
      BookModel bookModel = BookModel(
          title: "",
          author: author,
          id: id,
          rating: double.tryParse(rating),
          booksName: bookName,
          ISBN: isbn);
      isLoading(true);
      final response = await apiService.editBook(id, token!, bookModel);
      if (response.statusCode == 200) {
        SnackbarUtil.showSnackBar(Get.context!, 'Book updated successfully!');
        Get.back();
      } else {
        print('Failed to edit book: ${response.statusCode}');
        SnackbarUtil.showSnackBar(Get.context!, 'Failed to edit book');
      }
    } catch (e) {
      print('Error fetching books: $e');
      SnackbarUtil.showSnackBar(Get.context!, 'Failed to edit book $e');
    } finally {
      isLoading(false);
    }
  }
}
