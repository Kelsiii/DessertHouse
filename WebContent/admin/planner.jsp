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
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>销售计划管理</title>
    
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
        	if(document.getElementById("planDate").value=="")
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
           <a href="#" onclick="showPlanList()" class="btn btn-2">销售计划</a> 
           <a href="#" onclick="showAdd()" class="btn btn-2">新建计划</a>
    </div>
    
    <div class="right-container" id="plan" style="visibility:">
        <h1>销售计划</h1>
        <table id="cart_table" cellspacing="0">
            <thead id="table_head">
                <tr>
                    <th style="height:44px;">
                        <p>编号</p>
                    </th>
                    <th style="height:44px;">
                        <p>店铺</p>
                    </th>
                    <th style="height:44px;">
                        <p>计划日期</p>
                    </th>
                    <th style="height:44px;">
                        <p>创建日期</p>
                    </th>
                    <th style="height:44px;">
                        <p>状态</p>
                    </th>

                </tr>
            </thead>
            <tbody id="userGroups" class="tbody">
            <%
                int planNum = PlanList.getPlanList().size();
                int planPages = planNum/10 +1;
                int planIndex = 10;
                if(planPages==1)
                	planIndex = planNum;
                for(int i=0;i<planIndex;i++){
                	pageContext.setAttribute("planitem", PlanList.getPlan(i));
      
                %>
                <tr>
                    <td class="table_cell admin" style="width:20%;">
                        <a href="#" onclick="showDetail('<%=PlanList.getPlan(i).getId() %>')" class="sys-ch"><jsp:getProperty name="planitem" property="id" /></a>
                    </td>
                    <td class="table_cell admin" style="width:15%;">
                       <p class="sys-ch"><jsp:getProperty name="planitem" property="store" /></p>
                    </td>
                    <td class="table_cell admin" style="width:25%;">
                       <p class="sys-ch"><jsp:getProperty name="planitem" property="date" /></p>
                    </td>
                    <td class="table_cell admin" style="width:25%;">
                       <p class="sys-ch"><jsp:getProperty name="planitem" property="createDate" /></p>
                    </td>
                    <%if(PlanList.getPlan(i).getState().equals("unchecked")){ %>
                    <td class="table_cell action" >
                        <p class="sys-ch">未审核</p>
                    </td>
                    <%}else if(PlanList.getPlan(i).getState().equals("approved")){ %>
                    <td class="table_cell action" >
                        <p class="sys-ch">通过</p>
                    </td>
                    <%}else{ %>
                    <td class="table_cell action" style="color:#C43F50">
                        <p class="sys-ch">未通过</p>
                    </td>
					<%} %>
                </tr>
                <%} %>
            </tbody>
        </table>
        <%if(planPages>1){ %>
            <div class="page fr">
      			<%for(int j=1;j<=planPages;j++){ %>
                <a id=<%="page"+Integer.toString(j) %> class="a2" href="javascript:void();" onclick=""><%=j %></a>
                <%} %>
                <a id="nextpage" class="turing" href="javascript:void();" onclick="setList(2)">下一页</a>
            </div>
            <%} %>
    </div>
    
    <div class="right-container" id="plan_edit" style="height:1600px;visibility:hidden">
        <%Plan plan = new Plan();
          plan.initCommodity();
        %>
        <span class="sys-ch" style=""> 计划日期：</span>
        <input id="planDate" class="inputArea" style="width:150px;height:30px" type="text" name="date" onClick="WdatePicker()" placeholder="点击选择日期"/>
        <span class="sys-ch" style="margin-left:30px;">店铺：</span>
        <select id="store" style="width:150px;height:30px;">
        <%for(int i=0;i<StoreList.getStoreList().size();i++){
        	%>
              <option value ="<%= StoreList.getStore(i).getId() %>"><%= StoreList.getStore(i).getName()%></option>
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
                            <input id="<%=nid %>" class="numvalue" type="text" value="0">
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