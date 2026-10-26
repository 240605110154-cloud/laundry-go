
import 'package:flutter/material.dart';

const Color primaryGreen = Color(0xFF159D80);
const Color backgroundColor = Color(0xFFF5F8F7);

void main() {
  runApp(const LaundryGoApp());
}

class LaundryGoApp extends StatelessWidget {
  const LaundryGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LaundryGo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryGreen,
        ),
        scaffoldBackgroundColor: backgroundColor,
        fontFamily: 'Roboto',
      ),
      home: const MainPage(),
    );
  }
}

// HALAMAN UTAMA DAN NAVIGASI
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    ServicesPage(),
    OrdersPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        selectedItemColor: primaryGreen,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_laundry_service),
            label: 'Layanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: 'Pesanan',
          ),
        ],
      ),
    );
  }
}

// DATA DUMMY LAYANAN
class LaundryService {
  final String name;
  final String description;
  final int price;
  final IconData icon;

  const LaundryService({
    required this.name,
    required this.description,
    required this.price,
    required this.icon,
  });
}

const List<LaundryService> laundryServices = [
  LaundryService(
    name: 'Cuci Kering',
    description: 'Cuci dan keringkan pakaian',
    price: 7000,
    icon: Icons.local_laundry_service,
  ),
  LaundryService(
    name: 'Cuci Setrika',
    description: 'Pakaian dicuci dan disetrika',
    price: 10000,
    icon: Icons.checkroom,
  ),
  LaundryService(
    name: 'Setrika Saja',
    description: 'Pakaian disetrika hingga rapi',
    price: 5000,
    icon: Icons.iron,
  ),
  LaundryService(
    name: 'Cuci Express',
    description: 'Layanan cepat untuk pakaian',
    price: 15000,
    icon: Icons.bolt,
  ),
];

// HALAMAN 1: BERANDA
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        title: const Text(
          'LaundryGo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Halo, Pelanggan! 👋',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Laundry bersih, hidup lebih praktis.',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),


            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: primaryGreen,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.local_laundry_service,
                    color: Colors.white,
                    size: 42,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Pakaian Bersih Tanpa Ribet!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Pilih layanan laundry favoritmu dengan mudah.',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ServicesPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: primaryGreen,
                    ),
                    child: const Text('Lihat Layanan'),
                  ),
                ],
              ),
            ),


            const SizedBox(height: 28),
            const Text(
              'Layanan Kami',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: ServiceCard(
                    service: laundryServices[0],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ServiceCard(
                    service: laundryServices[1],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
            const Text(
              'Pesanan Terbaru',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),


            ValueListenableBuilder<List<LaundryOrder>>(
              valueListenable: laundryOrders,
              builder: (context, orders, child) {
                if (orders.isEmpty) {
                  return const Text('Belum ada pesanan.');
                }

                final order = orders.last;

                return OrderCard(
                  orderId: order.id,
                  serviceName: order.serviceName,
                  weight: order.weight,
                  status: order.status,
                  total: order.total,
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}

// KARTU LAYANAN YANG DIGUNAKAN ULANG
class ServiceCard extends StatelessWidget {
  final LaundryService service;

  const ServiceCard({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              service.icon,
              color: primaryGreen,
              size: 32,
            ),
            const SizedBox(height: 12),
            Text(
              service.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Rp${service.price}/kg',
              style: const TextStyle(
                color: primaryGreen,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// HALAMAN 2: DAFTAR LAYANAN
class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Layanan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Pilih layanan laundry sesuai kebutuhanmu.',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 16),

          for (final service in laundryServices)
            Card(
              color: Colors.white,
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ServiceDetailPage(
                        service: service,
                      ),
                    ),
                  );
                },

                leading: CircleAvatar(
                  backgroundColor: const Color(0xFFDDF4ED),
                  child: Icon(
                    service.icon,
                    color: primaryGreen,
                  ),
                ),
                title: Text(
                  service.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(service.description),
                trailing: Text(
                  'Rp${service.price}',
                  style: const TextStyle(
                    color: primaryGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ServiceDetailPage extends StatefulWidget {
  final LaundryService service;

  const ServiceDetailPage({
    super.key,
    required this.service,
  });

  @override
  State<ServiceDetailPage> createState() =>
      _ServiceDetailPageState();
}

class _ServiceDetailPageState
    extends State<ServiceDetailPage> {
  int weight = 1;

  int get totalPrice => widget.service.price * weight;

  String formatRupiah(int amount) {
    return 'Rp${amount.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => '.',
    )}';
  }

  void createOrder() {
    final orders = laundryOrders.value;

    final newOrder = LaundryOrder(
      id: 'LG${(orders.length + 1).toString().padLeft(3, '0')}',
      serviceName: widget.service.name,
      weight: '$weight kg',
      status: 'Diproses',
      total: totalPrice,
    );

    laundryOrders.value = [...orders, newOrder];

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(
          Icons.check_circle,
          color: primaryGreen,
          size: 48,
        ),
        title: const Text('Pesanan Berhasil!'),
        content: Text(
          'Nomor: ${newOrder.id}\n'
              'Layanan: ${newOrder.serviceName}\n'
              'Berat: ${newOrder.weight}\n'
              'Total: ${formatRupiah(newOrder.total)}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.pop(context);
            },
            child: const Text('Selesai'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final service = widget.service;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Layanan'),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: const Color(0xFFDDF4ED),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(
                  service.icon,
                  size: 60,
                  color: primaryGreen,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              service.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(service.description),
            const SizedBox(height: 12),
            Text(
              'Harga: ${formatRupiah(service.price)}/kg',
              style: const TextStyle(
                fontSize: 18,
                color: primaryGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 28),

            const Text(
              'Berat Pakaian',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: weight > 1
                      ? () => setState(() => weight--)
                      : null,
                  icon: const Icon(
                    Icons.remove_circle_outline,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Text(
                    '$weight kg',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() => weight++);
                  },
                  icon: const Icon(
                    Icons.add_circle_outline,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFDDF4ED),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Pembayaran'),
                  const SizedBox(height: 8),
                  Text(
                    formatRupiah(totalPrice),
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: primaryGreen,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: createOrder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  'Pesan Sekarang',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// DATA DUMMY PESANAN
class LaundryOrder {
  final String id;
  final String serviceName;
  final String weight;
  final String status;
  final int total;

  const LaundryOrder({
    required this.id,
    required this.serviceName,
    required this.weight,
    required this.status,
    required this.total,
  });
}

final ValueNotifier<List<LaundryOrder>> laundryOrders =
ValueNotifier<List<LaundryOrder>>([
  LaundryOrder(
    id: 'LG001',
    serviceName: 'Cuci Kering',
    weight: '3 kg',
    status: 'Diproses',
    total: 21000,
  ),
  LaundryOrder(
    id: 'LG002',
    serviceName: 'Cuci Setrika',
    weight: '2 kg',
    status: 'Selesai',
    total: 20000,
  ),
]);

// KARTU PESANAN YANG DIGUNAKAN ULANG
class OrderCard extends StatelessWidget {
  final String orderId;
  final String serviceName;
  final String weight;
  final String status;
  final int total;

  const OrderCard({
    super.key,
    required this.orderId,
    required this.serviceName,
    required this.weight,
    required this.status,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFDDF4ED),
          child: Icon(
            Icons.local_laundry_service,
            color: primaryGreen,
          ),
        ),
        title: Text(
          'Pesanan #$orderId',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('$serviceName • $weight'),
        trailing: Text(
          status,
          style: TextStyle(
            color: status == 'Selesai'
                ? Colors.green
                : primaryGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// HALAMAN 3: PESANAN
class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pesanan Saya',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
      ),
      body: ValueListenableBuilder<List<LaundryOrder>>(
        valueListenable: laundryOrders,
        builder: (context, orders, child) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Riwayat dan status pesanan laundry kamu.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 16),
              if (orders.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Text('Belum ada pesanan.'),
                  ),
                ),
              for (final order in orders)
                Card(
                  color: Colors.white,
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.receipt_long,
                              color: primaryGreen,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Pesanan #${order.id}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: order.status == 'Selesai'
                                    ? Colors.green.shade50
                                    : Colors.orange.shade50,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                order.status,
                                style: TextStyle(
                                  color: order.status == 'Selesai'
                                      ? Colors.green.shade700
                                      : Colors.orange.shade800,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                          ],
                        ),
                        const Divider(height: 24),
                        Text('Layanan: ${order.serviceName}'),
                        const SizedBox(height: 6),
                        Text('Berat pakaian: ${order.weight}'),
                        const SizedBox(height: 6),
                        Text(
                          'Total: Rp${order.total}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
