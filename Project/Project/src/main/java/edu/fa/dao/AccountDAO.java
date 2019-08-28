package edu.fa.dao;

import edu.fa.model.Account;
import edu.fa.model.Employee;

public interface AccountDAO {
	Employee getEmployeeByAccount(Account account);
	
	Account getUserNameByUserName(Account account);
	
	Account getUserNameByUserName(Account account, String usernameSave);
}
