<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib prefix="pg" uri="/WEB-INF/page.tld"%>
<%@ taglib prefix="se" uri="/WEB-INF/security.tld"%>
<!DOCTYPE html>
<html>
	<head>
		<title>训练</title>
		<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/common/css/weui.min.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/common/css/jquery-weui.min.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/common/css/demos.css">
		<script src="${pageContext.request.contextPath}/common/js/jquery-2.1.4.js"></script>
		<script src="${pageContext.request.contextPath}/common/js/fastclick.js"></script>
		<script src="${pageContext.request.contextPath}/common/js/jquery-weui.js"></script>
		<style>
			.mycss1 {
				width:25%;
				float:left;
				color: #999999;
				font-size:15px;
			}
			
			.mycss2 {
				width:75%;
				float:right;
				text-align: left;
				color: #000000;
				font-size:15px;
			}
		</style>
	</head>
	<body>
<div class="weui-tab">
	<div class="weui-tab__bd">
		<div class="weui-panel weui-panel_access">
		<s:if test="#position.positionName != \"队员\"">
			<div class="weui-msg__opr-area">
				<p class="weui-btn-area">
					<a href="${pageContext.request.contextPath}/train/toEdit?teamId=${teamId}" class="weui-btn weui-btn_primary">创建训练</a>
				</p>
			</div>
		</s:if>
		<s:if test="#trains != null && #trains.size()>0">
			<s:iterator value="#trains" var="trainCustom">
				<s:if test="#trainCustom.isRelease == 1">
					<div class="weui-cells weui-cells_form">
						<div class="weui-panel__bd" style="">
							<a href="${pageContext.request.contextPath}/train/showDetails?id=${trainCustom.id}&teamId=${trainCustom.tid}" class="weui-media-box weui-media-box_appmsg">
								<div class="weui-media-box__bd">
									<h2>
										<font color="#09BB07" style="padding-bottom:20px">
											${trainCustom.trainName}
										</font>
									</h2>
									<br/>
									
									<div style="clear:both;width:100%;">
										<div class="mycss1">开始时间</div>
										<div class="mycss2">${trainCustom.startTimeView}</div>
									</div>
									
									<div style="clear:both;width:100%;">
										<div class="mycss1">训练地点</div>
										<div class="mycss2">${trainCustom.trainPlace}</div>
									</div>
									
									<div style="clear:both;width:100%;">
										<div class="mycss1">训练状态</div>
										<div class="mycss2">
											<s:if test="#trainCustom.trainStatus == 2">
												已结束
											 </s:if>
											 <s:elseif test="#trainCustom.trainStatus == 1">
											 	进行中...
											 </s:elseif>
											 <s:else>
											 	未开始
											 </s:else>	
										</div>
									</div>
									
									<div style="clear:both;width:100%;">
										<div class="mycss1">签到类型</div>
										<div class="mycss2">${trainCustom.signTypeView}</div>
									</div>
						
									<div style="clear:both;width:100%;">
										<div class="mycss1">已报名数</div>
										<div id="number_${trainCustom.id}" class="mycss2">${trainCustom.number}</div>
									</div>
									
								</div>
							</a>
							
							<div id="div_${trainCustom.id}" class="weui-panel__ft" style="clear:both">
								<div  class="button_sp_area" >
									<div  class="myid">
										<s:if test="#trainCustom.trainStatus == 2">
											<!-- 已结束 -->
											<button onclick="evalue(${trainCustom.id})" style="margin-left:24%;margin-right:6%" class="weui-btn weui-btn_mini weui-btn_plain-primary">评价</button>
											<button onclick="joinon(${trainCustom.id});" style="margin-right:15%" class="weui-btn weui-btn_mini weui-btn_plain-primary">参训情况</button>
										 </s:if>
										 <s:elseif test="#trainCustom.trainStatus == 1">
										 <!-- 比赛中 -->
											<button onclick="leave(${trainCustom.id});" style="margin-left:16%;margin-right:2%" class="weui-btn weui-btn_mini weui-btn_plain-primary">请假</button>
										 	<button onclick="evalue(${trainCustom.id})" style="margin-right:2%" class="weui-btn weui-btn_mini weui-btn_plain-primary">评价</button>
										 	<button onclick="joinon(${trainCustom.id});" style="margin-right:15%" class="weui-btn weui-btn_mini weui-btn_plain-primary">参训情况</button>
										 </s:elseif>
										 <s:else>
										 	<!-- 未开始 -->
										 	<button onclick="signUp(${trainCustom.id})" style="margin-left:24%;margin-right:2%" class="weui-btn weui-btn_mini weui-btn_plain-primary">报名</button>
											<button onclick="leave(${trainCustom.id});" style="margin-right:2%" class="weui-btn weui-btn_mini weui-btn_plain-primary">请假</button>
										 	<button onclick="evalue(${trainCustom.id})" style="margin-right:15%" class="weui-btn weui-btn_mini weui-btn_plain-primary">评价</button>
										 </s:else>	
									</div>
								</div>
								<br/>
							</div>
							
						</div>
					</div>
				</s:if>
				<s:else>
				<s:if test="#trainCustom.createUser == #currentUserId">
						<div class="weui-cells weui-cells_form">
						<div class="weui-panel__bd" style="">
							<a href="${pageContext.request.contextPath}/train/showDetails?id=${trainCustom.id}&teamId=${trainCustom.tid}" class="weui-media-box weui-media-box_appmsg">
								<div class="weui-media-box__bd">
									<h2>
										<font color="#09BB07" style="padding-bottom:20px">
											${trainCustom.trainName}
										</font>
									</h2>
									<br/>
									
									<div  style="clear:both;width:100%">
										<div class="mycss1">开始时间</div>
										<div class="mycss2">${trainCustom.startTimeView}</div>
									</div>
									
									<div style="clear:both;width:100%;">
										<div class="mycss1">训练地点</div>
										<div class="mycss2">${trainCustom.trainPlace}</div>
									</div>
									<div style="clear:both;width:100%;">
										<div class="mycss1">训练状态</div>
										<div class="mycss2">
											未发布
										</div>
									</div>
			
									<div style="clear:both;width:100%;">
										<div class="mycss1">签到类型</div>
										<div class="mycss2">${trainCustom.signTypeView}</div>
									</div>
									
									<div style="clear:both;width:100%;">
										<div class="mycss1">已报名数</div>
										<div class="mycss2">${trainCustom.number}</div>
									</div>
									
								</div>
							</a>
							
								<div class="weui-panel__ft" style="clear:both">
									<div class="button_sp_area" >
										<div align="center" class="myid">
											<button onclick="release(${trainCustom.id})" class="weui-btn weui-btn_mini weui-btn_plain-primary">发布训练</button>
										</div>
									</div>
									<br/>
								</div>
							 
							</div>
						</div>
					</s:if>
				</s:else>
			</s:iterator>
			<div id="loadDiv" style="display: none;" class="weui-loadmore">
			  <i class="weui-loading"></i>
			  <span class="weui-loadmore__tips">正在加载</span>
			</div>
		</s:if>
		<s:else>
			<div class="weui-media-box" style="text-align: center;">
				暂无训练
			</div>
		</s:else>
		</div>
	</div>
 </div>
	</body>
	<script type="text/javascript">
		var teamId = "${teamId}";
		$(function(){
			var positionName = "${position.positionName}";
			var currentUserId = "${wxuser.id}"
			var page = 2;//第一次加载更多肯定是加载第二页
			$(document.body).infinite(0);//滑到最底部才加载
			//加载的div
			var $div = $("#loadDiv");//加载的div
			var loading = false;  //状态标记
			var falg = true;//还有数据的标志
			$(document.body).infinite().on("infinite", function() {
			  $div.css("display","block");//显示加载div
			  if(loading) return;
			  loading = true;
			  if(falg){
				//请求数据
				  $.post("${pageContext.request.contextPath}/train/ajaxLoadMoreTrainList",{"pageNo":page,"teamId":teamId},function(data){
					  //请求到数据
					  var json = JSON.parse(data);
					  var list = json.data;
					  if(list != null && list.length >0 ){
						  for(var i = 0;i<list.length;i++){
							  var startTime = "";
							  var endTime = "";
							  var trainStatus = "";
							  if(list[i].startTime != null && list[i].startTime != ''){
								 //2017-07-27 16:19:17.0
								 startTime = list[i].startTime;
								 list[i].startTime = startTime.substring(0,startTime.length-5);
							  }
							  if(list[i].endTime != null && list[i].endTime != ''){
								 //2017-07-27 16:19:17.0
								 endTime = list[i].endTime;
							  }
							  //判断状态
							  if(startTime != '' && endTime != ''){
								 var _startTime = new Date(startTime).getTime();
								 var _endTime = new Date(endTime).getTime();
								 var currentTime = new Date().getTime();
								 if (currentTime > _endTime) {
									//已经结束
								 trainStatus = "已结束";
								 } else if ((currentTime >= _startTime) && (currentTime <= _endTime)) {
									//进行中
									 trainStatus = "进行中...";
								 } else {
									//未开始
									 trainStatus = "未开始";
								}
							  }
							  //判断签到
							  var signType = "";
							  var _issign = list[i].issign;
							  var _signTime = list[i].signTime;
							  //不签到
							  if (_issign != null && _issign == 0) {
								 signType = "无需签到";
							  } else {
								 //签到
								 if (_signTime != null && _signTime == 0) {
									 signType = "提前半小时";
								} else if (_signTime != null && _signTime == 1) {
									signType = "提前一小时";
								} else if (_signTime != null && _signTime == 2) {
									signType = "提前两小时";
								} 
							 }
							 //判断显示按钮
							 $btns = "";
							 if(list[i].isRelease == 0){
								 $btns += '<button onclick="release('+list[i].id+')" class="weui-btn weui-btn_mini weui-btn_plain-primary">发布训练</button>';
							 } else if (trainStatus == '已结束'){
								 $btns += '<button onclick="evalue('+list[i].id+')" style="margin-left:24%;margin-right:6%" class="weui-btn weui-btn_mini weui-btn_plain-primary">评价</button>';
						 		 $btns += '<button onclick="joinon('+list[i].id+');" style="margin-right:15%" class="weui-btn weui-btn_mini weui-btn_plain-primary">参训情况</button>'; 
							 } else if (trainStatus == '未开始'){
								 $btns += '<button onclick="signUp('+list[i].id+')" style="margin-left:24%;margin-right:2%" class="weui-btn weui-btn_mini weui-btn_plain-primary">报名</button>';
								 $btns += '<button onclick="leave('+list[i].id+');" style="margin-right:2%" class="weui-btn weui-btn_mini weui-btn_plain-primary">请假</button>';
								 $btns += '<button onclick="evalue('+list[i].id+')" style="margin-right:15%" class="weui-btn weui-btn_mini weui-btn_plain-primary">评价</button>';
							 } else {
								//进行中 
								 $btns += '<button onclick="leave('+list[i].id+');" style="margin-left:16%;margin-right:2%" class="weui-btn weui-btn_mini weui-btn_plain-primary">请假</button>';
								 $btns += '<button onclick="evalue('+list[i].id+')" style="margin-right:2%" class="weui-btn weui-btn_mini weui-btn_plain-primary">评价</button>';
								 $btns += '<button onclick="joinon('+list[i].id+');" style="margin-right:15%" class="weui-btn weui-btn_mini weui-btn_plain-primary">参训情况</button>'; 
							 }
							 $divAppend ='<div class="weui-cells weui-cells_form">'
									 +'<div class="weui-panel__bd" style="">'
									 +'<a href="${pageContext.request.contextPath}/train/showDetails?id='+list[i].id+'&teamId='+teamId+'" class="weui-media-box weui-media-box_appmsg">'
									 +'<div class="weui-media-box__bd">'
									 +'<h2>'
									 +'<font color="#09BB07" style="padding-bottom:20px">'+list[i].trainName
									 +'</font>'
									 +'</h2>'
									 +'<br/>'
									 +'<div style="clear:both;width:100%;">'
									 +'<div class="mycss1">开始时间'
									 +'</div>'
									 +'<div class="mycss2">'+list[i].startTime
									 +'</div>'
									 +'</div>'
									 +'<div style="clear:both;width:100%;">'
									 +'<div class="mycss1">训练地点'
									 +'</div>'
									 +'<div class="mycss2">'+list[i].trainPlace
									 +'</div>'
									 +'</div>'
									 +'<div style="clear:both;width:100%;">'
									 +'<div class="mycss1">训练状态'
									 +'</div>'
									 +'<div class="mycss2">'+trainStatus
									 +'</div>'
									 +'</div>'
									 +'<div style="clear:both;width:100%;">'
									 +'<div class="mycss1">签到类型'
									 +'</div>'
									 +'<div class="mycss2">'+signType
									 +'</div>'
									 +'</div>'
									 +'<div style="clear:both;width:100%;">'
									 +'<div class="mycss1">已报名数'
									 +'</div>'
									 +'<div id="number_'+list[i].id+'" class="mycss2">'+list[i].number
									 +'</div>'
									 +'</div>'
									 +'</div>'
									 +'</a>'
									 +'<div id="div_10" class="weui-panel__ft" style="clear:both">'
									 +'<div  class="button_sp_area" >'
									 +'<div  class="myid">'+$btns
									 +'</div>'
									 +'</div>'
									 +'<br/>'
									 +'</div>'
									 +'</div>'
									 +'</div>';
							if(list[i].isRelease == 0){
							 	//未发布
							 	if(list[i].createUser == currentUserId){
							 		// 当前人是创建比赛人
							 		 $div.before($divAppend);
							 	}
							 } else {
							 	//已发布
							 	 $div.before($divAppend);
							 }
						  }
						  page++;//页数++
						  falg = true;//还有数据
					  } else {
						  //没有更多数据
						  $(document.body).destroyInfinite();
						  // $.toptip("没有更多数据了", 'warning');
						  falg = false;//没有更多数据了
					  }
					  loading = false;
					  $div.css("display","none");//隐藏加载div
				  });
			  } else{
				  $(document.body).destroyInfinite();
				  $div.css("display","none");//隐藏加载div
				  // $.toptip("没有更多数据了", 'warning');
			  }
			});
		});
		
		//报名
		function signUp(trainId){
		//点击确认后的回调函数
		$.confirm("确认报名？","消息确认框", function() {
			$.ajax({
					url:'${pageContext.request.contextPath}/train/signUp?id='+trainId+'&teamId='+teamId,
					type:"post",
					success:function(data){
						var json = $.parseJSON(data);
						var obj = json.data;
						//状态 1：代表成功   2：失败  3：已经报名   4：比赛结束
					  	if(obj==1){
						  	$.toast("报名成功");
						  	//报名人数+1
							$("#number_"+trainId).text(parseInt($("#number_"+trainId).text())+1);
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
		
		//请假
		function leave(trainId){
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
						$.post("${pageContext.request.contextPath}/leave/saveLeave",{"leave.reason":text,"leave.raceOrTrainId":trainId,"leave.raceOrTrain":1,"teamId":teamId},function(data){
								var json = $.parseJSON(data);
								var isLeave = json.data;
				        		if(isLeave ==1) {
				        			$.toast("请假成功！");
				        		} else if(isLeave ==2) {
				        			$.toast("请假成功！");
				        			//报名人数-1
				        			$("#number_"+trainId).text(parseInt($("#number_"+trainId).text())-1);
				        		} else {
				        			$.toast("请假失败",'cancel');
				        		}
							});
						});
				}
			});
			//说明可以请假
			
		}
		
		//评价
		function evalue(trainId){
			window.location.href ='${pageContext.request.contextPath}/feedback/feedBackList?trId='+trainId+'&type=1&tid='+teamId;
		}
		
		//参训情况
		function joinon(trainId){
			window.location.href ="${pageContext.request.contextPath}/train/joinOn?teamId="+teamId+"&id="+trainId;
		}
		
		//发布训练
		function release(trainId){
			$.confirm("确认发布？","消息确认框", function() {
			//点击确认后的回调函数
			window.location.href ='${pageContext.request.contextPath}/train/release?id='+trainId+'&teamId='+teamId;
		}, function() {
		  	//点击取消后的回调函数
	 	});
		}	
	</script>
</html>