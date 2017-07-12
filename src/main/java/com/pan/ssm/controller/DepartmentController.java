/**
 * @Title: DepartmentController.java
 * @Package: com.pan.ssm.controller
 * @Description: 处理与部门相关的请求
 * @Author: Pan
 * @Date: 2017年7月10日
 */
package com.pan.ssm.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pan.ssm.bean.Department;
import com.pan.ssm.bean.Msg;
import com.pan.ssm.service.DepartMentService;

/**
 * @ClassName: DepartmentController
 * @Description: 处理与部门相关的请求
 * @author Pan
 * @date 2017年7月10日
 *
 */
@Controller
public class DepartmentController {

	/**
	 * 自动注入DepartMentService实例对象
	 */
	@Autowired
	private DepartMentService departMentService;

	/**
	 *
	 * @Title: getDepts
	 * @Description: 返回所有部门信息
	 * @return Msg
	 * @throws
	 *
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/depts")
	public Msg getDepts() {
		List<Department> departments = departMentService.getDepts();

		return Msg.success().add("depts", departments);
	}
}
