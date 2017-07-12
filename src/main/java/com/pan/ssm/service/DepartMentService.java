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
 * @Description: TODO
 * @author Pan
 * @date 2017年7月10日
 *
 */
@Service
public class DepartMentService {

	@Autowired
	private DepartmentMapper departmentMapper;

	public List<Department> getDepts() {
		// TODO Auto-generated method stub
		List<Department> departments = departmentMapper.selectByExample(null);
		return departments;
	}

}
