import 'package:biddano/models/phones.dart';
import 'package:biddano/viewmodels/api-viewmodel.dart';
import 'package:biddano/views/common-widgets/activity-indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class APIPage extends StatefulWidget {
  const APIPage({Key? key}) : super(key: key);

  @override
  State<APIPage> createState() => _APIPageState();
}

class _APIPageState extends State<APIPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _unitNameController;

  @override
  void initState() {
    super.initState();
    _unitNameController = TextEditingController();
  }

  Widget _addNewItemForm(
    PhoneModel model,
    APIViewModel vm,
  ) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Unit name',
              textAlign: TextAlign.start,
            ),
            TextFormField(
              controller: _unitNameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Need model name';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  String message = 'Data added';
                  if (vm.updatePhoneList(model, _unitNameController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                      ),
                    );
                    vm.navigationService.goBack();
                  } else {
                    message = "Failed to add data";
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                      ),
                    );
                  }
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  Future _showBottomSheet(
    PhoneModel model,
    APIViewModel vm,
  ) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10.0),
        ),
      ),
      //backgroundColor: Colors.black,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: SingleChildScrollView(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'New Unit',
                ),
                _addNewItemForm(
                  model,
                  vm,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ExpansionPanel _childrenWidget(
    PhoneModel model,
    APIViewModel vm, {
    bool isHeader = false,
  }) {
    return ExpansionPanel(
      isExpanded: model.isExpanded,
      headerBuilder: (context, isOpen) {
        return ListTile(
          contentPadding: isHeader ? null : const EdgeInsets.only(left: 30),
          leading: InkWell(
            onTap: () {
              setState(() {
                model.isExpanded = false;
              });
              _showBottomSheet(model, vm);
            },
            child: const Icon(
              Icons.add_box_outlined,
            ),
          ),
          title: Text('${isHeader ? 'Brand : ' : ''}${model.phoneUnit}'),
          onTap: () {
            setState(() {
              model.isExpanded = !model.isExpanded;
            });
          },
        );
      },
      body: ExpansionPanelList(
        children: model.modelList
            .map((e) => _childrenWidget(
                  e,
                  vm,
                ))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (context) => APIViewModel(),
          child: Consumer<APIViewModel>(
            builder: (context, model, child) => FutureBuilder(
              future: model.phonelist.isEmpty
                  ? model.fetchApiData(
                      context,
                    )
                  : null,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return model.isConnected
                    ? model.phonelist.isEmpty
                        ? activityindicator()
                        : SingleChildScrollView(
                            child: ExpansionPanelList(
                              children: model.phonelist
                                  .map((e) => _childrenWidget(
                                        e,
                                        model,
                                        isHeader: true,
                                      ))
                                  .toList(),
                            ),
                          )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.mobile_off,
                              color: Colors.white,
                            ),
                            Text(
                              'No Internet',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
