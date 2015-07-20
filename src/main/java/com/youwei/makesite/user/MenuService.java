package com.youwei.makesite.user;

import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.ThreadSession;
import org.bc.web.WebMethod;

import com.youwei.makesite.cache.ConfigCache;
import com.youwei.makesite.entity.Menu;
import com.youwei.makesite.entity.User;
import com.youwei.makesite.util.DataHelper;


@Module(name="/admin/menu")
public class MenuService {

	static final int MAX_SIZE = 1024000*100;
	static final String BaseFileDir = ConfigCache.get("upload_path", "");
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView delete(int  id){
		ModelAndView mv = new ModelAndView();
		Menu po = dao.get(Menu.class, id);
		if(po!=null){
			dao.delete(po);
			mv.data.put("msg", "删除文件成功");
		}
		return mv;
	}
}
