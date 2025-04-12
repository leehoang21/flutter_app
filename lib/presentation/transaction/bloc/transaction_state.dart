part of 'transaction_cubit.dart';

class TransactionState extends Equatable {
  const TransactionState(this.transactions);
  final List<TransactionModel> transactions;

  @override
  List<Object> get props => [transactions];

  TransactionState copyWith({
    List<TransactionModel>? transactions,
  }) {
    return TransactionState(
      transactions ?? this.transactions,
    );
  }
}

final class TransactionInitial extends TransactionState {
  TransactionInitial() : super(<TransactionModel>[]);
}
