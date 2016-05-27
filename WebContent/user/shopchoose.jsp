<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="desserthouse.model.User"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="StoreList"
	type="desserthouse.action.StoreListBean"
	scope="session"></jsp:useBean>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>线上订购</title>
    
    <!-- Scripts -->
	<script src="../js/jquery.min.js"></script>
    
    <!-- Stylesheets -->
	<link rel="stylesheet" href="../css/area.css">
	<link rel="stylesheet" href="../css/button.css">
	<link rel="stylesheet" href="../css/font.css">
	<link rel="stylesheet" href="../css/input.css">
    <script language="javascript" type="text/javascript" src="../css/My97DatePicker/WdatePicker.js"></script>
    
    <script src="../js/jquery.min.js"></script>
    <script type="text/javascript">
		function findStock(){
			var storeselect = document.getElementById("store").selectedIndex;
			if(document.getElementById("planDate").value=="")
        		alert("请选择预定日期")
        	else{
        		$.ajax({
                    //提交数据的类型 POST GET
                    type:"POST",
                    //提交的网址
                    url:"/DessertHouse/OrderServlet",
                    //提交的数据
                    data:{type:"find",
                    	  store: document.getElementById("store")[storeselect].value,
                    	  date: document.getElementById("planDate").value,
                    	  ctype: "bread"
                         },
                    //返回数据的格式
                    datatype: "text",//"xml", "html", "script", "json", "jsonp", "text".
                    success:function(data){
                        if(data=="noplan"){
                        	alert("该店当日销售计划尚未制定，无法进行预定！");
                        }
                        else{
                        	window.location.href="onlineshop.jsp"; 
                        }
                    }
                });
        	}
		}
		function logout(){
			$.ajax({
                //提交数据的类型 POST GET
                type:"POST",
                //提交的网址
                url:"/DessertHouse/UserServlet",
                //提交的数据
                data:{type:"logout"
                     },
                //返回数据的格式
                datatype: "text",//"xml", "html", "script", "json", "jsonp", "text".
                success:function(data){
                	window.location.href="login.jsp"; 
                }
            });	
		}
	</script>
    
    <style>
        body{
            background-color: #2C1201;
            color: #824220;
        }
        
        li{
            list-style-type: none;
        }
        
        #list-detail{
            margin: 0;
            padding: 0;
        }
        #list-detail li{
            float: left;
            POSITION: relative;
            display: none;
            padding-right: 11px;
            padding-top: 10px;
            
            display: block;
            width: 225px;
            height: 254px;
            text-align: center;
            background: url(../images/proBgl.jpg) no-repeat 0 0;
        }
        .pic_name {
            height: 36px;
            line-height: 36px;
            font-family: 微软雅黑;
            font-size: 16px;
            font-weight: 500;
        }
        .add {
            display: block;
            padding-top: 8px;
            font-family: 黑体;
            font-size: 18px;
            font-weight: 600;
            color: #C43F50;
        }
        #chart{
            width: 50px;
            height: 25px;
            line-height: 25px;
            position: absolute;
            top: 30px;
            right: 200px;
        }
    </style>
    
</head>

<%User user = (User)session.getAttribute("user");%>
<body>
    <div class="common-container">
        <div class="top-menu">
            <div class="top-btn" style="margin-left:180px;"><a href="index.html" class="menu">首页</a></div>
            <div class="top-btn"><a href="#" class="menu" style="color: #C43F50;">线上订购</a></div>
            <div class="top-btn"><a href="userinfo.jsp" class="menu">个人中心</a></div>
            <div class="top-btn"><a href="signup.jsp" target="_blank" class="menu">会员注册</a></div>
            <div class="top-btn" style="border-right:solid 0px;"><a href="signup.jsp" class="menu">关于我们</a></div>
            
            
        </div>
        
        <div class="nevigation-long">
            <div class="nevigation-page"><span class="title-ch-bold">线上订购</span></div>
            <div class="usercard">
                <a href="userinfo.jsp" class="sys-bold" style="color:white;border-right:solid 1px;padding-right:15px;"><%=user.getId() %></a> 
                <a href="#" onclick="logout()" class="sys-bold" style="color:white;padding-left:10px;">Log out</a>
                
            </div>
        </div>
        
        <div style="background-color: #FBEFE1;width:100%;height:500px;">
            <div style="width:40%;margin:0 auto;padding-top:100px;">
                <ul>
                    <li>
                        <span class="title-ch-bold">门店选择：</span>
                        <select id="store" style="width:250px;height:30px;">
	                        <%for(int i=0;i<StoreList.getStoreList().size();i++){%>
				              <option value ="<%= StoreList.getStore(i).getId() %>"><%= StoreList.getStore(i).getName()%></option>
	        				<%} %>
                        </select>
                    </li>
                    <li>
                        <span class="title-ch-bold" style="margin-top:30px;"> 预定日期：</span>
                        <input id="planDate" class="inputArea" style="margin-top:30px;width:250px;height:30px" type="text" name="date" onClick="WdatePicker()" onChange="setTaskTime()" placeholder="点击选择日期"/>
                    </li>
                </ul>
                <a id="" style="margin-right:150px;margin-top:40px;" class="calBtn" href="#" onclick="findStock()">确  认</a>
                
            </div>
        </div>
        
    </div>
    
</body>


</html>