import 'package:flutter/material.dart';
import 'widgets/profile_menu_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),
          ProfileMenuItem(
            icon: Icons.person_outline,
            title: '地址本',
            onTap: () {
              // TODO: 实现地址本功能
            },
          ),
          const Divider(height: 1),
          ProfileMenuItem(
            icon: Icons.settings_outlined,
            title: '使用设置',
            onTap: () {
              // TODO: 导航到设置页面
            },
          ),
          const SizedBox(height: 8),
          ProfileMenuItem(
            icon: Icons.help_outline,
            title: '帮助与反馈',
            onTap: () {
              // TODO: 导航到帮助与反馈页面
            },
          ),
          const Divider(height: 1),
          ProfileMenuItem(
            icon: Icons.description_outlined,
            title: '钱包指南',
            onTap: () {
              // TODO: 实现钱包指南功能
            },
          ),
          const Divider(height: 1),
          ProfileMenuItem(
            icon: Icons.info_outline,
            title: '关于我们',
            onTap: () {
              // TODO: 导航到关于我们页面
            },
          ),
        ],
      ),
    );
  }
} 