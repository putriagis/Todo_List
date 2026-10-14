import 'package:flutter/material.dart';

// ================= 1. TITIK AWAL =================
void main() {
  runApp(const MyApp());
}

// ================= 2. APLIKASI =================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

// ================= 3. MODEL DATA =================
class Tugas {
  String isi;
  bool selesai;

  Tugas({required this.isi, required this.selesai});
}

// ================= 4. HALAMAN UTAMA =================
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // ----- data -----
  List<Tugas> daftarTugas = [];
  TextEditingController inputController = TextEditingController();

  // ----- fungsi -----
  void tambahTugas() {
    String teks = inputController.text.trim();
    if (teks == '') {
      return;
    }

    setState(() {
      daftarTugas.add(Tugas(isi: teks, selesai: false));
    });
    inputController.clear();
  }

  void hapusTugas(int index) {
    setState(() {
      daftarTugas.removeAt(index);
    });
  }

  void ubahCentang(int index) {
    setState(() {
      daftarTugas[index].selesai = !daftarTugas[index].selesai;
    });
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  // ----- tampilan -----
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(111, 255, 5, 159),
        title: const Text('To do list', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: daftarTugas.length,
                itemBuilder: (context, index) {
                  return TaskCard(
                    isi: daftarTugas[index].isi,
                    selesai: daftarTugas[index].selesai,
                    onHapus: () {
                      hapusTugas(index);
                    },
                    onCentang: () {
                      ubahCentang(index);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: inputController,
              decoration: InputDecoration(
                labelText: 'Add New Item',
                labelStyle: const TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                  borderSide: const BorderSide(color: Colors.pink),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                  borderSide: const BorderSide(color: Colors.pink),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: tambahTugas,
        backgroundColor: const Color.fromARGB(255, 255, 4, 197),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// ================= 5. KOMPONEN KARTU TUGAS =================
class TaskCard extends StatelessWidget {
  final String isi;
  final bool selesai;
  final VoidCallback onHapus;
  final VoidCallback onCentang;

  const TaskCard({
    super.key,
    required this.isi,
    required this.selesai,
    required this.onHapus,
    required this.onCentang,
  });

  @override
  Widget build(BuildContext context) {
    double lebarLayar = MediaQuery.of(context).size.width;

    TextDecoration garisCoret = TextDecoration.none;
    if (selesai) {
      garisCoret = TextDecoration.lineThrough;
    }

    return Center(
      child: Container(
        width: lebarLayar * 0.8,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 243, 171, 235),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Checkbox(
              value: selesai,
              activeColor: Colors.black26,
              checkColor: const Color.fromARGB(255, 240, 242, 243),
              onChanged: (nilai) {
                onCentang();
              },
            ),
            Expanded(
              child: Text(
                isi,
                style: TextStyle(fontSize: 16, decoration: garisCoret),
              ),
            ),
            IconButton(icon: const Icon(Icons.delete), onPressed: onHapus),
          ],
        ),
      ),
    );
  }
}
