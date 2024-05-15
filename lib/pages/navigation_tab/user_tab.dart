import 'package:flutter/material.dart';

class UserTab extends StatelessWidget {
  const UserTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const CircleAvatar(
          radius: 50,
          //pp yükleme
        ),
        const SizedBox(height: 10),
        const Text(
          'Ad Soyad', // Kullanıcının adı ve soyadı
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: 5, // Görsel sayısı
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListTile(
                  title: Text('Image ${index + 1}'),
                  leading: const CircleAvatar(
                    radius: 30,
                    // Görsellerin yolu
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
