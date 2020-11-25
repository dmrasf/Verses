import 'package:flutter/material.dart';
import 'package:Verses/contants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: size.height * 0.08,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29),
      ),
      child: Center(
        child: this.child,
      ),
    );
  }
}

class DropContainer extends StatefulWidget {
  final Function setDynasty;

  DropContainer({Key key, this.setDynasty}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DropContainerState();
  }
}

class _DropContainerState extends State<DropContainer> {
  String dropdownValue = '汉';

  @override
  Widget build(BuildContext context) {
    widget.setDynasty(dropdownValue);
    return TextFieldContainer(
      child: DropdownButton<String>(
        value: dropdownValue,
        isExpanded: true,
        style: TextStyle(color: Colors.deepPurple, textBaseline: TextBaseline.alphabetic),
        underline: Container(
          height: 0,
        ),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: createDynasties(),
      ),
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
