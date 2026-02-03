import 'package:flutter/material.dart';

class ThreadsPreview extends StatefulWidget {
  const ThreadsPreview({super.key});

  @override
  State<ThreadsPreview> createState() => _ThreadsPreviewState();
}

class _ThreadsPreviewState extends State<ThreadsPreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Thread Preview",
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PostCard(),
            
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  "Replies",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 6,
              ),
              SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => ListTile(
                      isThreeLine: true,
                      title: Text("Rayyan"),
                      subtitle: Text("😎😎😎😎😎😎"),
                      trailing: Text("4 days ago"),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://images.pexels.com/photos/8597551/pexels-photo-8597551.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                      ),
                    ),
                    itemCount: 2,
                  ),
                ),
              ),
            ],
          ),
        ));
 
  }
}
