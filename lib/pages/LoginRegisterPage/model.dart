class LoginRegisterState{
  final String inputAccount;
  final String inputPassword;
  final bool isLoading;


  LoginRegisterState({
    this.inputAccount = "",
    this.inputPassword = "",
    this.isLoading = false
  });

  LoginRegisterState CopyWith({
    String? inputAccount,
    String? inputPassword,
    bool? isLoading
  }){
    return LoginRegisterState(
      inputAccount: inputAccount ?? this.inputAccount,
      inputPassword: inputPassword ?? this.inputPassword,
      isLoading: isLoading ?? this.isLoading
    );
  }
}