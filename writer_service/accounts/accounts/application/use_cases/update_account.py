from accounts.accounts.application.repositories.repositorie_account import AccountRepository
from accounts.accounts.domain.account import Account
from accounts.accounts.domain.exceptions import AccountInvalidException, DataBaseException
from dataclasses import dataclass

@dataclass
class UpdateAccountInputDto:
    idAccount: str = None
    firstName: str = None
    lastName: str = None
    userName: str = None
    gender: str = None
    birthday: str = None
    cover: str = None

class UpdateAccount:
    def __init__(self, repository: AccountRepository):
        self.repository = repository

    def execute(self, inputAccount: UpdateAccountInputDto):
        if inputAccount.idAccount is None:
            raise AccountInvalidException("Campos faltantes")
        account = Account()
        account.idAccount = inputAccount.idAccount
        account.firstName = inputAccount.firstName
        account.lastName = inputAccount.lastName
        account.userName = inputAccount.userName
        account.birthday = inputAccount.birthday
        account.gender = inputAccount.gender
        account.cover = inputAccount.cover
        try:
            result = self.repository.update(account)
            return result
        except DataBaseException:
            raise DataBaseException("Error al actualizar la cuenta")
        
        print("todo bien")

         
