import 'package:dogecoin/data/models/transaction.dart';
import 'package:dogecoin/presentation/global_widgets/auth_stotage.dart';
import 'package:dogecoin/presentation/global_widgets/custom_alert_dialog.dart';
import 'package:dogecoin/presentation/main_screen/widgets/comma_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dogecoin/theme/app_colors.dart';
import 'package:intl/intl.dart';
import '../widgets/custom_app_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  String transactionMessage = 'There is no transactions for now';
  bool showSendForm = false;
  bool showAmountInput = false;
  bool showReceiveForm = false;

  final _addressController = TextEditingController();
  final _amountController = TextEditingController();

  final _addressFocusNode = FocusNode();
  final _amountFocusNode = FocusNode();

  // Управление состоянием видимости клавиатуры
  bool isKeyboardVisible = false;

  bool isTransactionComplete = false;
  bool isNextButtonEnabled = false;

  List<Transaction> transactions = [];

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _addressFocusNode.dispose();
    _amountFocusNode.dispose();
    _addressController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    setState(() {
      isKeyboardVisible = bottomInset > 0;
    });
  }

  void _startReceive() {
    setState(() {
      showReceiveForm = true;
      showSendForm = false;
      showAmountInput = false;

      if (_addressController.text.isEmpty) {
        _addressController.text = 'etwet4w3t4WEgerzerg343t434g543t4g34g334g';
      }
    });
    FocusScope.of(context).unfocus();
  }

  void _cancelReceive() {
    setState(() {
      showReceiveForm = false; // Скрываем форму Receive
    });
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

  // Методы для управления состоянием и UI
  void _startSend() {
    setState(() {
      showSendForm = true;
      showAmountInput = false;
      _addressController.clear();
      _amountController.clear();
      isNextButtonEnabled = false;
    });
    FocusScope.of(context).unfocus();
  }

  void _nextStep() {
    setState(() {
      showAmountInput = true;
      isNextButtonEnabled = false;
    });
  }

  void _sendTransaction() {
    setState(() {
      // transactionMessage = 'Transaction sent successfully'; // Убираем это
      showSendForm = false;
      showAmountInput = false;
      isTransactionComplete = true;

      // Добавляем транзакцию в список
      transactions.add(
        Transaction(
          address: _addressController.text,
          amount: _amountController.text,
        ),
      );
      _addressController.clear();
      _amountController.clear();
    });
  }

  void _cancelSend() {
    setState(() {
      showSendForm = false;
      showAmountInput = false;
    });
    FocusScope.of(context).unfocus();
  }

  void _onInputChanged(String value) {
    setState(() {
      isNextButtonEnabled = value.trim().isNotEmpty;
    });
  }

  void _keyboardVisibilityListener() {
    final keyboardIsVisible =
        _addressFocusNode.hasFocus || _amountFocusNode.hasFocus;
    if (keyboardIsVisible != isKeyboardVisible) {
      setState(() {
        isKeyboardVisible = keyboardIsVisible;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    AuthStorage.setLoggedIn(true);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              containerColor: AppColors.whiteColor,
              iconColor: AppColors.secondaryColor,
              padding: 35,
            ),
            const SizedBox(height: 13),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBalanceSection(theme),
                  const SizedBox(height: 9),
                  _buildActionButtons(theme),
                  const SizedBox(height: 28),
                ],
              ),
            ),

            // Прокручиваемая часть с формами
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showSendForm)
                      _buildSendForm(theme)
                    else if (showReceiveForm)
                      _buildReceiveForm(theme)
                    else
                      _buildTransactionStatus(theme),
                    if (transactions.isNotEmpty) _buildTransactionList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiveForm(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            'Receive',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Your address:',
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
        ),
        SizedBox(height: 5),
        Stack(
          children: [
            Container(
              height: 75,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(color: Colors.white),
              child: Text(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                _addressController.text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackTextColor,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: ElevatedButton(
                style: copyButtonStyle,
                onPressed: () async {
                  await Clipboard.setData(
                    ClipboardData(text: _addressController.text),
                  );

                  if (context.mounted) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CustomAlertDialog(
                          title: 'Your address copied',
                          button: 'OK',
                          onRetry: () {
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    );
                  }
                },
                child: Text(
                  'Copy',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.blackTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 58,
          child: ElevatedButton(
            style: _nextButtonStyle,
            onPressed: _cancelReceive,
            child: Text('Back to Home'),
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionList() {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text('List of transactions:'),
        ),
        const SizedBox(height: 5),
        ...transactions.map((transaction) {
          String formattedDate = DateFormat(
            'dd.MM.yyyy',
          ).format(transaction.timestamp);
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            decoration: BoxDecoration(color: AppColors.secondaryColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '+${transaction.amount}',
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'DOGE',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '~\$',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 14,
                        color: AppColors.borderButtonColor,
                      ),
                    ),
                    Text(
                      '32,54',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 15,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      formattedDate,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 12,
                        color: AppColors.borderButtonColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ],
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
            const Text(
              '~',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
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
          _buildMainButton('Recieve', _startReceive, theme),
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
          focusNode: _addressFocusNode,
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
                      CommaInputFormatter(),
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
                    focusNode: _amountFocusNode,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'DOGE',
                    style: const TextStyle(
                      color: AppColors.secondaryColor,
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
              showAmountInput ? 'Send' : 'Next',
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
    required FocusNode focusNode,
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
    if (transactions.isNotEmpty) return SizedBox.shrink();
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
          padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 36),
          decoration: BoxDecoration(color: AppColors.secondaryColor),
          child: Text(
            transactionMessage,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.blackTextColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  final ButtonStyle _mainButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.activeButtonStyle,
    foregroundColor: AppColors.blackTextColor,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    side: BorderSide(color: AppColors.secondaryColor),
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

final ButtonStyle copyButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: AppColors.activeButtonStyle,
  foregroundColor: AppColors.blackTextColor,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
  elevation: 0,
  padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 5),
).copyWith(
  overlayColor: WidgetStateProperty.resolveWith<Color?>(
    (states) =>
        states.contains(WidgetState.pressed)
            ? AppColors.overlayButtonColor
            : null,
  ),
);

final ButtonStyle _nextButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: AppColors.primaryColor.withOpacity(0.3),
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
