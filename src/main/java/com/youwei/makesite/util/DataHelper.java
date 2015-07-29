package com.youwei.makesite.util;

import java.io.File;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;

import com.youwei.makesite.cache.ConfigCache;

public class DataHelper {

	public static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static SimpleDateFormat dateSdf = new SimpleDateFormat("yyyy-MM-dd");
	public static SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	public static SimpleDateFormat sdf3 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	public static SimpleDateFormat sdf4 = new SimpleDateFormat("yyyyMMdd");
	
	
	public static long getDiskSize(String serverName){
		String baseDir = ConfigCache.get("upload_path", "");
		File file = new File(baseDir +File.separator+ serverName);
		if(!file.exists()){
			file.mkdir();
		}
		return FileUtils.sizeOfDirectory(file);
	}
	
	public static String getServerName(HttpServletRequest req){
		return "ahlxtz";
//		return req.getServerName();
	}
}
