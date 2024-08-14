import 'package:flutter/material.dart';

class TreeNodeCustom {
  final Widget content;
  final List<TreeNodeCustom> children;

  TreeNodeCustom({
    required this.content,
    this.children = const [],
  });
}

class TreeViewCustom extends StatelessWidget {
  final List<TreeNodeCustom> nodes;

  const TreeViewCustom({
    super.key,
    required this.nodes,
  });

  @override
  Widget build(BuildContext context) {
    return buildNodes(nodes);
  }
}

class NodeWidget extends StatefulWidget {
  final TreeNodeCustom treeNode;

  const NodeWidget({
    super.key,
    required this.treeNode,
  });

  @override
  State<NodeWidget> createState() => _NodeWidgetState();
}

class _NodeWidgetState extends State<NodeWidget> {
  bool isExpanded = false;

  void changedExpanded() {
    if (widget.treeNode.children.isNotEmpty) {
      setState(() {
        isExpanded = !isExpanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Visibility(
              visible: widget.treeNode.children.isNotEmpty,
              replacement: const SizedBox(
                width: 24,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: GestureDetector(
                  onTap: changedExpanded,
                  child: Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 24,
                  ),
                ),
              ),
            ),
            widget.treeNode.content,
          ],
        ),
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Container(
              decoration: const BoxDecoration(
                  border: Border(left: BorderSide(color: Colors.grey))),
              child: buildNodes(
                widget.treeNode.children,
              ),
            ),
          )
      ],
    );
  }
}

Widget buildNodes(
  Iterable<TreeNodeCustom> nodes,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (var node in nodes)
        NodeWidget(
          treeNode: node,
        )
    ],
  );
}
