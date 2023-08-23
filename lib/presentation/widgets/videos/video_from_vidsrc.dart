import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class VideoFromVidsrc extends StatelessWidget {
  const VideoFromVidsrc({super.key, required this.url});
  final Uri url;

  Future<void> _launchUrl() async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Pelicula Completa",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: _launchUrl,
            child: const Text('Enlance directo'),
          )
        ],
      ),
    );
  }
}
