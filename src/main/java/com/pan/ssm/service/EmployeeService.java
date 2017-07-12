/**
 *
 */
package com.pan.ssm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pan.ssm.bean.Employee;
import com.pan.ssm.bean.EmployeeExample;
import com.pan.ssm.bean.EmployeeExample.Criteria;
import com.pan.ssm.dao.EmployeeMapper;

/**
 *
 * @ClassName: EmployeeService
 * @Description: 处理与员工相关的操作
 * @author Pan
 * @date 2017年7月12日
 *
 */
@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;

	/**
	 *
	 * @Title: getAllEmployees
	 * @Description: 获取所有员工信息，并以List的形式返回
	 * @return List<Employee>
	 * @throws
	 *
	 * @return
	 */
	public List<Employee> getAllEmployees() {
		// TODO Auto-generated method stub
		return employeeMapper.selectByExampleWithDept(null);
	}

	/**
	 *
	 * @Title: saveEmployee
	 * @Description: 新增员工
	 * @return void
	 * @throws
	 *
	 * @param employee
	 */
	public void saveEmployee(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.insertSelective(employee);
	}

	/**
	 *
	 * @Title: checkUserName
	 * @Description: 检验用户名是否可用
	 * @return boolean
	 * @throws
	 *
	 * @param empName
	 * @return
	 */
	public boolean checkUserName(String empName) {
		// TODO Auto-generated method stub
		EmployeeExample employeeExample = new EmployeeExample();
		Criteria criteria = employeeExample.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(employeeExample);
		return count == 0;
	}

	/**
	 *
	 * @Title: getEmp
	 * @Description: 根据ID查询员工信息
	 * @return Employee
	 * @throws
	 *
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		// TODO Auto-generated method stub
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}

	/**
	 *
	 * @Title: updateEmp
	 * @Description: 更新员工信息
	 * @return void
	 * @throws
	 *
	 * @param employee
	 */
	public void updateEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.updateByPrimaryKeySelective(employee);
	}

	/**
	 *
	 * @Title: deleteEmpById
	 * @Description: 根据员工ID删除员工信息
	 * @return void
	 * @throws
	 *
	 * @param id
	 */
	public void deleteEmpById(Integer id) {
		// TODO Auto-generated method stub
		employeeMapper.deleteByPrimaryKey(id);
	}

	/**
	 *
	 * @Title: deleteBatch
	 * @Description: 批量删除员工
	 * @return void
	 * @throws
	 *
	 * @param ids
	 */
	public void deleteBatch(List<Integer> ids) {
		// TODO Auto-generated method stub
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
	}

}
