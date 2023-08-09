import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  @override
  Widget build(BuildContext context) {
    Stream<String> getLoadingMessages() {
      final messages = <String>[
        "Cargando Peliculas",
        "Mejores Peliculas",
        "Peliculas Recomendada",
        "Peliculas en Cine",
        "Ultimas Peliculas",
        "Esto esta tardando mas de lo esperados"
      ];

      return Stream.periodic(
        const Duration(milliseconds: 1200),
        (computationCount) {
          return messages[computationCount];
        },
      ).take(messages.length);
    }

    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("Espere"),
        const SizedBox(
          height: 10,
        ),
        const CircularProgressIndicator(
          strokeWidth: 2,
        ),
        const SizedBox(
          height: 10,
        ),
        StreamBuilder(
          stream: getLoadingMessages(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text("Cargando...");

            return Text(snapshot.data!);
          },
        )
      ]),
    );
  }
}
