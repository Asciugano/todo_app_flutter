import 'package:flutter/material.dart';
import 'package:todo_app_flutter/data/classes/todo_item.dart';
import 'package:todo_app_flutter/data/constraints.dart';
import 'package:todo_app_flutter/data/notifiers.dart';

class TodoItemWidget extends StatefulWidget {
  const TodoItemWidget({super.key, required this.item});

  final TodoItem item;

  @override
  State<TodoItemWidget> createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('cliccato ${widget.item.title}'),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 2),
        width: double.infinity,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Checkbox(
                  tristate: false,
                  value: widget.item.isCompleted,
                  onChanged:
                      (bool? value) => setState(() {
                        widget.item.isCompleted = value!;
                      }),
                ),
                Column(
                  children: [
                    Text(
                      widget.item.title,
                      style: KTextStyle.titleText(
                        themeColorNotifier.value,
                        isCompleted: widget.item.isCompleted,
                      ),
                    ),
                    Text(
                      widget.item.desctiption,
                      style: KTextStyle.descriptionText(
                        isCompleted: widget.item.isCompleted,
                      ),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                if (widget.item.scadenza != null)
                  Text(
                    '${widget.item.scadenza!.day}/${widget.item.scadenza!.month}/${widget.item.scadenza!.year}',
                    style: KTextStyle.descriptionText(
                      isCompleted: widget.item.isCompleted,
                    ),
                  ),
                SizedBox(width: 10),
                Text(
                  widget.item.priorityLevel.label,
                  style: KTextStyle.descriptionText(
                    isCompleted: widget.item.isCompleted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}