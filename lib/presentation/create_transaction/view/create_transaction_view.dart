import 'package:flutter/material.dart';

import 'package:flutter_app/presentation/create_transaction/bloc/create_transaction_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/text_button.dart';
import '../../widgets/text_filed_widget.dart';

class TransactionScreenProvider extends StatelessWidget {
  const TransactionScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateTransactionCubit(),
      child: const CreateTransactionView(),
    );
  }
}

class CreateTransactionView extends StatelessWidget {
  const CreateTransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final TextEditingController controllerAmount = TextEditingController();
    final TextEditingController controllerPin = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Transaction"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              TextFieldWidget(
                controller: controller,
                hintText: "receiverAccount",
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldWidget(
                controller: controllerAmount,
                hintText: "amount",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 10,
              ),
              SecurityTextFieldWidget(
                controller: controllerPin,
                keyboardType: TextInputType.text,
                hintText: "pincode",
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: TextButtonWidget(
                  onPressed: () async {
                    await context.read<CreateTransactionCubit>().create(
                          controller.text,
                          controllerAmount.text,
                          controllerPin.text,
                        );
                  },
                  title: "Create Transaction",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
