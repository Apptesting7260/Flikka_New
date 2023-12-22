class ShowBankDetailsModel {
  ShowBankDetailsModel({
     this.status,
     this.bankDetails,
  });
    bool ?status;
    BankDetails ?bankDetails;

  ShowBankDetailsModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    bankDetails = BankDetails.fromJson(json['bank_details']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['bank_details'] = bankDetails?.toJson();
    return _data;
  }
}

class BankDetails {
  BankDetails({
     this.id,
     this.seekerId,
     this.bankName,
     this.accountHolder,
     this.branchCode,
     this.accountNumber,
     this.ifscCode,
     this.createdAt,
     this.updatedAt,
  });
   int ?id;
   int ?seekerId;
   String ?bankName;
   String ?accountHolder;
   String ?branchCode;
   String ?accountNumber;
   String ?ifscCode;
   String ?createdAt;
   String ?updatedAt;

  BankDetails.fromJson(Map<String, dynamic> json){
    id = json['id'];
    seekerId = json['seeker_id'];
    bankName = json['bank_name'];
    accountHolder = json['account_holder'];
    branchCode = json['branch_code'];
    accountNumber = json['account_number'];
    ifscCode = json['ifsc_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['seeker_id'] = seekerId;
    _data['bank_name'] = bankName;
    _data['account_holder'] = accountHolder;
    _data['branch_code'] = branchCode;
    _data['account_number'] = accountNumber;
    _data['ifsc_code'] = ifscCode;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}