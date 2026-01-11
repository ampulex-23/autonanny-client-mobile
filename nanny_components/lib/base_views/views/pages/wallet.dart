import 'package:flutter/material.dart';
import 'package:nanny_components/base_views/view_models/pages/wallet_vm.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/nanny_core.dart';

class WalletView extends StatefulWidget {
  final String title;
  final String subtitle;
  final bool hasReplenishButtons;
  
  const WalletView({
    super.key,
    required this.title,
    required this.subtitle,
    this.hasReplenishButtons = true,
  });

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  late WalletVM vm;

  @override
  void initState() {
    super.initState();
    vm = WalletVM(context: context, update: setState);
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AdaptBuilder(
        builder: (context, size) {
          return Scaffold(
            appBar: NannyAppBar(
              // title: "Пополнение баланса",
              title: widget.title,
              isTransparent: false,
            ),
            body: Center(
              child: RefreshIndicator(
                onRefresh: () async => vm.refresh,
                child: Column(
                  children: [
            
                    const SizedBox(height: 20),
                    // Text(" ", style: Theme.of(context).textTheme.labelLarge),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        widget.subtitle, 
                        style: Theme.of(context).textTheme.labelLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: RequestLoader(
                        request: vm.cardRequest, 
                        completeView: (context, data) => ListView(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: data!.cards.map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(20),
                              child: debitCard(e, size, vm.selectedId),
                            )
                          ).toList(),
                        ), 
                        errorView: (context, error) => ErrorView(errorText: error.toString()),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: vm.selectedId != 0 ? vm.chooseCard : null, 
                      child: const Text("Выбрать"),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: vm.selectedId != 0 ? vm.deleteCard : null, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red
                      ),
                      child: const Text("Удалить"),
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: vm.navigateToAddCard, 
                      child: const Text("Добавить карту"),
                    ),
                    if(widget.hasReplenishButtons) Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => vm.navigateToView(
                                const AddCardView(usePaymentInstead: true)
                              ), 
                              child: const Text("Пополнить"),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => vm.navigateToView(
                                const AddCardView(usePaymentInstead: true, useSbpPayment: true)
                              ), 
                              child: const Text("Пополнить по СБП", textAlign: TextAlign.center),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
            
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  Widget debitCard(UserCardData card, Size size, int selectedId) {
    LinearGradient? gradient = switch(card.bank.toLowerCase()) {
      "mir" => const LinearGradient(colors: [NannyTheme.green, NannyTheme.onPrimary]),
      "visa" => const LinearGradient(colors: [Colors.purple, NannyTheme.onPrimary]),
      "mastercard" => const LinearGradient(colors: [Colors.red, Colors.orange]),
      _ => const LinearGradient(colors: [NannyTheme.onPrimary])
    };
    
    return SizedBox(
      height: size.width * .5,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ElevatedButton(
          onPressed: () => vm.selectCard(card.id),
          style: card.id == selectedId ? ElevatedButton.styleFrom(
            foregroundColor: NannyTheme.onSecondary,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(
                color: NannyTheme.green,
                width: 5,
              )
            ),
            padding: EdgeInsets.zero,
          )
          : ElevatedButton.styleFrom(
            foregroundColor: NannyTheme.onSecondary,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.zero,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(card.cardNumber),
                  Text(card.bank),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}