<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="desserthouse.model.Plan"%>
<%@ page import="desserthouse.model.Staff"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>销售计划</title>
    
    <!-- Stylesheets -->
	<link rel="stylesheet" href="../css/area.css">
	<link rel="stylesheet" href="../css/button.css">
	<link rel="stylesheet" href="../css/font.css">
	<link rel="stylesheet" href="../css/input.css">
	<link rel="stylesheet" href="../css/table.css">
    
    <script language="javascript" type="text/javascript" src="../css/My97DatePicker/WdatePicker.js"></script>
    
    <script type="text/javascript">
        function add(Obj){
            var p = Obj.previousSibling.previousSibling;
            var num = parseInt(p.value);
            num = num+1;
            p.value = num;
        }
        
        function min(Obj){
            var p = Obj.nextSibling.nextSibling;
            var num = parseInt(p.value);
            if(num!=0)
                num = num-1;
            p.value = num;
        }
        
    </script>
    
    <script src="../js/jquery.min.js"></script>
    <script type="text/javascript">
        function edit(index){
        	var prices = "";
    		for(var i=0;i<index;i++){
    			var p = document.getElementById("price"+i).value;
    			prices = prices+p+",";
    		}
    		var nums = "";
    		for(var i=0;i<index;i++){
    			var n = document.getElementById("num"+i).value;
    			nums = nums+n+",";
    		}
        	$.ajax({
                //提交数据的类型 POST GET
                type:"POST",
                //提交的网址
                url:"/DessertHouse/PlanServlet",
                //提交的数据
                data:{type:"update",
                	  price: prices,
                	  num: nums
                     },
                //返回数据的格式
                datatype: "text",//"xml", "html", "script", "json", "jsonp", "text".
                success:function(data){
                    if(data){
                    	window.location.href="planner.jsp"; 
                    }
                }
            });
        }
        
        function doOption(op){
        	$.ajax({
                //提交数据的类型 POST GET
                type:"POST",
                //提交的网址
                url:"/DessertHouse/PlanServlet",
                //提交的数据
                data:{type:"check",
                	  state: op
                     },
                //返回数据的格式
                datatype: "text",//"xml", "html", "script", "json", "jsonp", "text".
                success:function(data){
                    if(data){
                    	alert("操作成功");
                    	window.location.href="manager.jsp"; 
                    }
                }
            });
        }
    </script>
    
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

        a {
            text-decoration: none;   
        }
        
        li{
            list-style-type: none;
            margin-top: 10px;
            margin-bottom: 10px;
        }
        #plan_edit{
            margin-top: 30px;
            width: 90%;
            margin-left: 5%;
            
            background-color:white;
            padding:20px;
        }
    </style>
</head>

<body>
<%Plan plan = (Plan) session.getAttribute("editplan");
%>
    <div class="" id="plan_edit" style="visibility:">
    
        <span class="sys-ch" style=""> 计划编号：</span>
        <span class="sys-ch" style="width:150px;height:30px"><%= plan.getId() %></span>
        <span class="sys-ch" style="margin-left:30px;"> 计划日期：</span>
        <span class="sys-ch" style="width:150px;height:30px"><%= plan.getDate() %></span>
        <span class="sys-ch" style="margin-left:30px;">店铺：</span>
        <span class="sys-ch" style="width:150px;height:30px"><%= plan.getStore() %></span>
        
        <span class="sys-ch" style="margin-left:30px;">状态：</span>
        <%if(plan.getState().equals("unchecked")){ %>
        	<span class="sys-ch" >待审核</span>
        <%}else if(plan.getState().equals("approved")){ %>
            <span class="sys-ch" >通过</span>
        <%}else{ %>
            <span class="sys-ch" >未通过</span>
		<%} %>
        <table id="cart_table" cellspacing="0" style="width:90%;">
            <thead id="table_head">
                <tr>
                    <th style="height:44px;">
                        <p>商品详情</p>
                    </th>
                    <th style="height:44px;" >
                        <p>单价</p>
                    </th>
                    <th style="height:44px;">
                        <p>数量</p>
                    </th>
                </tr>
            </thead>
            <tbody id="userGroups" class="tbody">
            <%for(int i=0;i<plan.getCommodity().size();i++){ 
            	String pid = "price"+i;
        		String nid = "num"+i;
            %>
                <tr>
                    <td class="table_cell" style="width:60%;">
                        <p class="sys-ch" style="line-height:40px;"><%=plan.getCommodity().get(i).getName() %></p>
                    </td>
                    <td class="table_cell" style="width:30%">
                       <input id="<%=pid %>" class="sys-ch" value="<%=plan.getCommodity().get(i).getPrice() %>" style="display:block;margin:0 auto;"></input>
                    </td>
                    <td class="table_cell">
                        <div class="item-amount">
                            <a href="#" onclick="min(this)">-</a>
                            <input  id="<%=nid %>"  class="numvalue" type="text" value="<%=plan.getCommodity().get(i).getNum()%>">
                            <a href="#" onclick="add(this)">+</a>
                        </div>
                    </td>
                </tr>
                <%} %>
            </tbody>
        </table>
        <%Staff staff = (Staff) session.getAttribute("staff");
        if (staff.getId().equals("manager")){%>
        	<a class="ghbutton pink" href="#" onclick="doOption('approved')" style= "margin-top:40px;margin-left:300px;width:100px;height:30px;font-size:14px;">通过计划</a>
        	<a class="ghbutton gray" href="#" onclick="doOption('disapproved')" style="margin-top:40px;margin-left:30px;width:100px;height:30px;font-size:14px;">不通过</a>
        
        <%}
        else if (!plan.getState().equals("approved")){ %>
        	<a class="calBtn" style="margin:40px 45%;line-height:40px;height:40px;width:150px;font-size:20px;" href="#" onclick="edit('<%=plan.getCommodity().size()%>')">提交</a>
    	<%} %>
    </div>
</body>


</html>