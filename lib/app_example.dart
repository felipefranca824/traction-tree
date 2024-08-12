import 'package:flutter/material.dart';

import 'src/ui/widgets/tree_node_custom.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tree View Example')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TreeViewCustom(
            nodes: [
              TreeNodeCustom(
                content: const Text('Root'),
                children: [
                  TreeNodeCustom(
                    content: const Text('Location A'),
                    children: [
                      TreeNodeCustom(
                        content: const Text('Location A1'),
                        children: [
                          TreeNodeCustom(content: const Text('Location A1.1')),
                          TreeNodeCustom(content: const Text('Location A1.2')),
                        ],
                      ),
                      TreeNodeCustom(
                        content: const Text('Location A2'),
                        children: [
                          TreeNodeCustom(content: const Text('Location A2.1')),
                          TreeNodeCustom(content: const Text('Location A2.2')),
                        ],
                      ),
                    ],
                  ),
                  TreeNodeCustom(
                    content: const Text('Location B'),
                    children: [
                      TreeNodeCustom(
                        content: const Text('Location B1'),
                        children: [
                          TreeNodeCustom(
                            content: const Text('Location B1.1'),
                            children: [
                              TreeNodeCustom(
                                  content: const Text('Location B1.1.1')),
                              TreeNodeCustom(
                                  content: const Text('Location B1.1.2')),
                            ],
                          ),
                          TreeNodeCustom(content: const Text('Location B1.2')),
                        ],
                      ),
                    ],
                  ),
                  TreeNodeCustom(content: const Text('Location C')),
                ],
              ),
              TreeNodeCustom(
                content: const Text('Root B'),
                children: [
                  TreeNodeCustom(
                    content: const Text('Location A'),
                    children: [
                      TreeNodeCustom(
                        content: const Text('Location A'),
                        children: [
                          TreeNodeCustom(content: const Text('Location A')),
                          TreeNodeCustom(content: const Text('Location A')),
                        ],
                      ),
                      TreeNodeCustom(
                        content: const Text('Location A'),
                        children: [
                          TreeNodeCustom(content: const Text('Location A')),
                          TreeNodeCustom(content: const Text('Location A')),
                        ],
                      ),
                    ],
                  ),
                  TreeNodeCustom(
                    content: const Text('Location A'),
                    children: [
                      TreeNodeCustom(
                        content: const Text('Location A'),
                        children: [
                          TreeNodeCustom(
                            content: const Text('Location A'),
                            children: [
                              TreeNodeCustom(content: const Text('Location A')),
                              TreeNodeCustom(content: const Text('Location A')),
                            ],
                          ),
                          TreeNodeCustom(content: const Text('Location A')),
                        ],
                      ),
                    ],
                  ),
                  TreeNodeCustom(content: const Text('Location A')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
