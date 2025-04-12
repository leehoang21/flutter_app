import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/card_custom.dart';
import '../bloc/transaction_cubit.dart';

class TransactionScreenProvider extends StatelessWidget {
  const TransactionScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return const TransactionScreen();
  }
}

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: BlocBuilder<TransactionCubit, TransactionState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<TransactionCubit>().onInit();
              },
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.transactions.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: CardCustom(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ' Số tài khoản người gửi : ${state.transactions[index].stkGui}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            ' Số tài khoản người nhận : ${state.transactions[index].stkNhan}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            ' Số tiền : ${state.transactions[index].amount}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Thời gian : ${state.transactions[index].thoiGianGiaoDich}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
