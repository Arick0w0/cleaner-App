import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';

class SelectionModal extends StatefulWidget {
  final String initialSelectedValue;
  final ValueChanged<String> onSelected;
  final List<String> items;
  final List<String> recs;

  const SelectionModal({
    Key? key,
    required this.initialSelectedValue,
    required this.onSelected,
    required this.items,
    this.recs = const [], // กำหนดค่าเริ่มต้นให้กับ recs
  }) : super(key: key);

  @override
  _SelectionModalState createState() => _SelectionModalState();
}

class _SelectionModalState extends State<SelectionModal> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialSelectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: ListView.separated(
        itemCount: widget.items.length,
        separatorBuilder: (context, index) => buildDivider(),
        itemBuilder: (context, index) {
          return buildListTile(
            widget.items[index],
            widget.recs.isNotEmpty ? widget.recs[index] : null,
          );
        },
      ),
    );
  }

  Widget buildListTile(String title, String? subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: selectedValue == title
          ? Icon(Icons.check, color: Theme.of(context).primaryColor)
          : null,
      onTap: () {
        setState(() {
          selectedValue = title;
        });
        widget.onSelected(title); // ส่งข้อมูลกลับไปยัง FieldContainer
      },
    );
  }

  Widget buildDivider() {
    return Divider(
      height: 1,
      color: Colors.grey[300],
    );
  }
}
