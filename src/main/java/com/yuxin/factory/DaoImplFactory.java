package com.yuxin.factory;

import java.io.IOException;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.yuxin.util.*;

import freemarker.template.TemplateException;

public class DaoImplFactory {
	/*
	 * daoImpl文件生成
	 */
	public static void createDaoImpl() {
		// 获取配置信息
		System.out.println("@@@@@@@@@@@@@@@@@@@@开始createDaoImpl@@@@@@@@@@@@@@@@@@");
		String clz = PropertiesUtils.getValue("base", "tableName");
		String basepackage = PropertiesUtils.getValue("base", "base-package", new Object[] { clz.toLowerCase() });
		String pojo = PropertiesUtils.getValue("base", "pojo-package", new Object[] { clz.toLowerCase() });
		String daobase = PropertiesUtils.getValue("base", "dao-package", new Object[] { clz.toLowerCase() });
		String daoImplbase = PropertiesUtils.getValue("base", "daoimpl-package", new Object[] { clz.toLowerCase() });

		Map<String, Object> map = dataMapDaoImpl(clz, basepackage, pojo, daobase, daoImplbase);// 组装map信息
		try {
			StringWriter out = FreemarkerUtils.freeMarker(map, "/daoImpl.ftl");// 构建freemarker
			String javaName = StringUtil.capFrist(clz) + "DaoImpl";
			FreemarkerUtils.writeStreamToFile(javaName, daoImplbase, out);// 将freemark返回的文件流写入文件
		} catch (IOException e) {
			e.printStackTrace();
		} catch (TemplateException e) {
			e.printStackTrace();
		}
		System.out.println("@@@@@@@@@@@@@@@@@@@@完成createDaoImpl@@@@@@@@@@@@@@@@@@");
	}

	/*
	 * 读取数据库表信息，组装map对象
	 */
	private static Map<String, Object> dataMapDaoImpl(String clz, String basepackage, String pojo, String daobase,
			String daoImplbase) {
		// 构建对象
		List<Object> list = new ArrayList<Object>();
		List<String> columns = ConnectionManager.getMetaDataDbmd(clz);
		for (String str:columns) {
			System.out.println(str);
		}
		for (String column : columns) {
			String[] attr = column.split(",");
			String type = PropertiesUtils.getValue("dbType", attr[1]);
			System.out.println(type);
			list.add(new Attribute(attr[0], type, attr[2]));// URLDecoder.decode(attr[3], "UTF-8")
		}
		// 模板赋值
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("basepackage", basepackage + ".dao.impl");
		map.put("pojopackage", pojo);
		map.put("daopackage", daobase);
		map.put("daoImplpackage", daoImplbase);
		map.put("className", StringUtil.capFrist(clz));
		map.put("date", DateUtil.getCurrentDateStr());
		map.put("attr",list);
		return map;
	}
}
