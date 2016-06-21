<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="desserthouse.model.Plan"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="PlanList"
	type="desserthouse.action.PlanListBean"
	scope="session"></jsp:useBean>
<jsp:useBean id="planitem" class="desserthouse.model.Plan"
	scope="page"></jsp:useBean>
<jsp:useBean id="StoreList"
	type="desserthouse.action.StoreListBean"
	scope="session"></jsp:useBean>
<jsp:useBean id="PlanStat"
type="desserthouse.action.PlanStatBean"
scope="session"></jsp:useBean>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>添加销售计划</title>
    
    <!-- Stylesheets -->
	<link rel="stylesheet" href="../css/area.css">
	<link rel="stylesheet" href="../css/button.css">
	<link rel="stylesheet" href="../css/font.css">
	<link rel="stylesheet" href="../css/input.css">
	<link rel="stylesheet" href="../css/table.css">
    
    <script language="javascript" type="text/javascript" src="../css/My97DatePicker/WdatePicker.js"></script>
    
    <script src="../js/jquery.min.js"></script>
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
    <script type="text/javascript">
        function showPlanList(){
            document.getElementById("plan").style.visibility = "";
            document.getElementById("plan_edit").style.visibility = "hidden";
            document.getElementById("indexmenu").style.height = '580px';
        }
        function showDetail(planid){
        	$.ajax({
                //提交数据的类型 POST GET
                type:"POST",
                //提交的网址
                url:"/DessertHouse/PlanServlet",
                //提交的数据
                data:{type:"setDetail",
                	  id:planid
                     },
                //返回数据的格式
                datatype: "text",//"xml", "html", "script", "json", "jsonp", "text".
                success:function(data){
                    if(data){
                        window.open("planedit.jsp");
                    }
                }
            });
        }
        function showAdd(){
            document.getElementById("plan_edit").style.visibility = "";
            document.getElementById("plan").style.visibility = "hidden";
            document.getElementById("indexmenu").style.height = '1600px';
            document.getElementById("store")[0].select = true;
        }
        function addPlan(index){
        	if(document.getElementById("planDate").value=="点击选择日期")
        		alert("请选择计划日期")
        	else{
        		var storeselect = document.getElementById("store").selectedIndex;
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
                    data:{type:"add",
                    	  store: document.getElementById("store")[storeselect].value,
                    	  date: document.getElementById("planDate").value,
                    	  price: prices,
                    	  num: nums
                         },
                    //返回数据的格式
                    datatype: "text",//"xml", "html", "script", "json", "jsonp", "text".
                    success:function(data){
                        if(data=="true"){
                        	window.location.href="planner.jsp"; 
                        }
                        else{
                        	alert("该店计划已存在，添加失败");
                        }
                    }
                });
        	}
        	
        }
    </script>
    
    <script type="text/javascript">
    	function getStatPlan(){
    		if(document.getElementById("planDate").value!="点击选择日期"){
    			var storeselect = document.getElementById("store").selectedIndex;
    			$.ajax({
                    //提交数据的类型 POST GET
                    type:"POST",
                    //提交的网址
                    url:"/DessertHouse/PlanServlet",
                    //提交的数据
                    data:{type:"stat",
                    	  store: document.getElementById("store")[storeselect].value,
                    	  date: document.getElementById("planDate").value
                         },
                    //返回数据的格式
                    datatype: "text",//"xml", "html", "script", "json", "jsonp", "text".
                    success:function(data){
                        if(data=="true"){
                        	window.location.href="newplan.jsp";
                        }
                    }
                });
        	}
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
    </style>
</head>

<body>
    
    <div id="indexmenu" style="padding-top:50px;">
           <a href="#" class="btn btn-2">销售计划</a> 
           <a href="#" class="btn btn-2">新建计划</a>
    </div>
    
    <div class="right-container" id="plan_edit" style="height:1600px">
        <%Plan plan = PlanStat.getPlan();
        %>
        <span class="sys-ch" style=""> 计划日期：</span>
        <input id="planDate" class="inputArea" style="width:150px;height:30px" type="text" name="date" onClick="WdatePicker()" placeholder="点击选择日期"
         value="<%=plan.getDate() %>" onchange="getStatPlan()"/>
        <span class="sys-ch" style="margin-left:30px;">店铺：</span>
        <select id="store" onchange="getStatPlan()" style="width:150px;height:30px;">
        <%for(int i=0;i<StoreList.getStoreList().size();i++){
        	%>
              <option value ="<%= StoreList.getStore(i).getId() %>" 
              <% 
              	if (StoreList.getStore(i).getId().equals(plan.getStore())){
              		%> selected
              	<%}%>
              ><%= StoreList.getStore(i).getName()%></option>
        <%} %>
        </select>
        <table id="cart_table" cellspacing="0" style="width:800px;">
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
        		String nid = "num"+i;%>
                <tr>
                    <td class="table_cell" style="width:450px;">
                        <p class="sys-ch" style="line-height:40px;"><%=plan.getCommodity().get(i).getName() %></p>
                    </td>
                    <td class="table_cell">
                       <input id="<%=pid %>" class="sys-ch" value="<%=plan.getCommodity().get(i).getPrice() %>"></input>
                    </td>
                    <td class="table_cell">
                        <div class="item-amount">
                            <a href="#" onclick="min(this)">-</a>
                            <input id="<%=nid %>" class="numvalue" type="text" value="<%=plan.getCommodity().get(i).getNum() %>">
                            <a href="#" onclick="add(this)">+</a>
                        </div>
                    </td>
                </tr>
                <%} %>
            </tbody>
        </table>
        
        <a class="calBtn" style="margin-top:20px;float:left;line-height:40px;height:40px;width:150px;font-size:20px;" href="#" onclick="addPlan('<%=plan.getCommodity().size()%>')">提交</a>
    </div>
</body>


</html>