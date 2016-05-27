<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="desserthouse.model.User"%>
<%@ page import="desserthouse.model.Order"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="ChargeList"
	type="desserthouse.action.ChargeListBean"
	scope="session"></jsp:useBean>
<jsp:useBean id="chargeitem" class="desserthouse.model.Charge"
	scope="page"></jsp:useBean>

<jsp:useBean id="OrderList"
	type="desserthouse.action.OrderListBean"
	scope="session"></jsp:useBean>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>会员信息</title>
    
   <!-- Scripts -->
	<script src="../js/jquery.min.js"></script>
    
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

        a {
            text-decoration: none;   
        }
        
        li{
            list-style-type: none;
            margin-top: 10px;
            margin-bottom: 10px;
        }
        #totalpricetag{
            font-family: 黑体;
            font-size: 25px;
            font-weight: 600;
            color: #C43F50;
            line-height: 30px;
        }
        
    </style>
    
    <script type="text/javascript">
        function showOrder(){
            document.getElementById("member").style.visibility = "hidden";
            document.getElementById("member_order").style.visibility = "";
        }
        function showCharge(){
            document.getElementById("member").style.visibility = "hidden";
            document.getElementById("member_charge").style.visibility = "";
        }
        function back(){
            document.getElementById("member").style.visibility = "";
            document.getElementById("member_charge").style.visibility = "hidden";
            document.getElementById("member_order").style.visibility = "hidden";
        }
    </script>
    
    <script src="../js/jquery.min.js"></script>
    <script type="text/javascript">
	    $(function(){
	        $('#user_id_input').bind('keypress',function(event){
	            if(event.keyCode == "13")    
	            {
	            	userSearch();
	            }
	        });
	    });
    	function userSearch(){
    		$.ajax({
                //提交数据的类型 POST GET
                type:"POST",
                //提交的网址
                url:"/DessertHouse/UserServlet",
                //提交的数据
                data:{type:"search",
                	  id:document.getElementById("user_id_input").value
                },
                //返回数据的格式
                datatype: "text",//"xml", "html", "script", "json", "jsonp", "text".
                success:function(data){
                    if(data=="nouser"){
                    	alert("该会员不存在");
                    }
                    else{
                    	location.reload();
                    }
                }
            });
    	}
    </script>
</head>


<body>
<%User user = (User) session.getAttribute("saleuser");
%>
    <div id="member" class="right-container" style="left:10%;width:80%;padding-left:40px;visibility:">
        <h1>会员</h1>
        <div id="staff_info" style="position:relative;width:90%; margin-top:20px;">
            <div class="right_nr_search" style="left:0px;top:0px;">
           
               <input type="text" id="user_id_input" name="productKey" value="会员编号" onblur="if(this.value==''){this.value='会员编号';$('#user_id_input').css('color','#dbdada');}" onfocus="if(this.value=='会员编号'){this.value=''; $('#user_id_input').css('color','');}" style="color: rgb(219, 218, 218);">
               <a onclick="userSearch()" name="search_tj" class="search_tj"></a>
            
            </div>
            <%if(user!=null){ %>
            <ul style="padding-top:30px;">
                <li>
                    <span class="sys-ch-bold">会员编号：</span>
                    <span id="user_id" class="sys-ch" style="color:#1B0D00"><%=user.getId() %></span>
                </li>
                <li>
                    <span class="sys-ch-bold">账户状态：</span>
                    <span id="user_state" class="sys-ch" style="color:#1B0D00">
                   		<%if(user.getState()==User.UserState.inactive){ %>未激活
                           	<%}else if(user.getState()==User.UserState.active){ %>正常
                           	<%}else if(user.getState()==User.UserState.paused){ %>暂停
                           	<%}else if(user.getState()==User.UserState.stopped){ %>停用
                           	<%} %>
                    </span>
                </li>
                <li>
                    <span class="sys-ch-bold">账户余额：</span>
                    <span id="user_balance" class="sys-ch" style="color:#1B0D00">￥<%=user.getBalance() %></span>
                </li>
                <li>
                    <span class="sys-ch-bold">会员等级：</span>
                    <span id="user_level" class="sys-ch" style="color:#1B0D00">
                    	<%if(user.getLevel()==1){ %>普通会员
                           	<%}else if(user.getLevel()==2){ %>高级会员
                           	<%}else if(user.getLevel()==3){ %>白金会员
                           	<%}else if(user.getLevel()==4){ %>钻石会员
                           	<%} %>
                    </span>
                </li>
                <li>
                    <span class="sys-ch-bold">会员积分：</span>
                    <span id="user_point" class="sys-ch" style="color:#1B0D00"><%=user.getPoint() %></span>
                </li>
                <li>
                    <span class="sys-ch-bold">会员有效期：</span>
                    <span id="user_valid" class="sys-ch" style="color:#1B0D00"><%=user.getDate() %></span>
                </li>
                <li>
                    <a href="#" onclick="showOrder()" class="sys-ch" style="color:#1B0D00">消费记录</a>
                    <a href="#" onclick="showCharge()" class="sys-ch" style="margin-left:30px;color:#1B0D00">缴费记录</a>
                </li>
            </ul>
            <%} %>
        </div>
    </div>
    
    <div id="member_order" class="right-container" style="left:10%;width:80%;height:800px;visibility:hidden">
        <a class="backBtn" href="#" onclick="back()">
            <div style="width:150px;height:50px;">
                <div class="left-arrow"></div>
                <span class="sys-ch" style="font-size:20px;padding-left:15px;top:5px;">返回</span>
            </div>
        </a>
        
        <table id="cart_table" cellspacing="0" style="margin-top:40px;color:#333">
	        <thead id="table_head">
	            <tr>
	                <th style="height:30px;">
	                    <p>订单编号</p>
	                </th>
	                <th style="height:30px;">
	                    <p>日期</p>
	                </th>
	                <th style="height:30px;">
	                    <p>订单详情</p>
	                </th>
	                <th style="height:30px;">
	                    <p>金额</p>
	                </th>
	                <th style="height:30px;">
	                    <p>订单状态</p>
	                </th>
	            </tr>
	        </thead>
	        <tbody id="userGroups" class="tbody">
	        <%
	        if(OrderList.getOrderList()!=null){
	        for(int i=0;i<OrderList.getOrderList().size();i++){
	        	Order order = OrderList.getOrder(i);%>
	            <tr>
	                <td class="table_cell admin" style="width:20%;">
	                    <p class="sys-ch"><%=order.getId() %></p>
	                </td>
	                <td class="table_cell admin" style="width:15%;">
	                    <p class="sys-ch"><%=order.getDate() %></p>
	                </td>
	                <td class="table_cell info">
	                <%
	                    double total = 0;
	                    for(int j=0;j<order.getCommodity().size();j++){
	                    	total = total + order.getCommodity().get(j).getNum()*order.getCommodity().get(j).getPrice();%>
	                    
	                      <p class="sys-ch" style="text-align:center;line-height:30px;"><%=order.getCommodity().get(j).getName() %> x<%=order.getCommodity().get(j).getNum() %></p>
	                 		   <%} %> 
	                </td>
	                <td class="table_cell price">
	                   <p class="sys-ch-bold" style="color:#A4313E"><%=total %></p>
	                </td>
	                <td class="table_cell action" style="width:15%;">
	                    <p class="sys-ch">
	                    <%if(order.getState().equals("finish")){ %>
	                    	完成
	                    <%}else{ %>
	                   		 未完成
	                   	<%} %>
	                    </p>
	                </td>
	            </tr>
	        <%} }%>
	        </tbody>
	    </table>
            
    </div>
    
    <div id="member_charge" class="right-container" style="left:10%;width:80%;visibility:hidden">
        <a class="backBtn" href="#" onclick="back()">
            <div style="width:150px;height:50px;">
                <div class="left-arrow"></div>
                <span class="sys-ch" style="font-size:20px;padding-left:15px;top:5px;">返回</span>
            </div>
        </a>
        
        <ul style="margin-top:20px;margin-left:40px;">
            <li>
                <span class="sys-ch-bold" style="margin-left:30px;">充值时间</span>
                <span class="sys-ch-bold" style="margin-left:150px;">充值金额</span>
                <span class="sys-ch-bold" style="margin-left:150px;">余额</span>
            </li>

            <%
            if(ChargeList.getChargeList()!=null){
                int chargeNum = ChargeList.getChargeList().size();
                int chargePages = chargeNum/10 +1;
                int chargeIndex = 10;
                if(chargePages==1)
                	chargeIndex = chargeNum;
                for(int i=0;i<chargeIndex;i++){
                	pageContext.setAttribute("chargeitem", ChargeList.getCharge(i)); %>
                <li style="color:#1B0D00">
                    <span class="sys-ch" style="margin-left:20px;"><jsp:getProperty name="chargeitem" property="date" /></span>
                    <span class="sys-ch" style="margin-left:130px;">￥<jsp:getProperty name="chargeitem" property="sum" /></span>
                    <span class="sys-ch" style="margin-left:150px;">￥<jsp:getProperty name="chargeitem" property="balance" /></span>
                </li>
                <%} %>
            </ul>
            <%if(chargePages>1){ %>
       <div class="page fr">
 			<%for(int j=1;j<=chargePages;j++){ %>
           <a id=<%="page"+Integer.toString(j) %> class="a2" href="javascript:void();" onclick=""><%=j %></a>
           <%} %>
           <a id="nextpage" class="turing" href="javascript:void();" onclick="setList(2)">下一页</a>
       </div>
       <%	} 
       }%>
        
    </div>
</body>