import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const PesuLiveApp());
}

class PesuLiveApp extends StatelessWidget {
  const PesuLiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pesu Live',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F0F1E),
        primaryColor: const Color(0xFFFF2A6D),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFF2A6D),
          secondary: Color(0xFF05D9E8),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int userCoins = 1500;
  int _selectedTab = 0;

  final List<Map<String, dynamic>> hosts = [
    {
      'name': 'Priya',
      'age': 22,
      'country': 'India 🇮🇳',
      'rate': 500,
      'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500',
      'isOnline': true,
    },
    {
      'name': 'Ananya',
      'age': 24,
      'country': 'India 🇮🇳',
      'rate': 500,
      'image': 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=500',
      'isOnline': true,
    },
    {
      'name': 'Sneha',
      'age': 21,
      'country': 'India 🇮🇳',
      'rate': 500,
      'image': 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=500',
      'isOnline': true,
    },
    {
      'name': 'Kavya',
      'age': 23,
      'country': 'India 🇮🇳',
      'rate': 500,
      'image': 'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?w=500',
      'isOnline': false,
    },
  ];

  void _showRechargeDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E1E2F),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Recharge Coins",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 15),
              ListTile(
                tileColor: const Color(0xFF2A2B3D),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                leading: const Icon(Icons.monetization_on, color: Colors.amber, size: 35),
                title: const Text("1,500 Coins", style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text("Ideal for 3 Mins Video Call"),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF2A6D)),
                  onPressed: () {
                    setState(() => userCoins += 1500);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Recharge Successful! 1500 coins added.")),
                    );
                  },
                  child: const Text("₹70", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                tileColor: const Color(0xFF2A2B3D),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                leading: const Icon(Icons.monetization_on, color: Colors.amber, size: 35),
                title: const Text("5,000 Coins", style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text("Special VIP Pack"),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF2A6D)),
                  onPressed: () {
                    setState(() => userCoins += 5000);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Recharge Successful! 5000 coins added.")),
                    );
                  },
                  child: const Text("₹199", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _startCall(Map<String, dynamic> host) {
    if (userCoins < 500) {
      _showRechargeDialog();
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoCallScreen(
          host: host,
          initialCoins: userCoins,
          onCoinsDeducted: (newBalance) {
            setState(() => userCoins = newBalance);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F0F1E),
        elevation: 0,
        title: const Text(
          "Pesu Live",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFFF2A6D)),
        ),
        actions: [
          GestureDetector(
            onTap: _showRechargeDialog,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFFF2A6D), Color(0xFFFF5E7E)]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(Icons.monetization_on, color: Colors.amber, size: 20),
                  const SizedBox(width: 5),
                  Text(
                    "$userCoins",
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(width: 5),
                  const Icon(Icons.add_circle, color: Colors.white, size: 16),
                ],
              ),
            ),
          )
        ],
      ),
      body: _selectedTab == 0 ? _buildDiscoverGrid() : const Center(child: Text("Messages & Profile")),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) => setState(() => _selectedTab = index),
        backgroundColor: const Color(0xFF161626),
        selectedItemColor: const Color(0xFFFF2A6D),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Discover"),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: "Messages"),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF05D9E8),
        onPressed: () => _startCall(hosts[0]),
        icon: const Icon(Icons.bolt, color: Colors.black),
        label: const Text(
          "Quick Match",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildDiscoverGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: hosts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final host = hosts[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(host['image'], fit: BoxFit.cover),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.85)],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: host['isOnline'] ? Colors.green : Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(radius: 3, backgroundColor: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        host['isOnline'] ? "Online" : "Busy",
                        style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                left: 10,
                right: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${host['name']}, ${host['age']}",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      host['country'],
                      style: const TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () => _startCall(host),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [Color(0xFFFF2A6D), Color(0xFFFF5E7E)]),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.videocam, size: 16, color: Colors.white),
                            SizedBox(width: 6),
                            Text("500 / min", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class VideoCallScreen extends StatefulWidget {
  final Map<String, dynamic> host;
  final int initialCoins;
  final Function(int) onCoinsDeducted;

  const VideoCallScreen({
    super.key,
    required this.host,
    required this.initialCoins,
    required this.onCoinsDeducted,
  });

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  late int coins;
  int callDurationSeconds = 0;
  Timer? callTimer;

  @override
  void initState() {
    super.initState();
    coins = widget.initialCoins;
    _startCallCycle();
  }

  void _startCallCycle() {
    callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        callDurationSeconds++;
      });

      if (callDurationSeconds % 60 == 0) {
        if (coins >= 500) {
          setState(() {
            coins -= 500;
          });
          widget.onCoinsDeducted(coins);
        } else {
          _endCallDueToCoins();
        }
      }
    });
  }

  void _endCallDueToCoins() {
    callTimer?.cancel();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Insufficient coins! Call ended.")),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    callTimer?.cancel();
    super.dispose();
  }

  String _formatTimer(int seconds) {
    int m = seconds ~/ 60;
    int s = seconds % 60;
    return "${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(widget.host['image'], fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.35)),
          Positioned(
            top: 40,
            left: 20,
            child: Row(
              children: [
                CircleAvatar(backgroundImage: NetworkImage(widget.host['image'])),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.host['name'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                    Text(_formatTimer(callDurationSeconds), style: const TextStyle(color: Colors.greenAccent, fontSize: 13)),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 45,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const Icon(Icons.monetization_on, color: Colors.amber, size: 18),
                  const SizedBox(width: 5),
                  Text("$coins", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white24,
                  child: IconButton(
                    icon: const Icon(Icons.card_giftcard, color: Colors.amberAccent),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Gift Sent! (Rose 🌹)")),
                      );
                    },
                  ),
                ),
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.redAccent,
                  child: IconButton(
                    icon: const Icon(Icons.call_end, color: Colors.white, size: 30),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white24,
                  child: IconButton(
                    icon: const Icon(Icons.cameraswitch, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

