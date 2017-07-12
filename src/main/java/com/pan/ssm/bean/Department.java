package com.pan.ssm.bean;

/**
*
* @ClassName: Department
* @Description: 实体类，由MyBatis Generator自动生成
* @author Pan
* @date 2017年7月12日
*
*/
public class Department {
    private Integer deptId;

    private String deptName;

    public Department() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Department(Integer deptId, String deptName) {
		super();
		this.deptId = deptId;
		this.deptName = deptName;
	}

	public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }
}