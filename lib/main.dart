import'package:flutter/material.dart';

void main(){
    runApp(const PerpustakaanApp());
}

//=================
//DATA BUKU
//================

//DATA BUKU
final List<Map<String, dynamic>>buku = [
{
    'judul': 'Laskar Pelangi',
    'pengarang':'Andrea Hirata',
    'tahun': '2005',
    'rating': 4.8,
    'tersedia': true,
    'genre':'Novel',
    'gambar' : 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=500'
},

{
    'judul':'Bumi',
    'pengarang':'Tere Liye',
    'tahun': 2014,
    'rating': 4.5,
    'tersedia': true,
    'genre': 'fantasi',
    'gambar':  'https://images.unsplash.com/photo-1543002588-bfa74002ed7e?w=500',
},

{
    'judul':'Negeri 5 Menara',
    'pengarang': 'Ahmad Fuadi',
    'tahun': 2009,
    'rating': 4.2,
    'genre': 'novel',
    'gambar': 'https://images.unsplash.com/photo-1495446815901-a7297e633e8d?w=500',
},

 {
    'judul': 'Atomic Habits',
    'pengarang': 'James Clear',
    'tahun': 2018,
    'rating': 4.7,
    'tersedia': true,
    'genre': 'Self Development',
    'gambar':
        'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=500',
  },
  {
    'judul': 'Clean Code',
    'pengarang': 'Robert C. Martin',
    'tahun': 2008,
    'rating': 3.9,
    'tersedia': false,
    'genre': 'Teknologi',
    'gambar':
        'https://images.unsplash.com/photo-1516979187457-637abb4f9353?w=500',
  },
  {
    'judul': 'Filosofi Teras',
    'pengarang': 'Henry Manampiring',
    'tahun': 2018,
    'rating': 4.0,
    'tersedia': true,
    'genre': 'Filsafat',
    'gambar':
        'https://images.unsplash.com/photo-1519682337058-a94d519337bc?w=500',
  },
];

// FUNGSI RATING
String kategoriRating(double rating) {
  if (rating >= 4.5) {
    return 'Sangat Baik';
  } else if (rating >= 3.5) {
    return 'Baik';
  } else {
    return 'Cukup';
  }
}

// APLIKASI UTAMA
class PerpustakaanApp extends StatelessWidget {
  const PerpustakaanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Perpustakaan Mini',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
      ),
      home: const HalamanUtama(),
    );
  }
}

// HALAMAN UTAMA
class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  String pencarian = '';

  @override
  Widget build(BuildContext context) {
    final hasil = buku.where((b) {
      return b['judul']
          .toString()
          .toLowerCase()
          .contains(pencarian.toLowerCase());
    }).toList();

    final Set<String> genreUnik =
        buku.map((b) => b['genre'].toString()).toSet();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF6C63FF),
                    Color(0xFF8B80F9),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Perpustakaan Mini',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Temukan buku favoritmu 📚',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    onChanged: (nilai) {
                      setState(() {
                        pencarian = nilai;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Cari judul buku...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // KATEGORI / GENRE
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Kategori Buku',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 45,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: genreUnik.map((genre) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Chip(
                      label: Text(genre),
                      backgroundColor: const Color(0xFFE9E7FF),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 5),

            // DAFTAR BUKU
            Expanded(
              child: hasil.isEmpty
                  ? const Center(
                      child: Text(
                        'Buku tidak ditemukan',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: hasil.length,
                      itemBuilder: (context, index) {
                        final b = hasil[index];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 15),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(18),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      HalamanDetail(buku: b),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      b['gambar'] as String,
                                      width: 90,
                                      height: 120,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          width: 90,
                                          height: 120,
                                          color: Colors.deepPurple.shade50,
                                          child: const Icon(
                                            Icons.menu_book,
                                            size: 40,
                                            color: Color(0xFF6C63FF),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          b['judul'] as String,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          b['pengarang'] as String,
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          '${b['tahun']} • ${b['genre']}',
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${b['rating']}',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Flexible(
                                              child: Text(
                                                kategoriRating(
                                                  (b['rating'] as num)
                                                      .toDouble(),
                                                ),
                                                style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: b['tersedia'] as bool
                                                ? Colors.green
                                                : Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            b['tersedia'] as bool
                                                ? 'Tersedia'
                                                : 'Dipinjam',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// HALAMAN DETAIL
class HalamanDetail extends StatefulWidget {
  final Map<String, dynamic> buku;

  const HalamanDetail({
    super.key,
    required this.buku,
  });

  @override
  State<HalamanDetail> createState() => _HalamanDetailState();
}

class _HalamanDetailState extends State<HalamanDetail> {
  String? catatanPeminjam;

  @override
  Widget build(BuildContext context) {
    final b = widget.buku;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Buku'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                b['gambar'] as String,
                width: 220,
                height: 290,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 220,
                    height: 290,
                    color: Colors.deepPurple.shade50,
                    child: const Icon(
                      Icons.menu_book,
                      size: 80,
                      color: Color(0xFF6C63FF),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              b['judul'] as String,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              b['pengarang'] as String,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoBuku(
                  icon: Icons.calendar_month,
                  text: '${b['tahun']}',
                ),
                InfoBuku(
                  icon: Icons.star,
                  text: '${b['rating']}',
                ),
                InfoBuku(
                  icon: Icons.category,
                  text: b['genre'] as String,
                ),
              ],
            ),
            const SizedBox(height: 25),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: b['tersedia'] as bool
                    ? Colors.green.shade100
                    : Colors.red.shade100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                b['tersedia'] as bool
                    ? '📗 Buku tersedia'
                    : '📕 Buku sedang dipinjam',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: b['tersedia'] as bool
                      ? Colors.green.shade800
                      : Colors.red.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Catatan Peminjam',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                catatanPeminjam ?? 'Tidak ada catatan',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// WIDGET INFORMASI
class InfoBuku extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoBuku({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: const Color(0xFF6C63FF),
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
