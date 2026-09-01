class BankDetailsModel {
  final String accountHolderName;
  final String bankName;
  final String accountNumber;
  final String ifscCode;
  final bool isVerified;

  const BankDetailsModel({
    required this.accountHolderName,
    required this.bankName,
    required this.accountNumber,
    required this.ifscCode,
    required this.isVerified,
  });
}