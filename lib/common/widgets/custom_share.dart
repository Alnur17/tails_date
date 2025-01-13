import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart';

class CustomShare extends StatelessWidget {
  final String shareLink = 'https://example.com/share_link';

  const CustomShare({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Share Post',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildShareButton(
                          icon: Icons.facebook,
                          color: Colors.blue,
                          onTap: () => Share.share(
                            'Check out this post: $shareLink',
                            subject: 'Post Link',
                          ),
                        ),
                        _buildShareButton(
                          icon: Icons.message,
                          color: Colors.blueAccent,
                          onTap: () => Share.share(
                            'Check out this post: $shareLink',
                            subject: 'Post Link',
                          ),
                        ),
                        _buildShareButton(
                          icon: Icons.photo_camera,
                          color: Colors.pink,
                          onTap: () => Share.share(
                            'Check out this post: $shareLink',
                            subject: 'Post Link',
                          ),
                        ),
                        _buildShareButton(
                          icon: Icons.whatshot,
                          color: Colors.green,
                          onTap: () => Share.share(
                            'Check out this post: $shareLink',
                            subject: 'Post Link',
                          ),
                        ),
                        _buildShareButton(
                          icon: Icons.telegram,
                          color: Colors.lightBlue,
                          onTap: () => Share.share(
                            'Check out this post: $shareLink',
                            subject: 'Post Link',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Or Copy Link',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[200],
                            ),
                            child: Text(
                              shareLink,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: shareLink));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Link copied to clipboard')),
                            );
                          },
                          child: Text('Copy'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Text('Share Post'),
      ),
    );
  }

  Widget _buildShareButton({required IconData icon, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        backgroundColor: color.withOpacity(0.2),
        child: Icon(icon, color: color),
        radius: 24,
      ),
    );
  }
}