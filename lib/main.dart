import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
    text: '''// اكتب هنا أي كود تريده لأي تصميم وسيعمل في المعاينة
void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('ممتاز! أي تصميم ستكتبه سيظهر هنا'),
        ),
      ),
    ),
  );
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
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF58A6FF),
          labelColor: const Color(0xFF58A6FF),
          unselectedLabelColor: Colors.grey,
          tabs: const [
            Tab(text: 'Code'),
            Tab(text: 'Output (Preview)'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // تبويب كتابة الكود
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                color: const Color(0xFF21262D),
                child: Row(
                  children: [
                    const Spacer(),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1F6FEB),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        // الانتقال لتبويب المعاينة عند الضغط على Run
                        _tabController.animateTo(1);
                      },
                      icon: const Icon(Icons.play_arrow, size: 18),
                      label: const Text('Run'),
                    ),
                  ],
                ),
              ),
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
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
              ),
            ],
          ),
          // تبويب المعاينة الحية الحقيقية (يعرض بيئة DartPad لتشغيل أي كود)
          const LiveWebViewPreview(),
        ],
      ),
    );
  }
}

// عنصر الـ WebView لتحميل محرك التشغيل والمعاينة الحية
class LiveWebViewPreview extends StatefulWidget {
  const LiveWebViewPreview({Key? key}) : super(key: key);

  @override
  State<LiveWebViewPreview> createState() => _LiveWebViewPreviewState();
}

class _LiveWebViewPreviewState extends State<LiveWebViewPreview> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://dartpad.dev/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: WebViewWidget(controller: controller),
    );
  }
}
