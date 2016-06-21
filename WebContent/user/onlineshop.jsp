<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="desserthouse.model.User"%>
<%@ page import="desserthouse.model.Cart"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="CommodityList"
	type="desserthouse.action.CommodityListBean"
	scope="session"></jsp:useBean>
<jsp:useBean id="commodityitem" class="desserthouse.model.Commodity"
	scope="page"></jsp:useBean>
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
            font-family: 微软雅黑;
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
    
    <script src="../js/jquery.min.js"></script>
    <script type="text/javascript">
		function findStock(ctype){
			$.ajax({
                //提交数据的类型 POST GET
                type:"POST",
                //提交的网址
                url:"/DessertHouse/OrderServlet",
                //提交的数据
                data:{type:"findtype",
                	  ctype: ctype
                     },
                //返回数据的格式
                datatype: "text",//"xml", "html", "script", "json", "jsonp", "text".
                success:function(data){
                    if(data=="true")
                    	location.reload();
                }
            });	
		}
		function productAdd(cid){
			$.ajax({
                //提交数据的类型 POST GET
                type:"POST",
                //提交的网址
                url:"/DessertHouse/OrderServlet",
                //提交的数据
                data:{type:"addCommodity",
                	  commodity_id:cid
                },
                //返回数据的格式
                datatype: "text",//"xml", "html", "script", "json", "jsonp", "text".
                success:function(data){
                    if(data=="solded"){
                    	alert("该商品已售罄");
                    }
                    else if(data=="nocomm")
                    	alert("商品编号错误");
                    else{
                    	location.reload();
                    }
                }
            });
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
</head>

<%
	User user = (User)session.getAttribute("user");
	Cart cart =(Cart) session.getAttribute("ordercart");
	if(cart==null){
		cart = new Cart();
		cart.init();
	}
%>
<body>
    <div class="common-container">
        <div class="top-menu">
            <div class="top-btn" style="margin-left:180px;"><a href="index.jsp" class="menu">首页</a></div>
            <div class="top-btn"><a href="shopchoose.jsp" class="menu" style="color: #C43F50;">线上订购</a></div>
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
        
        <div style="background-color: #FBEFE1;width:100%;overflow:auto">
            <div class="nevigation-left">
                <ul>
                    <li>
                        <a href="#" onclick="findStock('bread')" class="sys-ch">面包</a>
                    </li>
                    <li>
                        <a href="#" onclick="findStock('cake')" class="sys-ch">蛋糕</a>
                    </li>
                    <li>
                        <a href="#" onclick="findStock('drink')" class="sys-ch">饮料</a>
                    </li>
                    <li>
                        <a href="#" onclick="findStock('dessert')" class="sys-ch">休闲点心</a>
                    </li>
                </ul>
            </div>
            
            <div class="main-container" style="height:1000px;">
                <div id="good-list" class="sub-container">
                    <div class="right_nr">
                        <div id="subtitle" class="sys-ch">美味放送</div>
                        <span></span>
                    </div>
                    <div id="chart">
                    <a href="cart.jsp" target="_blank">
                        <img src="../images/shopping.png" width="25" height="25">
                        <span class="sys-bold" style="color: #C43F50;position:relative;top:-15px;left:-5px;"><%=cart.getList().size() %></span>
                    </a></div>
                    
                    <div class="right_nr_search">
                       <form>
                           <input type="text" id="productKey" name="productKey" value="美味搜索" onblur="if(this.value==''){this.value='美味搜索';$('#productKey').css('color','#dbdada');}" onfocus="if(this.value=='美味搜索'){this.value=''; $('#productKey').css('color','');}" style="color: rgb(219, 218, 218);">
                           <input name="search_tj" type="submit" value=" " class="search_tj">
                        </form>
                    </div>
                    
                    <ul id="list-detail">
                  <%for(int i=0;i<CommodityList.getCommodityList().size();i++){
                	  pageContext.setAttribute("commodityitem", CommodityList.getcommodity(i));	
                    %>
                        <li>
                            <img src="../images/<%=CommodityList.getcommodity(i).getId() %>.jpg" border="0" width="204" height="175">
                            <div class="pic_name"><jsp:getProperty name="commodityitem" property="name" /></div>
                            <a href="#" onclick="productAdd('<%=CommodityList.getcommodity(i).getId() %>')" class="add">加入购物车</a>
                        </li>
                    <%} %>
                    </ul>
                </div>
            </div>
            
        </div>
    </div>
    </body>
    
</html>