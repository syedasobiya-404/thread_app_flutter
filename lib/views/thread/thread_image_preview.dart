import 'package:flutter/material.dart';

class ThreadImagePreview extends StatefulWidget {
  const ThreadImagePreview({super.key});

  @override
  State<ThreadImagePreview> createState() => _ThreadImagePreviewState();
}

class _ThreadImagePreviewState extends State<ThreadImagePreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thread Image Preview",
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          child: Image.network(
              "https://images.pexels.com/photos/31391838/pexels-photo-31391838/free-photo-of-breathtaking-coastal-view-in-puerto-de-la-cruz.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
        ),
      ),
    );
  }
}
