import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:smartnotestest/router.dart';
import 'package:smartnotestest/ui/helper/app_colors.dart';
import 'package:smartnotestest/ui/helper/app_dimen.dart';
import 'package:smartnotestest/ui/helper/app_spacing.dart';
import 'package:smartnotestest/ui/widget/smartnoteTextfield.dart';
import 'package:zefyr/zefyr.dart';

class TextEditing extends StatefulWidget {
  @override
  _TextEditingState createState() => _TextEditingState();
}

class _TextEditingState extends State<TextEditing> {
  ZefyrController _zefyrController;
  FocusNode _focusNode;
  FocusNode button_node;
  TextEditingController button_controller;

  @override
  void initState() {
    super.initState();
    final document = _loadDocument();
    _zefyrController = ZefyrController(document);
    _focusNode = FocusNode();
    button_node = FocusNode();
    button_controller = TextEditingController();
  }

  _disposeAll() {
    _focusNode.dispose();
    button_node.dispose();
  }

  NotusDocument _loadDocument() {
    final Delta delta = Delta()..insert("Start Typing\n");
    return NotusDocument.fromDelta(delta);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColor.colorLoginScreen,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: AppDimen.V_DIMEN_30,
                  left: AppDimen.H_DIMEN_10,
                  right: AppDimen.H_DIMEN_10,
                  bottom: AppDimen.V_DIMEN_10,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    FlatButton(
                      color: AppColor.colorLoginScreen,
                      child: Container(
                        color: AppColor.colorLoginScreen,
                        height: AppDimen.V_DIMEN_25,
                        width: AppDimen.H_DIMEN_50,
                        child: Image.asset(
                          "assets/cross.png",
                        ),
                      ),
                    ),
                    Text(
                      "Text Editor",
                      style: TextStyle(fontSize: AppDimen.TEXT_SIZE_35),
                    ),
                    FlatButton(
                      color: AppColor.colorLoginScreen,
                      child: Container(
                        height: AppDimen.V_DIMEN_25,
                        width: AppDimen.H_DIMEN_50,
                        child: Image.asset(
                          "assets/tick2.png",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  height: AppDimen.V_DIMEN_450,
                  width: AppDimen.H_DIMEN_360,
                  child: Card(
                    child: ZefyrScaffold(
                      child: ZefyrEditor(
                        physics: ClampingScrollPhysics(),
                        keyboardAppearance: Brightness.dark,
                        autofocus: true,
                        mode: ZefyrMode.edit,
                        padding: EdgeInsets.all(AppDimen.V_DIMEN_10),
                        controller: _zefyrController,
                        focusNode: _focusNode,
                      ),
                    ),
                  ),
                ),
              ),
              AppSpacing.verticalSpace(AppDimen.V_DIMEN_10),
              Padding(
                padding: EdgeInsets.only(
                  left: AppDimen.H_DIMEN_25,
                  top: AppDimen.V_DIMEN_30,
                  right: AppDimen.H_DIMEN_25,
                  bottom: AppDimen.V_DIMEN_25,
                ),
                child: SmartTextField(
                  isButton: true,
                  focusNode: button_node,
                  isButtonwidget: true,
                  textEditingController: button_controller,
                  buttonText: "Transfer file",
                  onTap: () {
                    _disposeAll();
//                Navigator.of(context).pushReplacementNamed(Router.ROUTE_MY_PROFILE);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
