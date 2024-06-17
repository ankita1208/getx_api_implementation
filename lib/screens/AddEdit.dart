import 'package:api_implementation/Controller/BookController.dart';
import 'package:api_implementation/apiService/api_service.dart';
import 'package:api_implementation/model/BooksModel.dart';
import 'package:api_implementation/widgets/button.dart';

import 'package:api_implementation/widgets/textfieldwidget.dart';
import 'package:flutter/material.dart';

import '../Utilities/SharedPrefUtils.dart';
import 'package:get/get.dart';

class AddEdit extends StatefulWidget {
  const AddEdit({super.key, required this.isEdit, this.bookModel});

  final bool isEdit;

  // to make the bookmodel not a required parameter
  final BookModel? bookModel;

  @override
  State<StatefulWidget> createState() {
    return _AddEditState();
  }
}

class _AddEditState extends State<AddEdit> {
  late final TextEditingController _idTextEditingController =
      TextEditingController();

  late final TextEditingController _bookTextEditingController =
      TextEditingController();

  late final TextEditingController _authorTextEditingController =
      TextEditingController();

  late final TextEditingController _ratingTextEditingController =
      TextEditingController();

  late bool _isEdit;

  late BookModel _bookModel;

  late ApiService apiService = ApiService();
  String? token;
  final BookController bookController = Get.put(BookController());

  @override
  void initState() {
    _isEdit = widget.isEdit;
    if (_isEdit) {
      _bookModel = widget.bookModel!;
    }
    getTokenFromSharedPref();

    setState(() {
      if (_isEdit) {
        setTextInFields();
      }
    });
  }

  void getTokenFromSharedPref() async {
    token = await SharedPrefUtil.getStringFromPref('token');
  }

  void setTextInFields() {
    _idTextEditingController.text = _bookModel.getIsbn!;
    _bookTextEditingController.text = _bookModel.getBooksName!;
    _authorTextEditingController.text = _bookModel.getAuthor!;
    _ratingTextEditingController.text = _bookModel.getRating!.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (_isEdit)
            IconButton(
              onPressed: () {
                // Add your onPressed logic here
                print('Edit button pressed');
              },
              icon: const Icon(
                Icons.edit,
                color: Color.fromRGBO(233, 99, 108, 25),
              ),
            ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 70.0,
            ),
            TextFieldWidget(
              labelText: 'ISBN',
              textEditingController: _idTextEditingController,
              textInputType: TextInputType.number,
              obscureText: false,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
              labelText: 'Book Name',
              textEditingController: _bookTextEditingController,
              textInputType: TextInputType.text,
              obscureText: false,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
              labelText: 'Author',
              textEditingController: _authorTextEditingController,
              textInputType: TextInputType.text,
              obscureText: false,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWidget(
              labelText: 'Rating',
              textEditingController: _ratingTextEditingController,
              textInputType: TextInputType.number,
              obscureText: false,
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(() => bookController.isLoading.value
                ? const CircularProgressIndicator(
                    color: Color.fromRGBO(233, 99, 108, 25))
                : ButtonWidget(
                    text: _isEdit ? "Update" : "Add",
                    onPressedButton: () {
                      _isEdit
                          ? bookController.hitEditBookApi(
                              _bookTextEditingController.text,
                              _authorTextEditingController.text,
                              _ratingTextEditingController.text,
                              _idTextEditingController.text,
                              _bookModel.getId!)
                          : bookController.hitAddBookApi(
                              _bookTextEditingController.text,
                              _authorTextEditingController.text,
                              _ratingTextEditingController.text,
                              _idTextEditingController.text);
                    },
                  ))
          ],
        ),
      ),
    );
  }
}
