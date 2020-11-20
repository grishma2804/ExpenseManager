class WalletTransactions {
  String amount;
  List<Map<String, List<String>>> attributes;
  String createdAt;
  String fromAccountName;
  String fromAccountNumber;
  String fromBankCode;
  String fromBankName;
  int id;
  String toAccountName;
  String toAccountNumber;
  String toBankCode;
  String toBankName;
  String transactionType;
  String updatedAt;

  WalletTransactions(
      {this.amount,
      this.attributes,
      this.createdAt,
      this.fromAccountName,
      this.fromAccountNumber,
      this.fromBankCode,
      this.fromBankName,
      this.id,
      this.toAccountName,
      this.toAccountNumber,
      this.toBankCode,
      this.toBankName,
      this.transactionType,
      this.updatedAt});

  factory WalletTransactions.fromJson(Map<String, dynamic> json) {
    return WalletTransactions(
      amount: json['amount'],
      attributes: json['attributes'] != null
          ? (json['attributes'] as List)
              ?.map((e) => (e as Map<String, dynamic>)?.map(
                    (k, e) => MapEntry(
                        k, (e as List)?.map((e) => e as String)?.toList()),
                  ))
              ?.toList()
          : null,
      createdAt: json['createdAt'],
      fromAccountName: json['fromAccountName'],
      fromAccountNumber: json['fromAccountNumber'],
      fromBankCode: json['fromBankCode'],
      fromBankName: json['fromBankName'],
      id: json['id'],
      toAccountName: json['toAccountName'],
      toAccountNumber: json['toAccountNumber'],
      toBankCode: json['toBankCode'],
      toBankName: json['toBankName'],
      transactionType: json['transactionType'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['createdAt'] = this.createdAt;
    data['fromAccountName'] = this.fromAccountName;
    data['fromAccountNumber'] = this.fromAccountNumber;
    data['fromBankCode'] = this.fromBankCode;
    data['fromBankName'] = this.fromBankName;
    data['id'] = this.id;
    data['toAccountName'] = this.toAccountName;
    data['toAccountNumber'] = this.toAccountNumber;
    data['toBankCode'] = this.toBankCode;
    data['toBankName'] = this.toBankName;
    data['updatedAt'] = this.updatedAt;
    data['transactionType'] = this.transactionType;
    if (this.attributes != null) {
      data['attributes'] = this.attributes;
    }
    return data;
  }
}
