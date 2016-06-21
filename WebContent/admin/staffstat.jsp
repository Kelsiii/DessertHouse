<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="desserthouse.model.StaffSale"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>经营管理</title>
    
    <!-- Stylesheets -->
	<link rel="stylesheet" href="../css/area.css">
	<link rel="stylesheet" href="../css/button.css">
	<link rel="stylesheet" href="../css/font.css">
	<link rel="stylesheet" href="../css/input.css">
	<link rel="stylesheet" href="../css/table.css">
	
	<style>
        * {
            margin: 0;
            padding: 0;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
        }

        body {
            background: #FBEFE1;	
            font-family: 'Roboto', Arial, Tahoma, Sans-serif, Verdana, Helvetica;
            font-size: 62.5%;
            fon-color: #333;
        }
        
        h1 {
            color: #2C1201;
            font-size: 23px;
            font-family: 微软雅黑;
        }
        
        h2{
            font-family: 微软雅黑;
            font-size: 20px;
            color: #C43F50;
        }

        a {
            text-decoration: none;   
        }
        
        li{
            list-style-type: none;
            margin-top: 10px;
            margin-bottom: 10px;
            height: 60px;
        }
    </style>
    
    <script src="../js/jquery.min.js"></script>
    
    <script type="text/javascript">
	    function setStat(){
	    	var timeselect = document.getElementById("time").selectedIndex;

	    	$.ajax({
	            //提交数据的类型 POST GET
	            type:"POST",
	            //提交的网址
	            url:"/DessertHouse/StatServlet",
	            //提交的数据
	            data:{type:"staff-stat",
	            	timetype: document.getElementById("time")[timeselect].value,
	            },
	            //返回数据的格式
	            datatype: "text",//"xml", "html", "script", "json", "jsonp", "text".
	            success:function(data){
	                window.location.href="staffstat.jsp"; 
	            }
	        });
	    }
    </script>
    
</head>

<body>
    <div id="indexmenu" style="padding-top:50px;height:1500px">
          <a href="manager.jsp" class="btn btn-2">销售计划</a>
           <a href="salestat.jsp" class="btn btn-2">销售统计</a>
           <a href="userstat.jsp" class="btn btn-2">会员统计</a>
           <a href="channel.jsp" class="btn btn-2">渠道统计</a>
           <a href="staffstat.jsp" class="btn btn-2">业绩统计</a>
    </div>
    
    
    <div class="right-container" id="sale" style="height:1500px;">
        <h1>业绩统计</h1>
        <%String selecttime = (String) session.getAttribute("selecttime");    %>
        <div style="margin-top:20px;">
            <div style="width:90%;">
            	<span class="sys-ch" style=""> 统计范围：</span>
		        <select id="time" onchange="setStat()" style="width:150px;height:30px;">
		        	<option value ="month" <%if(selecttime.equals("month")){ %> selected <%} %>>本月</option>
		        	<option value ="season" <%if(selecttime.equals("season")){ %> selected <%} %>>本季度</option>
		        	<option value ="year" <%if(selecttime.equals("year")){ %> selected <%} %>>本年度</option>
		        </select>
		        
                <table id="cart_table" cellspacing="0" >
                    <thead id="table_head">
                        <tr>
                            <th style="height:44px;">
                                <p>工号</p>
                            </th>
                            <th style="height:44px;" >
                                <p>姓名</p>
                            </th>
                            <th style="height:44px;">
                                <p>销售业绩</p>
                            </th>
                        </tr>
                    </thead>
                    <tbody id="userGroups" class="tbody">
                    <%
                    List<StaffSale> list = (List)session.getAttribute("StaffStat");
                    for(int i=0;i<list.size();i++){
                    	StaffSale pc = list.get(i);
                    %>
                        <tr>
                            <td class="table_cell">
                                <p  class="sys-ch" style="line-height:40px;text-align:center"><%=pc.getId() %></p>
                            </td>
                            <td class="table_cell">
                               <p style="text-align:center"><%=pc.getName() %></p>
                            </td>
                            <td class="table_cell">
                                <p style="text-align:center"><%=pc.getNum() %></p>
                            </td>
                        </tr>
                    <%} %>
                    </tbody>
                </table>
            </div>
            
        </div>
    </div>
    	
    
</body>


</html>