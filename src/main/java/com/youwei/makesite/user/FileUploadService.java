package com.youwei.makesite.user;

import java.io.File;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import org.bc.sdak.CommonDaoService;
import org.bc.sdak.GException;
import org.bc.sdak.TransactionalServiceHelper;
import org.bc.web.ModelAndView;
import org.bc.web.Module;
import org.bc.web.PlatformExceptionType;
import org.bc.web.ThreadSession;
import org.bc.web.WebMethod;

import com.youwei.makesite.cache.ConfigCache;
import com.youwei.makesite.entity.SharedFile;
import com.youwei.makesite.entity.User;
import com.youwei.makesite.util.DataHelper;


@Module(name="/admin/file")
public class FileUploadService {

	static final int MAX_SIZE = 1024000*100;
	static final String BaseFileDir = ConfigCache.get("upload_path", "");
	CommonDaoService dao = TransactionalServiceHelper.getTransactionalService(CommonDaoService.class);
	
	@WebMethod
	public ModelAndView upload(){
		ModelAndView mv = new ModelAndView();
		HttpServletRequest request = ThreadSession.HttpServletRequest.get();
		FileItemFactory factory = new DiskFileItemFactory();
		ServletFileUpload upload = new ServletFileUpload(factory);
		try{
			List<FileItem> items = upload.parseRequest(request);
			for(FileItem item : items){
				if(item.isFormField()){
					continue;
				}
				if(item.getSize()<=0){
					throw new RuntimeException("no file selected.");
				}else if(item.getSize()>=MAX_SIZE){
						throw new RuntimeException("file size exceed 5M");
				}else{
					
					SharedFile file = new SharedFile();
					file.uploadTime = new Date();
					String path = BaseFileDir+File.separator ;
					String webpath = request.getServerName() +File.separator + DataHelper.sdf4.format(file.uploadTime);
					
					
					file.name = item.getName();
					file.size = item.getSize();
					file.fileId = UUID.randomUUID().toString();
					file.uid = 2;
					String ext = "";
					String[] arr = file.name.split("\\.");
					if(arr.length>0){
						ext = arr[arr.length-1];
					}
					String saveName = file.fileId+"."+ext;
					file.path = webpath+File.separator + saveName;
					//增加域名
					String savePath= path +webpath + File.separator + saveName;
					
					FileUtils.copyInputStreamToFile(item.getInputStream(), new File(savePath));
					dao.saveOrUpdate(file);
				}
			}
			mv.data.put("result", 0);
			return mv;
		}catch(Exception ex){
			throw new GException(PlatformExceptionType.BusinessException,"文件上传失败" , ex);
		}
	}

	@WebMethod
	public ModelAndView delete(int  id){
		ModelAndView mv = new ModelAndView();
		SharedFile po = dao.get(SharedFile.class, id);
		if(po!=null){
			dao.delete(po);
			mv.data.put("msg", "删除文件成功");
		}
		return mv;
	}
}
