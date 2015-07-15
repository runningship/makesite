<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>微信公众平台</title>
<jsp:include page="inc/header.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="inc/top.jsp"></jsp:include>
	<div class="body">
		<div class="container_box cell_layout side_l">

			<jsp:include page="inc/menu.jsp"></jsp:include>
			<div class="col_main">
				<div class="index_show_area">
					<div class="index_tap added">
						<ul class="inner">
							<li class="grid_item size1of2 index_tap_item added_message"><a href="#"> <span class="tap_inner"> <i class="icon_index_tap"></i> <em class="number">0</em> <strong class="title">新消息</strong>
								</span>
							</a></li>
							<li class="grid_item size1of2 no_extra index_tap_item added_fans"><a href="#"> <span class="tap_inner no_extra"> <i class="icon_index_tap"></i> <em class="number">0</em> <strong
										class="title">新增人数</strong>
								</span>
							</a></li>
						</ul>
					</div>
					&nbsp;
					<div class="index_tap total">
						<ul class="inner">
							<li class="index_tap_item total_fans extra"><a href="#"> <span class="tap_inner"> <i class="icon_index_tap"></i> <em class="number">912</em> <strong class="title">总用户数</strong>
								</span>
							</a></li>
						</ul>
					</div>
				</div>
				<div class="mp_news_area notices_box">

					<div class="title_bar">
						<h3>系统公告</h3>
					</div>
					<ul class="mp_news_list">

						<li class="mp_news_item"><a href="#" target="_blank"> <strong>公众号文章新增语音功能 <i class="icon_common new"></i>
							</strong> <span class="read_more">2015-07-10</span>
						</a></li>

					</ul>

				</div>

				<div class="pagination_wrp">
					<div class="pagination">
						<span class="page_nav_area"> <a href="javascript:void(0);" class="btn page_first" style="display: none;"></a> <a href="javascript:void(0);" class="btn page_prev" style="display: none;"><i
								class="arrow"></i></a> <span class="page_num"> <label>1</label> <span class="num_gap">/</span> <label>5</label>
						</span> <a href="javascript:void(0);" class="btn page_next"><i class="arrow"></i></a> <a href="javascript:void(0);" class="btn page_last" style="display: none;"></a>
						</span> <span class="goto_area"> <input type="text"> <a href="javascript:void(0);" class="btn page_go">跳转</a>
						</span>

					</div>
				</div>


			</div>
		</div>

	</div>
	<div class="foot"></div>