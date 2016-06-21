<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="desserthouse.model.User"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<title>首页</title>
	<!-- Fuentes de Google -->
	<link href='http://fonts.useso.com/css?family=Roboto:400,300,700' rel='stylesheet' type='text/css'>

	<!-- Stylesheets -->
	<link rel="stylesheet" href="../css/slide.css">
	<link rel="stylesheet" href="../css/area.css">
	<link rel="stylesheet" href="../css/button.css">

	<!--[if lt IE 9]>
		<script src="js/html5shiv.min.js"></script>
	<![endif]-->
	
	<!-- Scripts -->
	<script src="../js/jquery.min.js"></script>
    
    <!-- Stylesheets -->
	<link rel="stylesheet" href="../css/area.css">
	<link rel="stylesheet" href="../css/button.css">
	<link rel="stylesheet" href="../css/font.css">
	<link rel="stylesheet" href="../css/input.css">
	
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
<body>
	<div class="common-container">
        <div class="top-menu">
            <div class="top-btn" style="margin-left:180px;"><a href="index.html" class="menu" style="color: #C43F50;">首页</a></div>
            <div class="top-btn"><a href="shopchoose.jsp" class="menu" >线上订购</a></div>
            <div class="top-btn"><a href="userinfo.jsp" class="menu">个人中心</a></div>
            <div class="top-btn"><a href="signup.jsp" target="_blank" class="menu">会员注册</a></div>
            <div class="top-btn" style="border-right:solid 0px;"><a href="signup.jsp" class="menu">关于我们</a></div>
        </div>
        
        <div class="nevigation-long">
            <div class="usercard">
            <%
            User user = (User)session.getAttribute("user");
			if(user!=null){
			%>
                <a href="userinfo.jsp" class="sys-bold" style="color:white;border-right:solid 1px;padding-right:15px;"><%=user.getId() %></a> 
                <a href="#" onclick="logout()" class="sys-bold" style="color:white;padding-left:10px;">Log out</a>
            <%}
			else{%> 
            	<a href="login.jsp" class="sys-bold" style="color:white;border-right:solid 1px;padding-right:15px;">登录</a> 
                <a href="signup.jsp" class="sys-bold" style="color:white;padding-left:10px;">注册</a>
            <%} %>
            </div>
        </div>
        
        <div style="background-color: #FBEFE1;width:100%;height:500px;overflow:hidden">
            <!-- Slider Container -->
        <section class="slider-container">
            <ul id="slider" class="slider-wrapper">
                <li class="slide-current">
                    <img src="../images/1.jpg" alt="Slider Imagen 1" style="width:100%;height:100%">
                    <div class="caption">
                        <h3 class="caption-title">新品上架</h3>
                        <p>新品巧克力杯每日限量供应</p>
                    </div>
                </li>

                <li>
                    <img src="../images/2.jpg" alt="Slider Imagen 1" style="width:100%;height:100%">
                    <div class="caption">
                        <h3 class="caption-title">下午茶时光</h3>
                        <p>周三会员日，购下午茶指定商品享9折优惠</p>
                    </div>
                </li>

                <li>
                    <img src="../images/3.jpg" alt="Slider Imagen 1" style="width:100%;height:100%">
                    <div class="caption">
                        <h3 class="caption-title">新品上架</h3>
                        <p>酸甜碰撞，草莓蛋糕欢迎试吃</p>
                    </div>
                </li>

                <li>
                    <img src="../images/4.jpg" alt="Slider Imagen 1" style="width:100%;height:100%">
                    <div class="caption">
                        <h3 class="caption-title">情人节特辑</h3>
                        <p>情人节当天推出限量礼盒，仅限当日购买</p>
                    </div>
                </li>
            </ul>



            <!-- Controles -->
            <ul id="slider-controls" class="slider-controls"></ul>


        </section>
        </div>
        	<!-- Scripts -->
	<script src="../js/jquery.min.js"></script>
	<script src="../js/main.js"></script>
    </div>

</body>
</html>