﻿<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="se" uri="/WEB-INF/security.tld"%>
<!DOCTYPE html>
<html>
	<head>
		<title>踢球么</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/common/css/weui.min.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/common/css/jquery-weui.min.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/common/css/demos.css">
		<script src="${pageContext.request.contextPath}/common/js/jquery-2.1.4.js"></script>
		<script src="${pageContext.request.contextPath}/common/js/fastclick.js"></script>
		<script src="${pageContext.request.contextPath}/common/js/jquery-weui.js"></script>
		<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	</head>
<body style="background-color: #EFEFF4">
	<script type="text/javascript">
	$(function(){
		//上拉加载
		var pageNo = 1;//第一次加载
		$(document.body).infinite(0);//滑到距底部0px才加载
		//加载的div
		var $div = $("#loadDiv");//加载的div
		var loading = false;  //状态标记
		var falg2 = true;//还有数据的标志
		$("#tab1").infinite().on("infinite", function() {
		  $div.css("display","block");//显示加载div
		  if(loading) return;
		  loading = true;
		  if(falg2){
			//请求数据
			  $.post("${pageContext.request.contextPath}/ajaxLoadMoreHistoryList",{"pageNo":pageNo},function(data){
				  //请求到数据
				  var json = JSON.parse(data);
				  var list = json.data;
				 // alert(list.length);
				  if(list != null && list.length >0 ){
					  for(var i=0; i<list.length; i++){
						  // 1：比赛 2：训练
						  if(list[i].source == 1){
							 //我方头像
							 if(list[i].iconNewName == null || list[i].iconNewName == ''){
								list[i].iconNewName = "common/img/default.png";
							 } else {
								 list[i].iconNewName = "image/"+list[i].iconNewName;
							 }
							 //对手头像
							 if(list[i].opponent == null || list[i].opponent == ''){
								 if(list[i].oppoIcon == null || list[i].oppoIcon == ''){
									list[i].oppoIcon = "common/img/default.png";
								 } else {
									 list[i].oppoIcon = "image/"+list[i].oppoIcon;
								 }
							 } else {
								list[i].oppoIcon = "common/img/default.png";
								list[i].oppoName = list[i].opponent;
							 }
							 //分数
							 if(list[i].myScore == null || list[i].myScore == ''){
								list[i].myScore = "0";
							 }
							 if(list[i].opScore == null || list[i].opScore == ''){
								list[i].opScore = "0";
							 }
							 $div.before('<div class="weui-panel weui-panel_access">'
									 +'<div class="weui-form-preview__ft">'
									 +'<button type="submit" class="weui-form-preview__btn weui-form-preview__btn_primary">'+list[i].itemName
									 +'</button>'
									 +'</div>'
									 +'<div class="weui-panel__bd">'
									 +'<div class="weui-grids">'
									 +'<a href="javascript:void(0)" class="weui-grid js_grid">'
									 +'<div class="weui-grid__icon">'
									 +'<img src="${pageContext.request.contextPath}/'+list[i].iconNewName+'">'
									 +'</div>'
									 +'<p class="weui-grid__label">'+list[i].teamName
									 +'</p>'
									 +'</a>'
									 +'<a href="${pageContext.request.contextPath}/race/showDetails?id='+list[i].id+'&teamId='+list[i].tid+'" class="weui-grid js_grid">'
									 +'<p class="weui-grid__icon">'
									 +'<img style="border-radius:50%" height="70px" width="70px"  src="${pageContext.request.contextPath}/common/img/pk.png">'
									 +'</p>'
									 +'<p class="weui-grid__label">'+list[i].myScore
									 +'&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;'+list[i].opScore
									 +'</p>'
									 +'</a>'
									 +'<a href="javascript:void(0)" class="weui-grid js_grid">'
									 +'<div class="weui-grid__icon">'
									 +'<img src="${pageContext.request.contextPath}/'+list[i].oppoIcon+'">'
									 +'</div>'
									 +'<p class="weui-grid__label">'+list[i].oppoName
									 +'</p>'
									 +'</a>'
									 +'</div>'
									 +'<h5 style="font-weight:normal;padding-top: 10px;padding-left: 10px;">'
									 +'比赛时间：'+list[i].timeView+'&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;'
									 +'<font color="red">已结束</font>'
									 +'</h5>'
									 +'<h5 style="font-weight:normal;padding-top: 10px;padding-left: 10px;">'
									 +'比赛地点：'+list[i].place
									 +'</h5>'
									 +'<h5 style="font-weight:normal;padding-top: 10px;padding-left: 10px;padding-bottom: 10px;">'
									 +'评论数：'+list[i].comments
									 +'</h5>'
									 +'<div style="background-color: #F7F7F7;" class="weui-form-preview__ft">'
									 +'<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="${pageContext.request.contextPath}/race/joinOn?teamId='+list[i].tid+'&id='+list[i].id+'">参赛情况'
									 +'</a>'
									 +'<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="${pageContext.request.contextPath}/feedback/feedBackList?trId='+list[i].id+'&type=0&tid='+list[i].tid+'">前往评价'
									 +'</a>'
									 +'</div>'
									 +'</div>'
									 +'</div>');	
						 } else {
							 //训练
							 $div.before('<div class="weui-panel weui-panel_access">'
									 +'<div class="weui-panel__bd">'
									 +'<a href="${pageContext.request.contextPath}/train/showDetails?id='+list[i].id+'&teamId='+list[i].tid+'" class="weui-cell_access">'
									 +'<div class="weui-panel__bd">'
									 +'<div class="weui-media-box weui-media-box_text">'
									 +'<h4 class="weui-media-box__title">'+list[i].itemName
									 +'</h4>'
									 +'<h5 style="font-weight:normal;">'
									 +'训练时间：'+list[i].timeView+'&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;'
									 +'<font color="red">已结束</font>'
									 +'</h5>'
									 +'<h5 style="font-weight:normal;padding-top: 10px;">'
									 +'训练地点：'+list[i].place
									 +'</h5>'
									 +'</div>'
									 +'</div>'
									 +'</a>'
									 +'<div style="background-color: #F7F7F7;" class="weui-form-preview__ft">'
									 +'<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="${pageContext.request.contextPath}/train/joinOn?teamId='+list[i].tid+'&id='+list[i].id+'">参训情况'
									 +'</a>'
									 +'<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="${pageContext.request.contextPath}/feedback/feedBackList?trId='+list[i].id+'&type=1&tid='+list[i].tid+'">前往评价'
									 +'</a>'
									 +'</div>'
									 +'</div>'
									 +'</div>');
						 } 
					  }
					  pageNo++;//页数++
					  falg2 = true;//还有数据
				  } else {
					   //没有更多数据
					  $("#tab1").destroyInfinite();
					 // $.toptip("没有更多数据了", 'warning');
					  falg2 = false;//没有更多数据了
				  }
				  loading = false;
				  $div.css("display","none");//隐藏加载div
			  });
		  } else{
			  $("#tab1").destroyInfinite();
			  $div.css("display","none");//隐藏加载div
			 // $.toptip("没有更多数据了", 'warning');
		  }
		});
	});	
	</script>
	<div class="weui-tab" >
		<div style="padding-bottom: 50px;" class="weui-tab__bd">
			<div  id="tab1" class="weui-tab__bd-item weui-tab__bd-item--active">
				<!-- 这里是广告位
				<div>
					<a href="">
						<img height="40px" width="100%" src="img/zhuqiu.jpg" alt="">
					</a>
				</div>
				-->
			<s:if test="#homeList == null || #homeList.size() == 0">
				<!-- 没有任何数据 -->
				<div class="weui-panel weui-panel_access">
       				<div class="weui-panel__bd">
						<div class="weui-panel__bd">
	          				<div class="weui-media-box weui-media-box_text">
		            			<h4 class="weui-media-box__title">系统提示</h4>
		            			 <p class="weui-msg__desc">您还没有任何动态，可以前往
		            			 	<a href="${pageContext.request.contextPath}/wxuser/userDetail"><font color="#2900FF">【我】</font></a>
		            			 	中选择一支球队进行操作或者
		            			 	<a href="${pageContext.request.contextPath}/team/toQueryTeam"><font color="#2900FF">【加入球队】</font></a>
		            			 	,如果您还没有任何球队，可以
		            			 	<a href="${pageContext.request.contextPath}/team/teaminfoAdd"><font color="#2900FF">【创建球队】</font></a>
		            			 	！！！</p>
	          				</div>
	        			</div>
        			</div>
				</div>
			</s:if>
			<s:else>
				<s:if test="#afterList != null && #afterList.size() != 0">
					<a href="${pageContext.request.contextPath}/futureDataList">
						<div align="center" style="background-color: #FFF;height: 40px;padding-top: 15px;">
							<font color="#000" size="3px">查看更多未来赛程&nbsp;&nbsp;&nbsp;&nbsp;</font>
							<img src="${pageContext.request.contextPath}/common/img/right.png" style="width:15px;hight:15px;margin-bottom: -2px" >
						</div>
					</a>
				</s:if>
				<s:iterator value="#homeList" status="status" var="home">
					<!-- 1：比赛 2：训练 -->
					<s:if test="#home.source == 1">
						<!-- 比赛 -->
						<div class="weui-panel weui-panel_access">
							<div class="weui-form-preview__ft">
							    <button type="submit" class="weui-form-preview__btn weui-form-preview__btn_primary"><s:property value="#home.itemName"/></button>
							</div>
		        			<div class="weui-panel__bd">
		        				<div class="weui-grids">
		        					<a href="javascript:void(0)" class="weui-grid js_grid">
									    <div class="weui-grid__icon">
									      	<s:if test="#home.iconNewName == null || #home.iconNewName == ''">  
										 		<img src="${pageContext.request.contextPath}/common/img/default.png">
										 	</s:if>  
										    <s:else>  
										    	<img src="${pageContext.request.contextPath}/image/${home.iconNewName}">
										    </s:else>
									      	
									    </div>
									    <p class="weui-grid__label">
									   	 	<s:property value="#home.teamName"/>
									    </p>
								    </a>
									<a href="${pageContext.request.contextPath}/race/showDetails?id=${home.id}&teamId=${home.tid}" class="weui-grid js_grid">
									    <p class="weui-grid__icon">
									    	<img style="border-radius:50%" height="70px" width="70px"  src="${pageContext.request.contextPath}/common/img/pk.png">
									    </p>
									    <p class="weui-grid__label">
									     	<s:if test="#home.myScore == null || #home.myScore == '' ">	
												0
											</s:if>
											<s:else>
												 <s:property value="#home.myScore"/>
											</s:else>
									     	&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;
									     	<s:if test="#home.opScore == null || #home.opScore == ''">	
												0
											</s:if>
											<s:else>
												 <s:property value="#home.opScore"/>
											</s:else>
									    </p>
									</a>
									<a href="javascript:void(0)" class="weui-grid js_grid">
									    
									    <s:if test="#home.oppoId == null || #home.oppoId == ''"> 
									     	<div class="weui-grid__icon">
										      	<img src="${pageContext.request.contextPath}/common/img/default.png">
										    </div>
										    <p class="weui-grid__label">
										     	
										     	<s:if test="#home.opponent == null || #home.opponent == ''">	
													&nbsp;
												</s:if>
												<s:else>
													 <s:property value="#home.opponent"/>
												</s:else>
										    </p>
									 	</s:if>  
									    <s:else>
									      	<div class="weui-grid__icon">
									      		<s:if test="#home.oppoIcon == null || #home.oppoIcon == ''"> 
											 		<img src="${pageContext.request.contextPath}/common/img/default.png">
											 	</s:if>  
											    <s:else> 
											    	<img src="${pageContext.request.contextPath}/image/${home.oppoIcon}">
											    </s:else>
									    	</div>
										    <p class="weui-grid__label">
										     	 <s:property value="#home.oppoName"/>
										    </p>
									    </s:else>
								    </a>
								</div>
								<h5 style="font-weight:normal;padding-top: 10px;padding-left: 10px;">
									比赛时间：${timeView}&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
									<s:if test="#home.statusView == \"已结束\"">
					              		<font color="red">已结束</font>
					              	</s:if>
					              	<s:else>
					              		${statusView}
					              	</s:else>
								</h5>
								<h5 style="font-weight:normal;padding-top: 10px;padding-left: 10px;">
									比赛地点：<s:property value="#home.place"/>
								</h5>
								<h5 style="font-weight:normal;padding-top: 10px;padding-left: 10px;padding-bottom: 10px;">
									评论数：<s:property value="#home.comments"/>
								</h5>
								<s:if test="#home.statusView != \"未开始\"">
								 <!-- 结束 -->
					  				 <div id="btn_div_${home.id}" style="background-color: #F7F7F7;" class="weui-form-preview__ft">
					  				 	<s:if test="#home.statusView == \"进行中...\"">
					  				 		<s:if test="#home.qingJia != null && #home.qingJia != '' ">
			  				 					<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:void(0)"><font color="#888">已请假</font></a>
					  				 		</s:if>
					  				 		<s:else>
					  				 			<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:void(0)" onclick="leave(${home.id},${home.tid});">请假</a>
					  				 		</s:else>
									   	</s:if>
									    <a class="weui-form-preview__btn weui-form-preview__btn_primary" href="${pageContext.request.contextPath}/race/joinOn?teamId=${home.tid}&id=${home.id}">参赛情况</a>
									    <a class="weui-form-preview__btn weui-form-preview__btn_primary" href="${pageContext.request.contextPath}/feedback/feedBackList?trId=${home.id}&type=0&tid=${home.tid}">前往评价</a>
									</div>
								</s:if>
								<s:else>
									<div id="btn_div_${home.id}" style="background-color: #F7F7F7;" class="weui-form-preview__ft">
										<s:if test="#home.signUp == 1">
									    	<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:void(0)"><font color="#888">已报名</font></a>
				  				 		</s:if>
				  				 		<s:else>
				  				 			<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:void(0)" onclick="signUp(${home.id},${home.tid});">报名</a>
				  				 		</s:else>
									    <s:if test="#home.qingJia != null && #home.qingJia != '' ">
			  				 				<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:void(0)"><font color="#888">已请假</font></a>
				  				 		</s:if>
				  				 		<s:else>
				  				 			<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:void(0)" onclick="leave(${home.id},${home.tid});">请假</a>
				  				 		</s:else>
									    <a class="weui-form-preview__btn weui-form-preview__btn_primary" href="${pageContext.request.contextPath}/feedback/feedBackList?trId=${home.id}&type=0&tid=${home.tid}">前往评价</a>
									</div>
								</s:else>
			       			</div>
				   		</div>
			       	</s:if> 
					<s:else>
						<!-- 训练 -->
						<div class="weui-panel weui-panel_access">
		       				<div class="weui-panel__bd">
		        				<a href="${pageContext.request.contextPath}/train/showDetails?id=${home.id}&teamId=${home.tid}" class="weui-cell_access">
									<div class="weui-panel__bd">
				          				<div class="weui-media-box weui-media-box_text">
					            			<h4 class="weui-media-box__title"><s:property value="#home.itemName"/></h4>
					            			<h5 style="font-weight:normal;">
												训练时间：${timeView}&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
												<s:if test="#home.statusView == \"已结束\"">
								              		<font color="red">已结束</font>
								              	</s:if>
								              	<s:else>
								              		${statusView}
								              	</s:else>
											</h5>
											<h5 style="font-weight:normal;padding-top: 10px;">
												训练地点：<s:property value="#home.place"/>
											</h5>
				          				</div>
				        			</div>
							 	</a>
							 	<s:if test="#home.statusView != \"未开始\"">
								 <!-- 结束 -->
					  				 <div id="btnTrain_div_${home.id}" style="background-color: #F7F7F7;" class="weui-form-preview__ft">
					  				 	<s:if test="#home.statusView == \"进行中...\"">
					  				 		<s:if test="#home.qingJia != null && #home.qingJia != '' ">
				  				 				<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:void(0)"><font color="#888">已请假</font></a>
					  				 		</s:if>
					  				 		<s:else>
					  				 			<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:void(0)" onclick="leaveTrain(${home.id},${home.tid});">请假</a>
					  				 		</s:else>
									   	</s:if>
									    <a class="weui-form-preview__btn weui-form-preview__btn_primary" href="${pageContext.request.contextPath}/train/joinOn?teamId=${home.tid}&id=${home.id}">参训情况</a>
									    <a class="weui-form-preview__btn weui-form-preview__btn_primary" href="${pageContext.request.contextPath}/feedback/feedBackList?trId=${home.id}&type=1&tid=${home.tid}">前往评价</a>
									</div>
								</s:if>
								<s:else>
									<div id="btnTrain_div_${home.id}" style="background-color: #F7F7F7;" class="weui-form-preview__ft">
									    <s:if test="#home.signUp == 1">
									    	<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:void(0)"><font color="#888">已报名</font></a>
				  				 		</s:if>
				  				 		<s:else>
				  				 			<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:void(0)" onclick="signUpTrain(${home.id},${home.tid});">报名</a>
				  				 		</s:else>
									    <s:if test="#home.qingJia != null && #home.qingJia != '' ">
			  				 				<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:void(0)"><font color="#888">已请假</font></a>
				  				 		</s:if>
				  				 		<s:else>
				  				 			<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:void(0)" onclick="leaveTrain(${home.id},${home.tid});">请假</a>
				  				 		</s:else>
									    <a class="weui-form-preview__btn weui-form-preview__btn_primary" href="${pageContext.request.contextPath}/feedback/feedBackList?trId=${home.id}&type=1&tid=${home.tid}">前往评价</a>
									</div>
								</s:else>
		        			</div>
		        		</div>
					</s:else>
				</s:iterator>
	        </s:else>
	        <div id="loadDiv" style="display: none;" class="weui-loadmore" >
			  <i class="weui-loading"></i>
			  <span class="weui-loadmore__tips">正在加载</span>
			</div>
			</div>
			<div class="weui-tabbar">
				<a href="javascript:void(0)" class="weui-tabbar__item">
					<div class="weui-tabbar__icon">
						<img src="${pageContext.request.contextPath}/common/img/home_select.png" alt="">
					</div>
					<p class="weui-tabbar__label">动态</p>
				</a>
				<a href="${pageContext.request.contextPath}/sign/findAllList" class="weui-tabbar__item">
					<div class="weui-tabbar__icon">
						<img src="${pageContext.request.contextPath}/common/img/qiandao.png" alt="">
					</div>
					<p class="weui-tabbar__label">签到</p>
				</a>
				<a href="${pageContext.request.contextPath}/notice/findNoticeList" class="weui-tabbar__item">
					<div class="weui-tabbar__icon">
						<img src="${pageContext.request.contextPath}/common/img/manage.png" alt="">
					</div>
					<p class="weui-tabbar__label">通知</p>
				</a>
				<a href="${pageContext.request.contextPath}/wxuser/userDetail" class="weui-tabbar__item">
					<div class="weui-tabbar__icon">
						<img src="${pageContext.request.contextPath}/common/img/my.png" alt="">
					</div>
					<p class="weui-tabbar__label">我</p>
				</a>
			</div>
		
		</div>	
	</div>	
</body>
		<script type="text/javascript">
			//防止返回历史记录
		    pushHistory();
		    function pushHistory() {
		        var state = {
		            title: "title",
		            url: "#"    };
		        window.history.pushState(state, "title", "#");
		    };
		    window.onpopstate = function() {
		        wx.closeWindow();
		    };
		    
		//报名比赛
		function signUp(raceId,teamId){
			//点击确认后的回调函数
			$.confirm("确认报名？", function() {
				$.ajax({
						url:"${pageContext.request.contextPath}/race/signUp?id="+raceId+"&teamId="+teamId,
						type:"post",
						success:function(data){
							var json = $.parseJSON(data);
							var obj = json.data;
							//状态 1：代表成功   2：失败  3：已经报名   4：比赛结束
							if(obj == 1){
								$("#btn_div_"+raceId).empty();
								$("#btn_div_"+raceId).append('<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:void(0)"><font color="#888">已报名</font></a>');
								$("#btn_div_"+raceId).append('<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:void(0)" onclick="leave('+raceId+','+teamId+');">请假</a>');
								$("#btn_div_"+raceId).append('<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="${pageContext.request.contextPath}/feedback/feedBackList?trId='+raceId+'&type=0&tid='+teamId+'">前往评价</a>');
							  	//$.toast("报名成功");
							}else if(obj == 3){
							  	$.toast("已报名，请勿重复操作！",'cancel');
							}else  if(obj == 4){
							  	$.toast("比赛已经结束,请刷新页面",'cancel');
							} else {
							  	$.toast("报名失败",'cancel');
							}
						}
					});
			}, function() {
			  	//点击取消后的回调函数
		 	});  
		}
		
		//报名训练
		function signUpTrain(trainId,teamId){
			//点击确认后的回调函数
			$.confirm("确认报名？", function() {
				$.ajax({
						url:"${pageContext.request.contextPath}/train/signUp?id="+trainId+"&teamId="+teamId,
						type:"post",
						success:function(data){
							var json = $.parseJSON(data);
							var obj = json.data;
							//状态 1：代表成功   2：失败  3：已经报名   4：比赛结束
						  	if(obj==1){
						  		$("#btnTrain_div_"+trainId).empty();
								$("#btnTrain_div_"+trainId).append('<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:void(0)"><font color="#888">已报名</font></a>');
								$("#btnTrain_div_"+trainId).append('<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:void(0)" onclick="leaveTrain('+trainId+','+teamId+');">请假</a>');
								$("#btnTrain_div_"+trainId).append('<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="${pageContext.request.contextPath}/feedback/feedBackList?trId='+trainId+'&type=1&tid='+teamId+'">前往评价</a>');
							  	//$.toast("报名成功");
						  	}else if(obj==3){
						  		$.toast("已报名，请勿重复操作！",'cancel');
						  	}else if(obj==4){
						  		$.toast("训练已经结束,请刷新页面",'cancel');
						  	}else{
						  		$.toast("报名失败",'cancel');
						  	}
						}
					});
			}, function() {
			  	//点击取消后的回调函数
		 	});
		}
		
		//请假比赛
		function leave(raceId,teamId){
			var content = $("#btn_div_"+raceId).children("a").text();
			//点击按钮后先校验是否比赛已结束，再弹框填入请假原因
			$.post("${pageContext.request.contextPath}/race/leave",{"id":raceId,"teamId":teamId},function(data){
				var json = $.parseJSON(data);
				var obj = json.data; 
				//状态 1：可以请假   2：异常   3：已经请过假  4：比赛已结束
				if(obj == 4){
					$.toast("比赛已经结束,请刷新页面",'cancel');
				} else if(obj == 3){
					$.toast("已请假，请勿重复操作！",'cancel');
				} else if(obj == 2){
					$.toast("服务器异常,请耐心等待...",'cancel');
				} else{
					$.prompt("请输入请假原因", function(text) {
					//text 是用户输入的内容
					$.post("${pageContext.request.contextPath}/leave/saveLeave",{"leave.reason":text,"leave.raceOrTrainId":raceId,"leave.raceOrTrain":2,"teamId":teamId},function(data2){
							var json2 = $.parseJSON(data2);
							var isLeave = json2.data;
			        		if(isLeave == 1 || isLeave == 2) {
			        			$("#btn_div_"+raceId).empty();
			        			if (content.includes('报名请假')) {
			        				//说明是未开始
									$("#btn_div_"+raceId).append('<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:void(0)" onclick="signUp('+raceId+','+teamId+');">报名</a>');
									$("#btn_div_"+raceId).append('<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:void(0)"><font color="#888">已请假</font></a>');
			        			} else {
			        				//进行中
			        				$("#btn_div_"+raceId).append('<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:void(0)"><font color="#888">已请假</font></a>');
			        				$("#btn_div_"+raceId).append('<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="${pageContext.request.contextPath}/race/joinOn?teamId='+teamId+'&id='+raceId+'">参赛情况</a>');
			        			}
									$("#btn_div_"+raceId).append('<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="${pageContext.request.contextPath}/feedback/feedBackList?trId='+raceId+'&type=0&tid='+teamId+'">前往评价</a>');
			        			//$.toast("请假成功！");
			        		} else {
			        			$.toast("请假失败",'cancel');
			        		}
						});
					});
				}
			});
			//说明可以请假
			
		}
		
		//请假训练
		function leaveTrain(trainId,teamId){
			var content = $("#btnTrain_div_"+trainId).children("a").text();
			//点击按钮后先校验是否训练已结束，再弹框填入请假原因
			$.post("${pageContext.request.contextPath}/train/leave",{"id":trainId,"teamId":teamId},function(data){
				var json = $.parseJSON(data);
				var obj = json.data;
				//状态 1：可以请假   2：异常   3：已经请过假  4：比赛已结束
				if(obj == 4){
					$.toast("训练已经结束,请刷新页面",'cancel');
				}else if(obj == 3){
					$.toast("已请假，请勿重复操作！",'cancel');
				}else if(obj == 2){
					$.toast("服务器异常,请耐心等待...",'cancel');
				} else{
					$.prompt("请输入请假原因", function(text) {
					//text 是用户输入的内容
					$.post("${pageContext.request.contextPath}/leave/saveLeave",{"leave.reason":text,"leave.raceOrTrainId":trainId,"leave.raceOrTrain":1,"teamId":teamId},function(data2){
							var json2 = $.parseJSON(data2);
							var isLeave = json2.data;
			        		if(isLeave ==1 || isLeave ==2) {
			        			$("#btnTrain_div_"+trainId).empty();
			        			if (content.includes('报名请假')) {
			        				//说明是未开始
									$("#btnTrain_div_"+trainId).append('<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:void(0)" onclick="signUpTrain('+trainId+','+teamId+');">报名</a>');
									$("#btnTrain_div_"+trainId).append('<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:void(0)"><font color="#888">已请假</font></a>');
			        			} else {
			        				//进行中
			        				$("#btnTrain_div_"+trainId).append('<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="javascript:void(0)"><font color="#888">已请假</font></a>');
			        				$("#btnTrain_div_"+trainId).append('<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="${pageContext.request.contextPath}/train/joinOn?teamId='+teamId+'&id='+trainId+'">参训情况</a>');
			        			}
									$("#btnTrain_div_"+trainId).append('<a class="weui-form-preview__btn weui-form-preview__btn_primary" href="${pageContext.request.contextPath}/feedback/feedBackList?trId='+trainId+'&type=0&tid='+teamId+'">前往评价</a>');
			        			//$.toast("请假成功！");
			        		} else {
			        			$.toast("请假失败",'cancel');
			        		}
						});
					});
				}
			});
		}
	</script>
</html>