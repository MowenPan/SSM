/**
 *
 */
package com.pan.ssm.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pan.ssm.bean.Employee;
import com.pan.ssm.bean.Msg;
import com.pan.ssm.service.EmployeeService;

/**
 *
 * @ClassName: EmployeeController
 * @Description: 处理员工的CRUD请求
 * @author Pan
 * @date 2017年7月12日
 *
 */
@Controller
public class EmployeeController {

	/**
	 * 自动注入EmployeeService实例对象
	 */
	@Autowired
	EmployeeService employeeService;

	/**
	 *
	 * @Title: getEmpsWithJson
	 * @Description: 以JSON格式返回所有员工信息，并实现分页
	 * @return PageInfo
	 * @throws
	 *
	 * @param pageNum
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/emps_json")
	public Msg getEmpsWithJson(@RequestParam(value="pageNum",defaultValue="1")Integer pageNum) {
		//引入分页插件PageHelper
		PageHelper.startPage(pageNum, 10);
		//分页查询
		List<Employee> employees = employeeService.getAllEmployees();
		//用PageInfo对结果进行包装
		PageInfo page = new PageInfo(employees,5);
		return Msg.success().add("pageInfo",page);
	}

	/**
	 * 查询所有员工（分页查询）
	 * @return
	 */
	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pageNum",defaultValue="1")Integer pageNum,
			Model model) {
		//引入分页插件PageHelper
		PageHelper.startPage(pageNum, 10);
		//分页查询
		List<Employee> employees = employeeService.getAllEmployees();
		//用PageInfo对结果进行包装
		PageInfo page = new PageInfo(employees,5);
		model.addAttribute("pageInfo", page);

		return "list";
	}

	/**
	 *
	 * @Title: saveEmp
	 * @Description: 实现新增员工功能,同时验证员工姓名和邮箱格式是否合法
	 * @return Msg
	 * @throws
	 *
	 * @param employee
	 * @param result
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {
		if (result.hasErrors()) {
			Map<String, Object> map = new HashMap<>();
			List<FieldError> errors = result.getFieldErrors();
			for(FieldError error:errors) {
				System.out.println("错误的字段名：" + error.getField());
				System.out.println("错误信息：" + error.getDefaultMessage());
				map.put(error.getField(), error.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else {
			employeeService.saveEmployee(employee);
			return Msg.success();
		}
	}

	/**
	 *
	 * @Title: checkUserName
	 * @Description: 检验用户名是否可用
	 * @return Msg
	 * @throws
	 *
	 * @param empName
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/checkUserName")
	public Msg checkUserName(@RequestParam("empName")String empName) {

		//判断用户名表达式是否合法
		String regex = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
		if (!empName.matches(regex)) {
			return Msg.fail().add("va_msg", "用户名应由2-5位中文或6-16位字母数字组合！！！");
		}

		//校验用户名是否重复
		boolean isValide = employeeService.checkUserName(empName);
		if (isValide) {
			return Msg.success();
		}else {
			return Msg.fail().add("va_msg", "用户名不可用！！！");
		}
	}

	/**
	 *
	 * @Title: getEmp
	 * @Description: 根据员工ID查询员工信息，以JSON格式返回
	 * @return Msg
	 * @throws
	 *
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	public Msg getEmp(@PathVariable("id")Integer id) {
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}

	/**
	 *
	 * @Title: saveEmp
	 * @Description: 更新员工信息
	 * @return Msg
	 * @throws
	 *
	 * @param employee
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	public Msg saveEmp(Employee employee) {
//		System.out.println("接收到的员工数据：" + employee.toString());
		employeeService.updateEmp(employee);
		return Msg.success();
	}

	/**
	 *
	 * @Title: deleteEmp
	 * @Description: 根据ID删除员工信息
	 * @return Msg
	 * @throws
	 *
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/emp/{id}",method=RequestMethod.DELETE)
	public Msg deleteEmp(@PathVariable("id")String ids) {
		if (ids.contains("-")) {
			String[] id_str = ids.split("-");
			List<Integer> del_ids = new ArrayList<>();
			for(String id:id_str) {
				del_ids.add(Integer.parseInt(id));
			}
			employeeService.deleteBatch(del_ids);
		}else {
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmpById(id);
		}

		return Msg.success();
	}

}
