import 'dart:math';
import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

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
  final String currentUserId = Random().nextInt(100000).toString();
  int userCoins = 1500;

  final List<Map<String, dynamic>> hosts = [
    {
      'id': 'host_priya_101',
      'name': 'Priya',
      'age': 22,
      'country': 'India 🇮🇳',
      'rate': 500,
      'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500',
      'isOnline': true,
    },
    {
      'id': 'host_ananya_102',
      'name': 'Ananya',
      'age': 24,
      'country': 'India 🇮🇳',
      'rate': 500,
      'image': 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=500',
      'isOnline': true,
    },
    {
      'id': 'host_sneha_103',
      'name': 'Sneha',
      'age': 21,
      'country': 'India 🇮🇳',
      'rate': 500,
      'image': 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?w=500',
      'isOnline': true,
    },
    {
      'id': 'host_kavya_104',
      'name': 'Kavya',
      'age': 23,
      'country': 'India 🇮🇳',
      'rate': 500,
      'image': 'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?w=500',
      'isOnline': true,
    },
  ];

  void _joinCallRoom(String callID) {
    if (userCoins < 500) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Insufficient coins! Please recharge.")),
      );
      return;
    }

    setState(() {
      userCoins -= 500;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LiveCallPage(
          callID: callID,
          userId: currentUserId,
          userName: "User_$currentUserId",
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
          Container(
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
              ],
            ),
          )
        ],
      ),
      body: GridView.builder(
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
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "Online",
                      style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
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
                      Text(host['country'], style: const TextStyle(fontSize: 12, color: Colors.white70)),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () => _joinCallRoom(host['id']),
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
                              Text("Call Now", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF05D9E8),
        onPressed: () => _joinCallRoom("quick_match_room_global"),
        icon: const Icon(Icons.bolt, color: Colors.black),
        label: const Text(
          "Quick Match",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class LiveCallPage extends StatelessWidget {
  final String callID;
  final String userId;
  final String userName;

  const LiveCallPage({
    super.key,
    required this.callID,
    required this.userId,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
        appID: 2126253184,
        appSign: '5b25a12743252d123b99c63d08019c6b8d33e29c0b23ab35602ce009e29165bc',
        userID: userId,
        userName: userName,
        callID: callID,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
      ),
    );
  }
}
