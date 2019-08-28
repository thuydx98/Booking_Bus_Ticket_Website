package edu.fa.dao;

import java.util.List;

import edu.fa.model.Account;
import edu.fa.model.Employee;

public interface EmployeeDAO {
	int insertEmployee(Employee employee, Account account);
	
	int updateEmployee(Employee employee);
	
	int updateEmployee(int employeeID);
	
	List<Employee> getAllEmployee(int page);
	
	List<Employee> searchEmployee(String search, int page);
	
	Employee getEmployee(Employee employee);
}
