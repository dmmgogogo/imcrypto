import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildActionButton(
            icon: Icons.send,
            label: 'Transfer',
            onTap: () {
              // TODO: 实现转账功能
            },
          ),
          _buildActionButton(
            icon: Icons.qr_code,
            label: 'Receive',
            onTap: () {
              // TODO: 实现接收功能
            },
          ),
          _buildActionButton(
            icon: Icons.history,
            label: 'Activity',
            onTap: () {
              // TODO: 实现活动记录
            },
          ),
          _buildActionButton(
            icon: Icons.account_balance,
            label: 'Stake',
            onTap: () {
              // TODO: 实现质押功能
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.blue),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
} 