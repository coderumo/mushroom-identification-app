import 'package:flutter/material.dart';

class UserTab extends StatelessWidget {
  const UserTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage('https://via.placeholder.com/150'),
        ),
        const SizedBox(height: 10),
        const Text(
          'Rumeysa Alkaya',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        const Text("Geçmiş Taramalar"),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: SizedBox(
                            width: 300,
                            height: 300,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Hero(
                                    tag: 'image_$index',
                                    child: Image.network(
                                      'https://via.placeholder.com/150',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: ListTile(
                    title: Text('Image ${index + 1}'),
                    leading: const CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage('https://via.placeholder.com/150'),
                    ),
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
