<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">

function prePage(currentPageNo){
	currentPageNo--;
	window.location = window.location.pathname+"?currentPageNo="+currentPageNo;
}

function nextPage(currentPageNo){
	currentPageNo++;
	window.location = window.location.pathname+"?currentPageNo="+currentPageNo;
}
</script>

<div class="pagination_wrp">
	<div class="pagination">
		<span class="page_nav_area"> <a href="javascript:void(0);" class="btn page_first" style="display: none;"></a> <a href="javascript:void(0);" class="btn page_prev" style="display: none;"><i
				class="arrow"></i></a> <span class="page_num"> <label>${page.currentPageNo }</label> <span class="num_gap">/</span> <label>${page.totalPageCount }</label>
		</span> <a href="javascript:void(0);" class="btn page_next" onclick="nextPage(${page.currentPageNo});"><i class="arrow"></i></a>
		 <a onclick="prePage(${page.currentPageNo});" href="javascript:void(0);" class="btn page_last" style="display: ;"></a>
		</span> <span class="goto_area"> <input type="text"> <a href="javascript:void(0);" class="btn page_go">跳转</a>
		</span>
	</div>
</div>