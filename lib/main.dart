import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File? imagee;

  // ignore: non_constant_identifier_names
  Future<void> pickyImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? temp = await picker.pickImage(source: ImageSource.camera);
    if (temp == null) {
      return;
    } else {
      setState(() {
        imagee = File(temp.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: imagee!=null? Image.file(imagee!):Image.network(
                      "https://th.bing.com/th/id/OIP.avb9nDfw3kq7NOoP0grM4wHaEK?pid=ImgDet&rs=1"),
                ),
                CustomButton(
                  text: "Pick From Camera",
                  icon: Icons.camera,
                  fun: () {
                    pickyImage();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  text: "Pick From Gallery",
                  icon: Icons.browse_gallery,
                  fun: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  late String text;
  late IconData icon;
  late VoidCallback fun;
  CustomButton({
    required this.text,
    required this.icon,
    required this.fun,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 200,
      child: ElevatedButton(
        onPressed: fun,
        child: Row(
          children: [
            Icon(
              icon,
              size: 10,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
