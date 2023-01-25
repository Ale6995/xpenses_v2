import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:xpenses_v2/screens/widgets/addExpenseWidget/addExpenseWidgetController.dart';

class AddExpenseWidget extends StatelessWidget {
  AddExpenseWidgetController controller =
      Get.put(AddExpenseWidgetController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddExpenseWidgetController>(builder: (controller) {
      return Dialog(
        insetPadding: EdgeInsets.all(30),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 20),
                child: AutoSizeText(
                  "Add Expense",
                  maxFontSize: 30,
                  minFontSize: 16,
                ),
              ),
              Container(
                child: Form(
                    key: controller.addExpenseKey,
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            margin: EdgeInsets.all(15),
                            child: TextFormField(
                              validator: controller.validateDescription,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.black)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.black)),
                                  labelText: 'Description',
                                  labelStyle:
                                      TextStyle(color: Colors.blueGrey)),
                              controller: controller.descriptionController,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(15),
                            alignment: Alignment.center,
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              validator: controller.validateCategory,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.black)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.black)),
                                  labelStyle:
                                      TextStyle(color: Colors.blueGrey)),
                              items: controller.expenceCategories
                                  .map(
                                    (e) => DropdownMenuItem<String>(
                                      child: Text(e.category),
                                      value: e.category,
                                    ),
                                  )
                                  .toList(),
                              onChanged: (String? value) {
                                controller.saveDropDownValue(value);
                              },
                              hint: Text('Select Category'),
                              value: controller.value,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(15),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: controller.validateValue,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9.]")),
                              ],
                              decoration: InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.black)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          new BorderSide(color: Colors.black)),
                                  labelText: 'value',
                                  labelStyle:
                                      TextStyle(color: Colors.blueGrey)),
                              controller: controller.valueController,
                            ),
                          )
                        ],
                      ),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blueGrey),
                      ),
                      onPressed: () => controller.close(),
                      child: Text("Close"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.lightBlueAccent),
                      onPressed: () => controller.add(),
                      child: Text("Add"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
