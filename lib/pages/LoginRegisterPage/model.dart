class LoginRegisterState{
  final String inputAccount;
  final String inputPassword;
  final String inputRePassword;
  final bool isLoading;


  LoginRegisterState({
    this.inputAccount = "",
    this.inputPassword = "",
    this.inputRePassword = "",
    this.isLoading = false
  });

  LoginRegisterState CopyWith({
    String? inputAccount,
    String? inputPassword,
    String? inputRePassword,
    bool? isLoading
  }){
    return LoginRegisterState(
      inputAccount: inputAccount ?? this.inputAccount,
        inputPassword: inputPassword ?? this.inputPassword,
          inputRePassword: inputRePassword ?? this.inputRePassword,
            isLoading: isLoading ?? this.isLoading
    );
  }
}