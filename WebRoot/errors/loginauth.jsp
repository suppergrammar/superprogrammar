<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<style type=text/css>
body {
	font-size: 9pt;
	color: #842b00;
	line-height: 16pt;
	font-family: "tahoma", "宋体";
	text-decoration: none
}

table {
	font-size: 9pt;
	color: #842b00;
	line-height: 16pt;
	font-family: "tahoma", "宋体";
	text-decoration: none
}

td {
	font-size: 9pt;
	color: #842b00;
	line-height: 16pt;
	font-family: "tahoma", "宋体";
	text-decoration: none
}

body {
	scrollbar-highlight-color: buttonface;
	scrollbar-shadow-color: buttonface;
	scrollbar-3dlight-color: buttonhighlight;
	scrollbar-track-color: #eeeeee;
	background-color: #ffffff
}

a {
	font-size: 9pt;
	color: #842b00;
	line-height: 16pt;
	font-family: "tahoma", "宋体";
	text-decoration: none
}

a:hover {
	font-size: 9pt;
	color: #0188d2;
	line-height: 16pt;
	font-family: "tahoma", "宋体";
	text-decoration: underline
}

h1 {
	font-size: 9pt;
	font-family: "tahoma", "宋体"
}
</style>

	</head>

	<body topmargin=20>
		<table cellspacing=0 width=600 align=center border=0 cepadding="0">
			<tbody>
				<tr colspan="2">
					<td valign=top align=middle>
						<img height=100 src="../errors/images/003.jpg" width=100 border=0>
					<td>
					<td>
						<!--------system return begin------------>
						<h1>
							<font color="#666666">您无法登录系统</font>
						</h1>
						<hr noshade size=0>
						<p>
							<font color="#666666">☉ 可能的原因有：</font>
						</p>
						<ul>
							<li>
								<font color="#666666">账号已过期。	</font>
							</li>
							<li>
								<font color="#666666">密码已过期。	</font>
							</li>
							<li>
								<font color="#666666">账号被锁定。	</font>
							</li>
							<li>
								<font color="#0000ff"><a href="<%= path %>/">返回登录页面
								</a>
								</font>
								<font color="#666666">更换有权限的账号重新登录。 </font>
							</li>
						</ul>
					</td>
				</tr>
			</tbody>
		</table>
	</body>
</html>
