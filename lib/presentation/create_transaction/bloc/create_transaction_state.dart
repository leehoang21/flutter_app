part of 'create_transaction_cubit.dart';

sealed class CreateTransactionState extends Equatable {
  const CreateTransactionState();
}

final class CreateTransactionInitial extends CreateTransactionState {
  @override
  List<Object> get props => [];
}
