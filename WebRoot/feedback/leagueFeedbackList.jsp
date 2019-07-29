<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1,user-scalable=no">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>比赛评价</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/common/xing/jb51.css" />
		<link rel="stylesheet" href="${pageContext.request.contextPath}/common/css/weui.min.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/common/css/jquery-weui.min.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/common/css/demos.css">
		<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery-2.1.4.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery-weui.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery-form.js"></script>
		<script type="text/javascript"  src="${pageContext.request.contextPath}/common/xing/jb51.js" ></script>
	</head>
	<body style="background-color: #F7F7F7;">
		<div class="weui-panel weui-panel_access">
			<div class="weui-panel__bd">
				<div class="weui-media-box" align="center">
					<b><!-- 比赛名称 -->
						<s:if test="info[1] == null || info[1] == ''">
							<s:property value="info[0]"/>
						</s:if>
						<s:else>
							<s:property value="info[1]"/>
						</s:else>
					</b><br>
					<!-- 队伍1名称 -->
					<s:if test="info[4] != null || info[4] != '' ">
						<s:property value="info[4]"/>
					</s:if>
					<s:else>
						<s:property value="info[6]"/>
					</s:else><b>&nbsp;VS</b>&nbsp;
					<!-- 队伍2名称 -->
					<s:if test="info[5] != null || info[5] != '' ">
						<s:property value="info[5]"/>
					</s:if>
					<s:else>
						<s:property value="info[7]"/>
					</s:else><br>
					<!-- 比分 -->
					<b>
						<s:if test="(info[8] == null || info[8] == '') && (info[9] == null || info[9] == '')">
							0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0
						</s:if>
						<s:else>
							<s:property value="info[8]"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<s:property value="info[9]"/>
						</s:else>
					</b><br>
					<s:else>
						<s:iterator begin="1" end="score">
							<img src="${pageContext.request.contextPath}/common/img/xing.png" />
						</s:iterator>
					</s:else><br>
					<a href="${pageContext.request.contextPath}/feedback/leagueFeedBackAdd?lmid=<s:property value="lmid"/>"
					 class="weui-btn weui-btn_mini weui-btn_primary">前往评价</a>
			</div>
		</div>
	</div>
	<s:if test="feedBacks != null && feedBacks.size() > 0">
		<s:iterator value="feedBacks" status="status" var="fb">
			<div class="weui-panel weui-panel_access">
				<div class="weui-panel__bd">
					<div class="weui-media-box weui-media-box_appmsg">
						<div class="weui-media-box__hd">
							<img style="border-radius:50%" height="60px" width="60px" class="weui-media-box__thumb" 
							src="
								<s:if test="#fb[1] == null || #fb[1] == ''">
									<s:property value='%{#fb[0]}'/>
								</s:if>
								<s:else>
									${pageContext.request.contextPath}/image/<s:property value='%{#fb[0]}'/>
								</s:else>
							">
						</div>
						<div class="weui-media-box__bd">
							<h5 class="weui-media-box__text" style="padding-top:1px">
								<font color="#1D1D1D">
									<s:property value="%{#fb[2]}"/>
								</font>
								<div style="color: #C4C4C4;">
									<font size="2">
										<s:date name="%{#fb[5]}" format="yyyy-MM-dd HH:mm"/>
									</font>
								</div>
								<div style="padding-top:5px">
									<s:if test="#fb[3] == 0">
										追评
									</s:if>
									<s:else>
										<s:iterator begin="1" end="#fb[3]">
											<img src="${pageContext.request.contextPath}/common/img/xing.png" />
										</s:iterator>
									</s:else>
								</div>
								<div style="padding-top:5px">
									<s:property value="%{#fb[4]}"/>
								</div>
							</h5>
						</div>
					</div>
				</div>
			</div>	
		</s:iterator>
		<div id="loadDiv" style="display: none;" class="weui-loadmore">
		  <i class="weui-loading"></i>
		  <span class="weui-loadmore__tips">正在加载</span>
		</div>
	</s:if>
	<s:else>
		<div class="weui-panel weui-panel_access">
			<div class="weui-panel__bd">
				<div class="weui-media-box weui-media-box_appmsg">
					暂无评论
				</div>
			</div>
		</div>	
	</s:else>

		<script type="text/javascript">
			$(function(){
				var lmid = '${lmid}';
				var page = 2;//第一次加载更多肯定是加载第二页
				$(document.body).infinite(400);//滑到刚到表单就加载
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
					 $.post("${pageContext.request.contextPath}/feedback/ajaxLoadMoreLeagueFeedBackList",{"pageNo":page,"lmid":lmid},function(data){
						  //请求到数据
						  var json = JSON.parse(data);
						  var list = json.data;
						  if(list != null && list.length >0 ){
							  for(var i = 0;i<list.length;i++){
								 var icon = '';
								 if((list[i].headPortrait == null || list[i].headPortrait == '') && (list[i].headPortraitNew == null || list[i].headPortraitNew == '')){
									 icon = "${pageContext.request.contextPath}/common/img/default.png";
								 } else {
									 if(list[i].headPortrait == null || list[i].headPortrait == ''){
										 icon = list[i].headPortraitNew;
									 } else{
										 icon = "${pageContext.request.contextPath}/image/"+list[i].headPortraitNew;
									 }
								 }
								 
								 var createTime = list[i].createTime;
								 list[i].createTime = createTime.substring(0,createTime.length-5);
								 var imgs = '';
								 var score = list[i].score;
								 if(score != null && score != ''){
									for(var j = 1;j <= score; j++){
										imgs += '<img src="${pageContext.request.contextPath}/common/img/xing.png" />';
									}
								} 
								$div.before('<div class="weui-panel weui-panel_access">'
			    						+'<div class="weui-panel__bd">'
			    						+'<div class="weui-media-box weui-media-box_appmsg">'
			    						+'<div class="weui-media-box__hd">'
			    						+'<img style="border-radius:50%" height="60px" width="60px" class="weui-media-box__thumb" src="'+icon+'">'
			    						+'</div><div class="weui-media-box__bd">'
			    						+'<h5 class="weui-media-box__text" style="padding-top:1px">'
			    						+'<font color="#1D1D1D">'+list[i].nickname
			    						+'</font><div style="color: #C4C4C4;">'
			    						+'<font size="2">'+list[i].createTime
			    						+'</font>'
			    						+'</div>'
			    						+'<div style="padding-top:5px">'+imgs
			    						+'</div>'
			    						+'<div style="padding-top:5px">'+list[i].comment
			    						+'</div>'
			    						+'</h5>'
			    						+'</div>'
			    						+'</div>'
			    						+'</div>'
			    						+'</div>');
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
		
			var score = "";
			//星
			function chooseNum(num) {
				score = num;
			}
			//计数
			$("#content").keyup(function(){
				var iNum = $("#content").val().length;
				if(iNum <= 200){
					$("#iNum").text(iNum);
				} else{
					$("#content").val($("#content").val().substring(0, 200));
				}
			});
			$("#confirm").click(function(){
				//获取表单
				var form = $("#myForm");
				var iNum = $("#content").val().trim().length;
				if(iNum == 0){
					$.toptip("评价不能为空！！！", 'warning');
					return;
				}
				//星
				var imgs = '';
				if(score != null && score != ''){
					for(var i = 1;i <= score; i++){
						imgs += '<img src="${pageContext.request.contextPath}/common/img/xing.png" />';
					}
				}else{
					$.toptip("请选择评价分数！！！", 'warning');
					return;
				}
				// 用户昵称
				var nickname = "${wxuser.nickname}";
				// 头像
				var headPortraitNew = "${wxuser.headPortraitNew}";
				var headPortrait = "${wxuser.headPortrait}";
				var icon = "";
				if((headPortrait == null || headPortrait == '') && (headPortraitNew == null || headPortraitNew == '')){
					 icon = "${pageContext.request.contextPath}/common/img/default.png";
				 } else {
					 if(headPortrait == null || headPortrait == ''){
						 icon = headPortraitNew;
					 } else{
						 icon = "${pageContext.request.contextPath}/image/"+headPortraitNew;
					 }
				 }
				// 发布时间
				var now = new Date().format("yyyy-MM-dd hh:mm");
				// 内容
				var content = $("#content").val();
				// 比赛/训练id
				var lmid = "${lmid}";
				$.post("${pageContext.request.contextPath}/feedback/ajaxSaveContent",{"lmid":lmid,"score":score,"content":content},function(data){
					var json = $.parseJSON(data);
					var id = json.data;
	        		if(id != null) {
	        			//动态添加内容
	    				form.before('<div class="weui-panel weui-panel_access">'
	    						+'<div class="weui-panel__bd">'
	    						+'<div class="weui-media-box weui-media-box_appmsg">'
	    						+'<div class="weui-media-box__hd">'
	    						+'<img style="border-radius:50%" height="60px" width="60px" class="weui-media-box__thumb" src="'+icon+'">'
	    						+'</div><div class="weui-media-box__bd">'
	    						+'<h5 class="weui-media-box__text" style="padding-top:1px">'
	    						+'<font color="#1D1D1D">'+nickname
	    						+'</font><div style="color: #C4C4C4;">'
	    						+'<font size="2">'+now
	    						+'</font>'
	    						+'</div>'
	    						+'<div style="padding-top:5px">'+imgs
	    						+'</div>'
	    						+'<div style="padding-top:5px">'+content
	    						+'</div>'
	    						+'</h5>'
	    						+'</div>'
	    						+'</div>'
	    						+'</div>'
	    						+'</div>');
	    				//清空星、评价内容、计数
		    			score = "";
		    			$("#showb").css("width",0);
		    			$("#iNum").text(0);
		    			$("#content").val("");
	        		} else {
	        			$.toast("评论失败",'cancel');
	        		}
	        		
				});
			});
			
			/*****************时间格式化*****************/
			Date.prototype.format = function(format){ 
				var o = {
					"M+" : this.getMonth()+1, //month
					"d+" : this.getDate(), //day 
					"h+" : this.getHours(), //hour 
					"m+" : this.getMinutes(), //minute 
					"s+" : this.getSeconds(), //second 
					"q+" : Math.floor((this.getMonth()+3)/3), //quarter 
					"S" : this.getMilliseconds() //millisecond
				}
				
				if(/(y+)/.test(format)) {
					format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
				}
				
				for(var k in o) {
					if(new RegExp("("+ k +")").test(format)) {
						format = format.replace(RegExp.$1, RegExp.$1.length==1 ? o[k] : ("00"+ o[k]).substr((""+ o[k]).length)); 
					}
				}
				return format; 
			} 
		
		</script>
	</body>
</html>