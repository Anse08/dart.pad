import 'package:flutter/material.dart';

void main() => runApp(const DartPadApp());

class DartPadApp extends StatelessWidget {
  const DartPadApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D1117),
        primaryColor: const Color(0xFF1F6FEB),
      ),
      home: const DartPadScreen(),
    );
  }
}

class DartPadScreen extends StatefulWidget {
  const DartPadScreen({Key? key}) : super(key: key);

  @override
  State<DartPadScreen> createState() => _DartPadScreenState();
}

class _DartPadScreenState extends State<DartPadScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _codeController = TextEditingController(
    text: '''void main() {
  print('Hello, DartPad!');
}''',
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF161B22),
        elevation: 0,
        title: Row(
          children: const [
            Icon(Icons.code, color: Color(0xFF58A6FF)),
            SizedBox(width: 8),
            Text('DartPad', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: () {}),
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF58A6FF),
          labelColor: const Color(0xFF58A6FF),
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'Code'),
            Tab(text: 'Output'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // شاشة تبويب الكود
          Column(
            children: [
              // شريط الأدوات العلوي مع زر التشغيل
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                color: const Color(0xFF21262D),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.help_outline, size: 20, color: Colors.grey),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, size: 20, color: Colors.grey),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.format_align_left, size: 20, color: Colors.grey),
                      onPressed: () {},
                    ),
                    const Spacer(),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1F6FEB),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        // الانتقال تلقائياً لتبويب Output عند الضغط على تشغيل
                        _tabController.animateTo(1);
                      },
                      icon: const Icon(Icons.play_arrow, size: 18),
                      label: const Text('Run'),
                    ),
                  ],
                ),
              ),
              // مساحة كتابة وتحرير الكود
              Expanded(
                child: Container(
                  color: const Color(0xFF0D1117),
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _codeController,
                    maxLines: null,
                    expands: true,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      color: Color(0xFFE6EDF3),
                      fontSize: 14,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // شاشة تبويب النتائج والمخرجات (Output)
          Container(
            color: const Color(0xFF0D1117),
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Running...\nHello, DartPad!',
              style: TextStyle(
                fontFamily: 'monospace',
                color: Color(0xFF7EE787),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
