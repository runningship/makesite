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

import com.youwei.makesite.entity.Group;
//
//import com.sun.image.codec.jpeg.JPEGCodec;
//import com.sun.image.codec.jpeg.JPEGImageEncoder;
import com.youwei.makesite.entity.User;
@Module(name="/admin/group")
public class GroupService {
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView save(Group group ){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(group.name)){
			throw new GException(PlatformExceptionType.BusinessException,"用户组名称不能为空");
		}
		group.owner = 2;
		group.addtime = new Date();
		dao.saveOrUpdate(group);
		return mv;
	}

	@WebMethod
	public ModelAndView update(Group group ){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(group.name)){
			throw new GException(PlatformExceptionType.BusinessException,"用户名不能为空");
		}
		User po = dao.get(User.class, group.id);
		po.name = group.name;
		dao.saveOrUpdate(po);
		return mv;
	}

	@WebMethod
	public ModelAndView delete(int  id){
		ModelAndView mv = new ModelAndView();
		Group po = dao.get(Group.class, id);
		if(po!=null){
			dao.delete(po);
			mv.data.put("msg", "删除用户组成功");
		}
		return mv;
	}
}
