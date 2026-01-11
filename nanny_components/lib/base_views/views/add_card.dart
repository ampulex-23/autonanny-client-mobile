import 'package:flutter/material.dart';
import 'package:nanny_components/base_views/view_models/add_card_vm.dart';
import 'package:nanny_components/nanny_components.dart';
import 'package:nanny_core/nanny_core.dart';

class AddCardView extends StatefulWidget {
  final bool usePaymentInstead;
  final bool useSbpPayment;
  
  const AddCardView({
    super.key,
    this.usePaymentInstead = false,
    this.useSbpPayment = false,
  });

  @override
  State<AddCardView> createState() => _AddCardViewState();
}

class _AddCardViewState extends State<AddCardView> {
  late AddCardVM vm;

  @override
  void initState() {
    super.initState();
    vm = AddCardVM(context: context, update: setState, binding: WidgetsFlutterBinding.ensureInitialized());
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const NannyAppBar(
          title: "Пополнение баланса",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  !widget.usePaymentInstead ? "Заполните информацию" 
                    : "Заполните информацию о вашей карте"
                ),
                const SizedBox(height: 20),
                if(!widget.useSbpPayment) Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Form(
                      key: vm.fullNameState,
                      child: NannyTextForm(
                        labelText: "Имя Фамилия",
                        hintText: "Иван Иванов",
                        onChanged: (text) => vm.fullname = text,
                        keyType: TextInputType.name,
                        validator: (text) {
                          if(text!.split(' ').length < 2) {
                            return "Введите имя и фамилию!";
                          }
                          
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Form(
                      key: vm.cardState,
                      child: NannyTextForm(
                        labelText: "Номер карты",
                        hintText: "xxxx xxxx xxxx xxxx",
                        formatters: [vm.cardNumMask],
                        onChanged: (text) => vm.cardState.currentState!.validate(),
                        keyType: TextInputType.number,
                        validator: (text) {
                          if(vm.cardNumMask.getUnmaskedText().length < 16) {
                            return "Введите данные карты!";
                          }
                          if(!CardChecker.validateLuhnCard(vm.cardNumMask.getUnmaskedText())) {
                            return "Некорректный номер карты!";
                          }
                    
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Form(
                      key: vm.expState,
                      child: NannyTextForm(
                        labelText: "Срок действия",
                        hintText: "00/00",
                        formatters: [vm.expMask],
                        validator: (text) {
                          if(vm.expMask.getUnmaskedText().length < 4) {
                            return "Введите дату окончания срока действия!";
                          }
                    
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                if(widget.usePaymentInstead) Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Form(
                        key: vm.emailState,
                        child: NannyTextForm(
                          labelText: "Email",
                          hintText: "example@mail.ru",
                          onChanged: (text) => vm.email = text,
                          validator: (text) {
                            if(!text!.contains('@') || text.split('.').length < 2) {
                              return "Введите почту!";
                            }
                      
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Form(
                        key: vm.moneyState,
                        child: NannyTextForm(
                          labelText: "Количество",
                          hintText: "1000",
                          keyType: TextInputType.number,
                          onChanged: (text) => vm.amount = text,
                          validator: (text) {
                            if(text!.isEmpty) {
                              return "Введите количество в рублях!";
                            }
                            
                            final amount = int.tryParse(text);
                            if(amount == null) {
                              return "Введите корректное число!";
                            }
                            
                            if(amount < 100) {
                              return "Минимальная сумма пополнения: 100 ₽";
                            }
                      
                            return null;
                          },
                        ),
                      ),
                      
                    ],
                  ),
                ),
                // CheckboxListTile(
                //   value: vm.rememberCard, 
                //   onChanged: vm.setRememberCard,
          
                //   isThreeLine: false,
                //   title: Text("Запомнить данные карты", style: Theme.of(context).textTheme.bodyMedium),
                //   activeColor: Theme.of(context).colorScheme.primary,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(20)
                //   ),
                // ),
                const SizedBox(height: 20),
                widget.usePaymentInstead ? ElevatedButton(
                  onPressed: widget.useSbpPayment ? vm.trySbpPay : vm.tryPay,
                  child: const Text("Оплатить"),
                )
                : ElevatedButton(
                  onPressed: vm.trySendCardData,
                  child: const Text("Добавить"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
