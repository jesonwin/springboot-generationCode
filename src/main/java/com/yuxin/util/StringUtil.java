package com.yuxin.util;

import java.util.Random;

/**
 * 字符串处理工具类
 * @ClassName: StringUtil 
 * @author 喻鑫
 * @Description: TODO
 * @date 2017年8月27日 下午4:44:39
 */
public class StringUtil {
	private static Random random=new Random();
	private static char[] randomChar=new char[]{'1','2','3','4','5','6','7','8','9','0','Q',
												'W','E','R','T','Y','U','I','O','P','A','S',
												'D','F','G', 'H','J','K','L','Z','X','C','V',
												'B','N','M','q','w','e','r','t','y','u','i',
												'o','p','a','s','d','f','g','h','j','k','l',
												'z','x','c','v','b','n','m'};

	public static boolean isEmpty(String str){
		if(str==null||"".equals(str.trim())){
			return true;
		}else{
			return false;
		}
	}
	
	
	public static boolean isNotEmpty(String str){
		if((str!=null)&&!"".equals(str.trim())){
			return true;
		}else{
			return false;
		}
	}

	public static String randomStr(Integer length){
		StringBuffer result=new StringBuffer();
		for (int i=0;i<length;i++){
			result.append(randomChar[random.nextInt(62)]);
		}
		return result.toString();
	}

	public static String autoFillZero(Integer length,int number){
		String format="%0"+length+"d";
		// 0 代表前面补充0
		// length 代表长度
		// d 代表参数为正数型
		return String.format(format, number);
	}

	public static Integer castInt(String intStr){
		return Integer.parseInt(intStr.replaceFirst("^0*", ""));
	}

	public static String capFrist(String str){
		str = str.replace(str.substring(0, 1), str.substring(0, 1).toUpperCase());
		return str;
	}

}
