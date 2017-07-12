/**
 * @Title: Msg.java
 * @Package: com.pan.ssm.bean
 * @Description: 用於返回JSON数据
 * @Author: Pan
 * @Date: 2017年7月7日
 */
package com.pan.ssm.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * @ClassName: Msg
 * @Description: TODO
 * @author Pan
 * @date 2017年7月7日
 *
 */
public class Msg {

	private int code;

	private String msg;

	private Map<String, Object> info = new HashMap<>();

	/**
	 *
	 * @Title: success
	 * @Description: 返回处理成功信息
	 * @return Msg
	 * @throws
	 *
	 * @return
	 */
	public static Msg success() {
		Msg msg = new Msg();
		msg.setCode(100);
		msg.setMsg("处理成功！！！");
		return msg;
	}

	/**
	 *
	 * @Title: fail
	 * @Description: 返回处理失败信息
	 * @return Msg
	 * @throws
	 *
	 * @return
	 */
	public static Msg fail() {
		Msg msg = new Msg();
		msg.setCode(200);
		msg.setMsg("处理失败！！！");
		return msg;
	}

	/**
	 *
	 * @Title: add
	 * @Description: 保存返回数据
	 * @return Msg
	 * @throws
	 *
	 * @param key
	 * @param value
	 * @return
	 */
	public Msg add(String key,Object value) {
		this.getInfo().put(key, value);
		return this;
	}

	/**
	 * @return the code
	 */
	public int getCode() {
		return code;
	}

	/**
	 * @param code the code to set
	 */
	public void setCode(int code) {
		this.code = code;
	}

	/**
	 * @return the msg
	 */
	public String getMsg() {
		return msg;
	}

	/**
	 * @param msg the msg to set
	 */
	public void setMsg(String msg) {
		this.msg = msg;
	}

	/**
	 * @return the info
	 */
	public Map<String, Object> getInfo() {
		return info;
	}

	/**
	 * @param info the info to set
	 */
	public void setInfo(Map<String, Object> info) {
		this.info = info;
	}

}
