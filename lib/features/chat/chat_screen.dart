import 'package:flutter/material.dart';

import '../nearby/nearby_user.dart';

class ChatScreen extends StatefulWidget {
  final NearbyUser user;

  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  final List<String> _messages = [];

  // Development simulation.
  // Later this value will come from the proximity service.
  bool _isNearby = true;

  void _sendMessage() {
    if (!_isNearby) {
      return;
    }

    final message = _messageController.text.trim();

    if (message.isEmpty) {
      return;
    }

    setState(() {
      _messages.add(message);
    });

    _messageController.clear();
  }

  void _toggleNearbyStatus() {
    setState(() {
      _isNearby = !_isNearby;
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF190F1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF190F1A),
        titleSpacing: 0,
        title: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF392033),
              ),
              child: const Icon(
                Icons.person_outline,
                size: 21,
                color: Color(0xFFFF789A),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 7,
                      color: _isNearby ? const Color(0xFFFF789A) : Colors.grey,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      _isNearby ? 'Nearby' : 'No longer nearby',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        // Temporary development control.
        actions: [
          IconButton(
            tooltip: _isNearby ? 'Simulate leaving' : 'Simulate returning',
            onPressed: _toggleNearbyStatus,
            icon: Icon(
              _isNearby ? Icons.bluetooth_disabled : Icons.bluetooth_connected,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          if (!_isNearby)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              color: const Color(0xFF2A1928),
              child: Row(
                children: [
                  const Icon(
                    Icons.lock_outline,
                    size: 18,
                    color: Colors.white54,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '${widget.user.name} is no longer nearby. '
                      'Messaging has been disabled.',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: _messages.isEmpty ? _buildEmptyState() : _buildMessages(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.chat_bubble_outline,
              size: 42,
              color: Colors.white24,
            ),
            const SizedBox(height: 16),
            Text(
              'Say hello to ${widget.user.name}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              _isNearby ? 'You can chat while you are nearby.' : 'This chat is unavailable because this person is no longer nearby.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white38),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessages() {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
            decoration: BoxDecoration(
              color: const Color(0xFFB93660),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              _messages[index],
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMessageInput() {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                enabled: _isNearby,
                textInputAction: TextInputAction.send,
                onSubmitted: _isNearby ? (_) => _sendMessage() : null,
                decoration: InputDecoration(
                  hintText: _isNearby
                      ? 'Message...'
                      : 'User is no longer nearby',
                  filled: true,
                  fillColor: const Color(0xFF30202D),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              onPressed: _isNearby ? _sendMessage : null,
              icon: _isNearby
                  ? const Icon(Icons.arrow_upward)
                  : const Icon(Icons.lock_outline),
            ),
          ],
        ),
      ),
    );
  }
}
