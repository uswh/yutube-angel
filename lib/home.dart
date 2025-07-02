import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> videoList = [
      {
        'thumbnail': 'assets/kota.jpg',
        'title': 'Example Video Title',
        'channel': 'Channel Name',
        'time': '6 month ago',
        'duration': '6:22',
      },
      {
        'thumbnail': 'assets/laut.jpg',
        'title': 'Example Video Title',
        'channel': 'Channel Name',
        'time': '6 month ago',
        'duration': '6:22',
      },
      {
        'thumbnail': 'assets/podcast.jpg',
        'title': 'DMS x Ghost Ranger Indonesia',
        'channel': 'Wild Cats',
        'time': '3 days ago',
        'duration': '1:14:49',
      },
      {
        'thumbnail': 'assets/tutorial.jpg',
        'title': 'Full Guide Belajar Coding Untuk Pemula',
        'channel': 'Funny Animals',
        'time': '1 week ago',
        'duration': '19:10',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/yt.jpg',
              width: 100,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.search, color: Colors.black),
            const SizedBox(width: 10),
            const Icon(Icons.mic, color: Colors.black),
            const SizedBox(width: 10),
            const Icon(Icons.notifications, color: Colors.black),
            const SizedBox(width: 10),
            const CircleAvatar(backgroundColor: Colors.grey),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 12),
                  MenuButton(title: 'Home', isSelected: true),
                  MenuButton(title: 'Shorts'),
                  MenuButton(title: 'Subscriptions'),
                  MenuButton(title: 'Library'),
                  SizedBox(width: 12),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: videoList.map((video) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => VideoDetailPage(
                              title: video['title']!,
                              thumbnail: video['thumbnail']!,
                              channel: video['channel']!,
                              time: video['time']!,
                              duration: video['duration']!,
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: 300,
                        child: VideoTile(
                          thumbnailPath: video['thumbnail']!,
                          title: video['title']!,
                          channelName: video['channel']!,
                          timeAgo: video['time']!,
                          duration: video['duration']!,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  const MenuButton({super.key, required this.title, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Chip(
        label: Text(title),
        backgroundColor: isSelected ? Colors.black : Colors.grey.shade300,
        labelStyle:
            TextStyle(color: isSelected ? Colors.white : Colors.black),
      ),
    );
  }
}

class VideoTile extends StatelessWidget {
  final String title;
  final String channelName;
  final String timeAgo;
  final String duration;
  final String thumbnailPath;

  const VideoTile({
    super.key,
    required this.title,
    required this.channelName,
    required this.timeAgo,
    required this.duration,
    required this.thumbnailPath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    thumbnailPath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (duration.isNotEmpty)
                Positioned(
                  bottom: 6,
                  right: 6,
                  child: Container(
                    color: Colors.black87,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: Text(
                      duration,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(thumbnailPath),
                radius: 16,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text('$channelName · $timeAgo',
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class VideoDetailPage extends StatelessWidget {
  final String title;
  final String channel;
  final String time;
  final String duration;
  final String thumbnail;

  const VideoDetailPage({
    super.key,
    required this.title,
    required this.channel,
    required this.time,
    required this.duration,
    required this.thumbnail,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Detail'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(thumbnail),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text('$channel · $time · $duration', style: const TextStyle(color: Colors.grey)),
            const Divider(),
            const Text("Deskripsi video bisa ditambahkan di sini."),
          ],
        ),
      ),
    );
  }
}
