package com.pan.ssm.bean;

import javax.validation.constraints.Pattern;

/**
*
* @ClassName: Employee
* @Description: 实体类，由MyBatis Generator自动生成
* @author Pan
* @date 2017年7月12日
*
*/
public class Employee {
	private Integer empId;

	//JSR303验证姓名格式是否正确
	@Pattern(regexp="(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})",
			message="用户名必须由2-5位中文或6-16位字母数字组合！！！")
	private String empName;

	private String gender;

	//JSR303验证邮箱格式是否正确
	@Pattern(regexp="^([a-zA-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$",
			message="邮箱格式不正确！！！")
	private String email;

	private Integer deptId;

	private Department department;

	public Employee() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Employee(Integer empId, String empName, String gender, String email, Integer deptId) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.gender = gender;
		this.email = email;
		this.deptId = deptId;
	}

	public Integer getEmpId() {
		return empId;
	}

	public void setEmpId(Integer empId) {
		this.empId = empId;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Integer getDeptId() {
		return deptId;
	}

	public void setDeptId(Integer deptId) {
		this.deptId = deptId;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 * Title: toString
	 * Description: TODO
	 *
	 * @return
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Employee [empId=" + empId + ", empName=" + empName + ", gender=" + gender + ", email=" + email
				+ ", deptId=" + deptId + ", department=" + department + "]";
	}

}