/**
 *
 */
package com.pan.ssm.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.pan.ssm.bean.Department;
import com.pan.ssm.bean.Employee;
import com.pan.ssm.dao.DepartmentMapper;
import com.pan.ssm.dao.EmployeeMapper;

/**
 * @author Pan
 * /SSM/src/main/resources/applicationContext.xml
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {

	@Autowired
	DepartmentMapper departmentMapper;

	@Autowired
	EmployeeMapper employeeMapper;

	@Autowired
	SqlSession sqlSession;

	@Test
	public void testCRUD() {
//		//1.创建Spring IOC容器
//		ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
//		//2.从容器中获取Mapper
//		DepartmentMapper bean = context.getBean(DepartmentMapper.class);

		System.out.println(departmentMapper);
		System.out.println(employeeMapper);
		//插入部门
//		departmentMapper.insertSelective(new Department(null,"开发部"));
//		departmentMapper.insertSelective(new Department(null,"测试部"));

		//生成员工数据
//		employeeMapper.insertSelective(new Employee(null,"Jerry","M","jerry@163.com",1));

		//批量插入
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i = 0;i < 1000;i++) {
			String uuid = UUID.randomUUID().toString().substring(0, 15) + i;
			mapper.insertSelective(new Employee(null,uuid,"M",uuid + "@pan.com",1));
		}
		System.out.println("批量插入完成！！！");
	}
}
