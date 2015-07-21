package com.youwei.makesite.user;

import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.ThreadSession;
import org.bc.web.WebMethod;

import com.youwei.makesite.cache.ConfigCache;
import com.youwei.makesite.entity.Article;
import com.youwei.makesite.entity.Menu;
import com.youwei.makesite.entity.User;
import com.youwei.makesite.entity.UserGroup;
import com.youwei.makesite.util.DataHelper;
import com.youwei.makesite.util.SecurityHelper;


@Module(name="/admin/article")
public class ArticleService {

	static final int MAX_SIZE = 1024000*100;
	static final String BaseFileDir = ConfigCache.get("upload_path", "");
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);

	@WebMethod
	public ModelAndView save(Article art){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(art.name)){
			throw new GException(PlatformExceptionType.BusinessException,"标题不能为空");
		}
		//TODO
		dao.saveOrUpdate(art);
		return mv;
	}

	@WebMethod
	public ModelAndView update(Article art){
		ModelAndView mv = new ModelAndView();
		if(StringUtils.isEmpty(art.name)){
			throw new GException(PlatformExceptionType.BusinessException,"标题不能为空");
		}
		Article po = dao.get(Article.class, art.id);
		po.name = art.name;
		po.conts = art.conts;
		//TODO
		dao.saveOrUpdate(po);
		return mv;
	}
	
	@WebMethod
	public ModelAndView delete(int  id){
		ModelAndView mv = new ModelAndView();
		Article po = dao.get(Article.class, id);
		if(po!=null){
			dao.delete(po);
		}
		return mv;
	}
}
