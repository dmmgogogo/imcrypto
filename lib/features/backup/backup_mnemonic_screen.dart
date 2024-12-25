import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/wallet_provider.dart';

class BackupMnemonicScreen extends StatefulWidget {
  const BackupMnemonicScreen({Key? key}) : super(key: key);

  @override
  State<BackupMnemonicScreen> createState() => _BackupMnemonicScreenState();
}

class _BackupMnemonicScreenState extends State<BackupMnemonicScreen> {
  List<String> _words = [];
  
  @override
  void initState() {
    super.initState();
    _loadMnemonic();
  }
  
  Future<void> _loadMnemonic() async {
    final mnemonic = await context.read<WalletProvider>().getMnemonic();
    if (mnemonic != null) {
      setState(() {
        _words = mnemonic.split(' ');
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '备份助记词',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '请顺序抄写助记词，确保备份正确。',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(
                  _words.length,
                  (index) => _MnemonicWord(
                    index: index + 1,
                    word: _words[index],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '• 助记词用于恢复钱包，请务必备份\n• 请勿将助记词存储在电脑或手机中\n• 泄露助记词会导致资产丢失',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.8,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: 实现验证助记词的功能
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0052FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('下一步'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _MnemonicWord extends StatelessWidget {
  final int index;
  final String word;

  const _MnemonicWord({
    required this.index,
    required this.word,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(
        '$index. $word',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
} 