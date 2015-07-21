package com.youwei.makesite.user;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.ThreadSession;
import org.bc.web.WebMethod;

import com.youwei.makesite.util.SecurityHelper;
import com.youwei.makesite.entity.Group;
//
//import com.sun.image.codec.jpeg.JPEGCodec;
//import com.sun.image.codec.jpeg.JPEGImageEncoder;
import com.youwei.makesite.entity.User;
import com.youwei.makesite.entity.UserGroup;
@Module(name="/admin/user")
public class UserService {
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView save(User user  , Integer groupId){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(user.account)){
			throw new GException(PlatformExceptionType.BusinessException,"用户账号不能为空");
		}
		if(StringUtils.isEmpty(user.name)){
			throw new GException(PlatformExceptionType.BusinessException,"用户姓名不能为空");
		}
		if(StringUtils.isEmpty(user.pwd)){
			throw new GException(PlatformExceptionType.BusinessException,"请先设置密码");
		}
		user.addtime = new Date();
		user.pwd = SecurityHelper.Md5(user.pwd);
		//TODO
		dao.saveOrUpdate(user);
		if(groupId!=null){
			UserGroup ug = new UserGroup();
			ug.gid = groupId;
			ug.uid = user.id;
			dao.saveOrUpdate(ug);
		}
		return mv;
	}

	@WebMethod
	public ModelAndView update(User user ){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(user.name)){
			throw new GException(PlatformExceptionType.BusinessException,"用户名不能为空");
		}
		User po = dao.get(User.class, user.id);
//		po.id = user.id;
		po.account = user.account;
		po.name = user.name;
		if(StringUtils.isNotEmpty(user.pwd)){
			po.pwd = SecurityHelper.Md5(user.pwd);
		}
		po.tel = user.tel;
		//TODO
		dao.saveOrUpdate(po);
		return mv;
	}

	@WebMethod
	public ModelAndView delete(int  id){
		ModelAndView mv = new ModelAndView();
		User po = dao.get(User.class, id);
		if(po!=null){
			dao.delete(po);
			dao.execute("delete from UserGroup where uid=?", id);
			mv.data.put("msg", "删除用户成功");
		}
		
		return mv;
	}
	
	@WebMethod
	public ModelAndView banUser(int  groupId , int uid){
		ModelAndView mv = new ModelAndView();
		UserGroup po = dao.getUniqueByParams(UserGroup.class, new String[]{"gid" , "uid" },  new Object[]{groupId , Integer.valueOf(uid)});
		if(po!=null){
			dao.delete(po);
		}
		return mv;
	}
	
	@WebMethod
	public ModelAndView addToGroup(int  groupId , String ids){
		ModelAndView mv = new ModelAndView();
		for(String uid : ids.split(",")){
			if(StringUtils.isEmpty(uid)){
				continue;
			}
			UserGroup po = dao.getUniqueByParams(UserGroup.class, new String[]{"gid" , "uid" },  new Object[]{groupId , Integer.valueOf(uid)});
			if(po!=null){
				continue;
			}
			UserGroup ug = new UserGroup();
			ug.gid = groupId;
			ug.uid = Integer.valueOf(uid);
			dao.saveOrUpdate(ug);
		}
		return mv;
	}
	
	/**
	 * 
	 * @param id 用户组id
	 */
	@WebMethod
	public ModelAndView getOrgData(Integer  id){
		ModelAndView mv = new ModelAndView();
		StringBuilder sb = new StringBuilder("from Group where 1=1");
		List<Object> params = new ArrayList<Object>();
		if(id!=null){
			sb.append(" and parentId=?");
			params.add(id);
		}else{
			sb.append(" and parentId is null");
		}
		List<Group> groups = dao.listByParams(Group.class, sb.toString() , params.toArray());
		JSONArray arr = new JSONArray();
		for(Group p :groups ){
			JSONObject json = new JSONObject();
			json.put("id", p.id);
//			if(pgid==null){
//				json.put("pId", "0");
//			}else{
//				json.put("pId", "g_"+pgid);
//			}
			json.put("name", p.name);
			json.put("type", "group");
			json.put("isParent", true);
			arr.add(json);
		}
		if(id!=null){
			List<Map> users = dao.listAsMap("select u.name as name ,u.id as uid from User u , UserGroup ug where u.id=ug.uid and ug.gid=?" , id);
			for(Map u : users){
				JSONObject json = new JSONObject();
				json.put("id", u.get("uid"));
				json.put("name", u.get("name"));
				json.put("type", "user");
				json.put("isParent", false);
				arr.add(json);
			}
		}
		mv.returnText = arr.toString();
		return mv;
	}
}
