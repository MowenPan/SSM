/**
 * @Title: DepartMentService.java
 * @Package: com.pan.ssm.service
 * @Description: TODO
 * @Author: Pan
 * @Date: 2017年7月10日
 */
package com.pan.ssm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pan.ssm.bean.Department;
import com.pan.ssm.dao.DepartmentMapper;

/**
 * @ClassName: DepartMentService
 * @Description: 用于处理部门相关的操作
 * @author Pan
 * @date 2017年7月10日
 *
 */
@Service
public class DepartMentService {

	//自动注入DepartmentMapper对象
	@Autowired
	private DepartmentMapper departmentMapper;

	/**
	 *
	 * @Title: getDepts
	 * @Description: 以列表的形式返回部门信息
	 * @return List<Department>
	 * @throws
	 *
	 * @return
	 */
	public List<Department> getDepts() {
		// TODO Auto-generated method stub
		List<Department> departments = departmentMapper.selectByExample(null);
		return departments;
	}

}
