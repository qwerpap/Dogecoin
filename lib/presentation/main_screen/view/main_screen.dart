import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dogecoin/theme/app_colors.dart';
import '../widgets/custom_app_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String transactionMessage = 'There are no transactions yet';
  bool showSendForm = false;
  bool showAmountInput = false;

  final _addressController = TextEditingController();
  final _amountController = TextEditingController();

  bool isTransactionComplete = false;

  bool isNextButtonEnabled = false;

  @override
  void dispose() {
    _addressController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _pasteAddress() async {
    final data = await Clipboard.getData('text/plain');
    final text = data?.text;
    if (text?.isNotEmpty == true) {
      setState(() {
        _addressController.text = text!;
        isNextButtonEnabled = true;
      });
    }
  }

  void _startSend() {
    setState(() {
      showSendForm = true;
      showAmountInput = false;
      _addressController.clear();
      _amountController.clear();
      isNextButtonEnabled = false;
    });
  }

  void _nextStep() {
    setState(() {
      showAmountInput = true;
      isNextButtonEnabled = false;
    });
  }

  void _sendTransaction() {
    setState(() {
      transactionMessage = 'Transaction sent successfully';
      showSendForm = false;
      showAmountInput = false;
      // Оставляем текст в контроллерах для отображения на экране
      isTransactionComplete = true; // Устанавливаем, что транзакция завершена
    });
  }

  void _cancelSend() {
    setState(() {
      showSendForm = false;
      showAmountInput = false;
    });
  }

  void _onInputChanged(String value) {
    setState(() {
      isNextButtonEnabled = value.trim().isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(34),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(),
                const SizedBox(height: 35),
                _buildBalanceSection(theme),
                const SizedBox(height: 9),
                _buildActionButtons(theme),
                const SizedBox(height: 28),
                if (showSendForm)
                  _buildSendForm(theme)
                else
                  _buildTransactionStatus(theme),
              ],
            ),
          ),
          // Контейнер с сообщением о транзакции
          if (isTransactionComplete)
            Positioned.fill(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 35),
                color: AppColors.primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/png/logo.png'),
                    SizedBox(height: 25),
                    Text(
                      'Your transaction has\nbeen successfully sent',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: AppColors.whiteColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Address',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(color: Colors.white),
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        _addressController.text,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blackTextColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 9),
                    Text(
                      'Amount',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(color: Colors.white),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/png/dogecoin.png',
                            height: 25,
                            width: 25,
                          ),
                          SizedBox(width: 6),
                          Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            _amountController.text,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppColors.borderButtonColor,
                            ),
                          ),
                          SizedBox(width: 6),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              'DOGE',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        style: _nextButtonStyle,
                        onPressed: () {
                          Navigator.pushNamed(context, '/main');
                        },
                        child: Text('Back home'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBalanceSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your balance:',
          style: theme.textTheme.bodySmall?.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
        const SizedBox(height: 9),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildBalanceCard('0,000', 'DOGE', 'assets/png/dogecoin.png'),
            const Text('~'),
            _buildUsdBalance('\$0,00'),
          ],
        ),
      ],
    );
  }

  Widget _buildBalanceCard(String amount, String label, String iconPath) {
    return Container(
      width: 218,
      padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 23),
      decoration: const BoxDecoration(color: AppColors.whiteColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(iconPath, width: 23, height: 23),
              const SizedBox(width: 6),
              Text(
                amount,
                style: const TextStyle(color: Colors.black, fontSize: 20),
              ),
            ],
          ),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsdBalance(String amount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 26),
      decoration: const BoxDecoration(color: AppColors.whiteColor),
      child: Text(amount),
    );
  }

  Widget _buildActionButtons(ThemeData theme) {
    return SizedBox(
      width: 218,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildMainButton('Send', _startSend, theme),
          _buildMainButton('Receive', () {}, theme),
        ],
      ),
    );
  }

  Widget _buildMainButton(
    String label,
    VoidCallback onPressed,
    ThemeData theme,
  ) {
    return SizedBox(
      width: 100,
      child: ElevatedButton(
        style: _mainButtonStyle,
        onPressed: onPressed,
        child: Text(
          label,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSendForm(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            'Send',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
        ),
        const SizedBox(height: 10),
        _buildLabeledInput(
          label: 'Enter recipient\'s address:',
          controller: _addressController,
          onChanged: _onInputChanged,
          maxLines: 3,
          suffix: TextButton(
            onPressed: _pasteAddress,
            style: _pasteButtonStyle,
            child: Text('Paste', style: theme.textTheme.titleMedium),
          ),
        ),
        const SizedBox(height: 18),
        if (showAmountInput)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Image.asset(
                    'assets/png/dogecoin.png',
                    width: 25,
                    height: 25,
                  ),
                ),
                Expanded(
                  child: TextField(
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.borderButtonColor,
                    ),
                    controller: _amountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
                      LengthLimitingTextInputFormatter(15),
                    ],
                    decoration: InputDecoration(
                      hintText: '00,00',
                      hintStyle: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.hintTextColor,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(0),
                      filled: true,
                      fillColor: AppColors.whiteColor,
                    ),
                    onChanged: _onInputChanged,
                  ),
                ),
                // Текст DOGE, который всегда будет находиться рядом с TextField
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'DOGE',
                    style: const TextStyle(
                      color: AppColors.secondaryColor, // Цвет текста
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          height: 58,
          child: ElevatedButton(
            style: _nextButtonStyle,
            onPressed:
                isNextButtonEnabled
                    ? (showAmountInput ? _sendTransaction : _nextStep)
                    : null,
            child: Text(
              showAmountInput ? 'Finish' : 'Next',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 41),
        GestureDetector(
          onTap: _cancelSend,
          child: const Center(child: Text('Back home')),
        ),
      ],
    );
  }

  Widget _buildLabeledInput({
    required String label,
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    required Function(String) onChanged,
    Widget? suffix,
    String hintText = 'Enter address',
    List<TextInputFormatter>? inputFormatter,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColors.whiteColor, fontSize: 13),
        ),
        const SizedBox(height: 5),
        Stack(
          children: [
            Container(
              decoration: const BoxDecoration(color: AppColors.whiteColor),
              child: TextField(
                controller: controller,
                maxLines: maxLines,
                keyboardType: keyboardType,
                inputFormatters: inputFormatter,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(12),
                  filled: true,
                  fillColor: AppColors.whiteColor,
                ),
                onChanged: onChanged,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackTextColor,
                ),
              ),
            ),
            if (suffix != null) Positioned(bottom: 0, right: 0, child: suffix),
          ],
        ),
      ],
    );
  }

  Widget _buildTransactionStatus(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent transactions:',
          style: theme.textTheme.bodySmall?.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
        SizedBox(height: 9),
        Container(
          width: double.infinity,
          height: 90,
          decoration: BoxDecoration(color: AppColors.secondaryColor),
          child: Center(
            child: Text(
              'There is no transactions for now',
              style: theme.textTheme.bodySmall?.copyWith(fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }

  final ButtonStyle _mainButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.activeButtonStyle,
    foregroundColor: AppColors.blackTextColor,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    elevation: 0,
  ).copyWith(
    overlayColor: WidgetStateProperty.resolveWith<Color?>(
      (states) =>
          states.contains(WidgetState.pressed)
              ? AppColors.overlayButtonColor
              : null,
    ),
  );

  final ButtonStyle _pasteButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.activeButtonStyle,
    foregroundColor: AppColors.blackTextColor,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
    elevation: 0,
  );
}

final ButtonStyle _nextButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: AppColors.primaryColor.withOpacity(
    0.3,
  ), // Прозрачный цвет по умолчанию
  foregroundColor: AppColors.blackTextColor,
  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
  side: const BorderSide(color: AppColors.borderButtonColor),
  elevation: 0,
).copyWith(
  overlayColor: WidgetStateProperty.resolveWith<Color?>(
    (states) =>
        states.contains(WidgetState.pressed)
            ? AppColors.overlayButtonColor
            : null,
  ),
  backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
    if (states.contains(MaterialState.disabled)) {
      return AppColors.primaryColor;
    }
    return AppColors.activeButtonStyle;
  }),
);
