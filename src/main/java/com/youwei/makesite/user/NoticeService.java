package com.youwei.makesite.user;

import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.Transactional;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.WebMethod;

import com.youwei.makesite.entity.Article;
import com.youwei.makesite.entity.Notice;
import com.youwei.makesite.entity.NoticeReceiver;


@Module(name="/admin/notice")
public class NoticeService {

	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);

	@WebMethod
	@Transactional
	public ModelAndView save(Notice notice , String receiverIds){
		ModelAndView mv = new ModelAndView();
		notice.addtime  = new Date();
		notice.senderId=2;
		dao.saveOrUpdate(notice);
		for(String receiver : receiverIds.split(",")){
			if(StringUtils.isEmpty(receiver)){
				continue;
			}
			NoticeReceiver nr = new NoticeReceiver();
			nr.noticeId = notice.id;
			nr.receiverId =Integer.valueOf(receiver);
			nr.hasRead=0;
			dao.saveOrUpdate(nr);
		}
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
