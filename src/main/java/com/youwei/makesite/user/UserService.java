package com.youwei.makesite.user;

import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.WebMethod;

import com.youwei.makesite.util.SecurityHelper;
//
//import com.sun.image.codec.jpeg.JPEGCodec;
//import com.sun.image.codec.jpeg.JPEGImageEncoder;
import com.youwei.makesite.entity.User;
@Module(name="/admin/user")
public class UserService {
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView save(User user ){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(user.name)){
			throw new GException(PlatformExceptionType.BusinessException,"用户名不能为空");
		}
		if(StringUtils.isEmpty(user.pwd)){
			throw new GException(PlatformExceptionType.BusinessException,"请先设置密码");
		}
		user.addtime = new Date();
		user.pwd = SecurityHelper.Md5(user.pwd);
		//TODO
		dao.saveOrUpdate(user);
		mv.data.put("msg", "添加用户成功");
		return mv;
	}
}
