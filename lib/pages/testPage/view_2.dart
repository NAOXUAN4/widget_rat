import 'package:flutter/material.dart';

class HomePage1 extends StatelessWidget {
  const HomePage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '设置',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          _buildSectionTitle('目标设置'),
          _buildTargetItem(
            '每日饮水量',
            '2000mL',
            Icons.water_drop_outlined,
          ),
          _buildTargetItem(
            '运动时长',
            '30分钟',
            Icons.directions_run,
          ),
          _buildTargetItem(
            '学习时长',
            '120分钟',
            Icons.book_outlined,
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('通知设置'),
          _buildNotificationItem(
            '久坐提醒',
            '每60分钟提醒一次',
            true,
          ),
          _buildNotificationItem(
            '喝水提醒',
            '每90分钟提醒一次',
            true,
          ),
          _buildNotificationItem(
            '运动提醒',
            '每天下午3点提醒',
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _buildTargetItem(String title, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: const TextStyle(color: Colors.grey),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
        onTap: () {}, // 这里可以添加点击事件
      ),
    );
  }

  Widget _buildNotificationItem(String title, String subtitle, bool isEnabled) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12),
        ),
        trailing: Switch(
          value: isEnabled,
          onChanged: (value) {}, // 这里可以添加开关切换事件
        ),
      ),
    );
  }
}