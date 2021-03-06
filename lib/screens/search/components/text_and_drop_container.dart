import 'package:flutter/material.dart';
import 'package:verses/contants.dart';
import 'package:provider/provider.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvide>(
      builder: (context, themeProvider, child) {
        var themeId = themeProvider.value;
        Size size = MediaQuery.of(context).size;
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: size.height * 0.08,
          width: size.width * 0.8,
          decoration: BoxDecoration(
            color: themeColor[themeId]['primaryColor'],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: this.child,
          ),
        );
      },
    );
  }
}

class DropContainer extends StatefulWidget {
  final Function setDynasty;
  final int themeId;

  DropContainer({Key key, this.setDynasty, this.themeId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DropContainerState();
  }
}

class _DropContainerState extends State<DropContainer> {
  String dropdownValue = '秦';

  @override
  Widget build(BuildContext context) {
    widget.setDynasty(dropdownValue);
    return TextFieldContainer(
      child: DropdownButton<String>(
          value: dropdownValue,
          dropdownColor: themeColor[widget.themeId]['primaryColor'],
          isExpanded: true,
          style: TextStyle(
              color: themeColor[widget.themeId]['textColor'].withOpacity(0.4),
              textBaseline: TextBaseline.alphabetic),
          underline: Container(
            height: 0,
          ),
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
            });
          },
          items: createDynasties()),
    );
  }

  List<DropdownMenuItem> createDynasties() {
    return <String>[
      '先秦',
      '秦',
      '汉',
      '隋',
      '隋末唐初',
      '唐',
      '唐末宋初',
      '魏晋',
      '魏晋末南北朝初',
      '南北朝',
      '辽',
      '宋',
      '宋末金初',
      '金',
      '金末元初',
      '宋末元初',
      '元',
      '元末明初',
      '明',
      '明末清初',
      '清',
      '清末民国初',
      '民国末当代初',
      '近现代',
      '当代'
    ].map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
  }
}
