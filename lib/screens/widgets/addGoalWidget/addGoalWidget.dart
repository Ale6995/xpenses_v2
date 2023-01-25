import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:xpenses_v2/screens/widgets/addGoalWidget/addGoalWidgetController.dart';

class AddGoalWidget extends StatelessWidget {
  DateTime selectedDate = DateTime.now();

  AddGoalWidgetController controller = Get.put(AddGoalWidgetController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddGoalWidgetController>(builder: (controller) {
      return Dialog(
        insetPadding: EdgeInsets.all(30),
        child: Container(
          // alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 20),
                child: AutoSizeText(
                  "Add Goal",
                  maxFontSize: 30,
                  minFontSize: 16,
                ),
              ),
              Container(
                child: Form(
                    child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.all(15),
                        child: TextFormField(
                          validator: validateDescription,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.black)),
                              labelText: 'Description',
                              labelStyle: TextStyle(color: Colors.blueGrey)),
                          controller: controller.descriptionController,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: validateValue,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[0-9 .]")),
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
                              labelStyle: TextStyle(color: Colors.blueGrey)),
                          controller: controller.valueController,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "${controller.selectedDate}".split(' ')[0],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ElevatedButton(
                            onPressed: () =>
                                controller.selectDate(context), // Refer step 3
                            child: Text(
                              'Select date',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
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
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.lightBlueAccent),
                      ),
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

String? validateDescription(String? value) {
  if (value!.length > 20)
    return 'Description must be less than 20 characters';
  else if (value.isEmpty)
    return 'Description can not be empty';
  else
    return null;
}

String? validateCategory(String? value) {
  if (value!.isEmpty)
    return 'Description can not be empty';
  else
    return null;
}

String? validateValue(String? value) {
  if (value!.length > 9)
    return 'Value must be less than \$ 999999.99';
  else if (value.isEmpty)
    return 'Value can not be empty';
  else
    return null;
}
