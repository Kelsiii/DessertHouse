<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="desserthouse.model.Cart"%>
<%@ page import="desserthouse.model.PlanCommodity"%>
<%@ page import="desserthouse.model.Store"%>
<%@ page import="desserthouse.model.User"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>结算</title>
    
    <!-- Scripts -->
	<script src="../js/jquery.min.js"></script>
    
    <!-- Stylesheets -->
	<link rel="stylesheet" href="../css/area.css">
	<link rel="stylesheet" href="../css/button.css">
	<link rel="stylesheet" href="../css/font.css">
	<link rel="stylesheet" href="../css/input.css">
	<link rel="stylesheet" href="../css/table.css">
	
	<script src="../js/jquery.min.js"></script>
    <script type="text/javascript">
	    function orderSubmit(){
	    	var item = $("input[name='get_way']:checked"); 
        	var len=item.length; 
        	if(len>0){
        		var type = $("input[name='get_way']:checked").val(); 
        		var obj = document.getElementById("usepoint");
        		var usepoint = "no";
        		if(obj.checked==true)
        			usepoint = "yes";
        		$.ajax({
                    //提交数据的类型 POST GET
                    type:"POST",
                    //提交的网址
                    url:"/DessertHouse/OrderServlet",
                    //提交的数据
                    data:{type:"sub",
                 	   	  delivertype:type,
                    	  addresss:document.getElementById("address_input").value,
                    	  usepoint:usepoint,
                    	  point:document.getElementById("point_input").value
                    },
                    //返回数据的格式
                    datatype: "text",//"xml", "html", "script", "json", "jsonp", "text".
                    success:function(data){
                       	if(data=="nomoney")
                       		alert("该账户余额不足！");
                       	else if(data=="noactive")
                       		alert("账户状态异常，无法购买！");
                       	else{
                       		alert("订单完成！");
                       		window.location.href="onlineshop.jsp";
                       	}
                    }
                });	
        	}
        	else{
        		alert("请选择提货方式！");
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
        }
        
        h1 {
            color: #2C1201;
            font-size: 30px;
            font-family: 微软雅黑;
        }

        a {
            text-decoration: none;
        }
        
        #subBtn{
            display: block;
            margin: 0 auto;
            margin-top: 40px;
            width: 200px;
            height: 50px;
            background-color: #C43F50;
            text-align: center;
            line-height: 50px;
            color: #fff;
            font-family: 黑体;
            font-size: 20px;
            font-weight: 500;
        }
        
    </style>
<%  Cart cart =(Cart) session.getAttribute("ordercart");
	if(cart==null){
		cart = new Cart();
		cart.init();
	}
	List<PlanCommodity> list = cart.getList();
	Store store = (Store) session.getAttribute("store");
	User user = (User) session.getAttribute("user");
%>
<body>
    <div style="position:relative;width:70%; left:15%; margin-top:40px;background-color:white;padding:30px;">
        <h1>结算</h1>
        <table id="cart_table" cellspacing="0" style="margin-top:40px;">
                <thead id="table_head">
                    <tr>
                        <th style="height:30px;">
                            <p>店铺</p>
                        </th>
                        <th style="height:30px;">
                            <p>预定日期</p>
                        </th>
                        <th style="height:30px;">
                            <p>订单详情</p>
                        </th>
                        <th style="height:30px;">
                            <p>总价</p>
                        </th>
                        
                    </tr>
                </thead>
                <tbody id="userGroups" class="tbody">
                    <tr>
                        <td class="table_cell admin" style="width:20%;">
                            <p class="sys-ch"><%=store.getName() %></p>
                        </td>
                        <td class="table_cell admin" style="width:15%;">
                            <p class="sys-ch"><%=session.getAttribute("date") %></p>
                        </td>
                        <td class="table_cell info">
                            <div style="">
                            	<% for(int i=0;i<list.size();i++){%>
                                <p class="sys-ch" style="text-align:center;line-height:30px;"><%=list.get(i).getName() %> x<%=list.get(i).getNum() %></p>
                                <%} %>
                            </div>
                        </td>
                        <td class="table_cell price" style="width:15%;">
                           <p class="sys-ch-bold" style="color:#A4313E;text-align:center"><%=cart.getTotal() %></p>
                        </td>
                    </tr>
                    
                </tbody>
            </table>
            <div style="text-align:left;margin-top:10px;">
                <span class="title-ch-bold" style="color: #C43F50;padding-right:10px;line-height:30px;">提货方式：</span>
                <label class="sys-ch"><input name="get_way" type="radio" value="deliver" />送货上门</label>
                <span class="sys-ch" style="margin-left:30px;">地址：</span>
                <input id="address_input" value="<%=user.getAddress() %>" style="width:450px;height:30px;">
            </div>
            <div style="text-align:left;margin:10px 113px;">
                <label class="sys-ch"><input name="get_way" type="radio" value="store" />门店自提</label>
            </div>
            <div style="text-align:left;margin-top:40px;">
                <p class="sys-ch" >可用积分：<%=user.getPoint() %></p>
                <label class="sys-ch" style="margin-top:10px;"><input id="usepoint" type="checkbox" value="use" />使用积分：</label>
                <input id="point_input" style="width:180px;height:30px;margin-top:10px;">
                <span id="point_money" class="sys-ch" style="margin-left:30px;">100积分可抵1元</span>
            </div>
            
            <a id="subBtn" onclick="orderSubmit()" style="line-height:40px;height:40px;width:150px;font-size:20px;" href="#" onclick="">确认</a>
        
    </div>
</body>

</html>