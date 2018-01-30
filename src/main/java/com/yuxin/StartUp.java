package com.yuxin;

import com.yuxin.factory.ControllerFactory;
import com.yuxin.factory.DaoFactory;
import com.yuxin.factory.DaoImplFactory;
import com.yuxin.factory.PojoFactory;
import com.yuxin.factory.ServiceFactory;
import com.yuxin.factory.ServiceImplFactory;

public class StartUp {
	public static void main(String[] args) {
		PojoFactory.createPojo();
		DaoFactory.createDao();
		DaoImplFactory.createDaoImpl();
		ServiceFactory.createService();
		ServiceImplFactory.createserviceImpl();
		ControllerFactory.createController();
	}
}
