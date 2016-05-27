<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="desserthouse.action.ChargeListBean"%>
<%@ page import="desserthouse.action.OrderListBean"%>
<%@ page import="desserthouse.model.Cart"%>
<%@ page import="desserthouse.model.Staff"%>
<%@ page import="desserthouse.model.PlanCommodity"%>
<%@ page import="desserthouse.model.Order"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="StoreOrderList"
	type="desserthouse.action.OrderListBean"
	scope="session"></jsp:useBean>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>分店销售</title>
    
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
        function showSale(){
            document.getElementById("sale").style.visibility = "";
            document.getElementById("booking").style.visibility = "hidden";
            document.getElementById("indexmenu").style.height = '800px';
        }
        function showMember(){
        	<%ChargeListBean chargeListBean = new ChargeListBean();
        	  OrderListBean orderListBean = new OrderListBean();
        	  session.setAttribute("ChargeList", chargeListBean);
        	  session.setAttribute("OrderList", orderListBean);
        	  %>
        	window.open("saleuser.jsp");
        	
        }
        function showBooking(){
            document.getElementById("sale").style.visibility = "hidden";
            document.getElementById("booking").style.visibility = "";
            document.getElementById("indexmenu").style.height = '800px';
        }
        
    </script>
    
    <script src="../js/jquery.min.js"></script>
    <script type="text/javascript">
	    $(function(){
	        $('#commodity_input').bind('keypress',function(event){
	            if(event.keyCode == "13")    
	            {
	                productAdd();
	            }
	        });
	    });
	    $(function(){
	        $('#pay_input').bind('keypress',function(event){
	            if(event.keyCode == "13")    
	            {
	                var pay = parseFloat(document.getElementById("pay_input").value);
	                var total = parseFloat(document.getElementById("totalpricetag").innerHTML);
	                var change = toDecimal2(pay-total);
	                document.getElementById("change").innerHTML = change;
	            }
	        });
	    });
	    function toDecimal2(x) { 
            var f = parseFloat(x); 
            if (isNaN(f)) { 
              return false; 
            } 
            var f = Math.round(x*100)/100; 
            var s = f.toString(); 
            var rs = s.indexOf('.'); 
            if (rs < 0) { 
              rs = s.length; 
              s += '.'; 
            } 
            while (s.length <= rs + 1) { 
              s += '0'; 
            } 
            return s; 
	    }
	    
    	function productAdd(){
    		$.ajax({
                //提交数据的类型 POST GET
                type:"POST",
                //提交的网址
                url:"/DessertHouse/SaleServlet",
                //提交的数据
                data:{type:"addCommodity",
                	  commodity_id:document.getElementById("commodity_input").value
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
    	
    	function add(i){
        	$.ajax({
                //提交数据的类型 POST GET
                type:"POST",
                //提交的网址
                url:"/DessertHouse/SaleServlet",
                //提交的数据
                data:{type:"addNum",
                	  commodity_id:i
                },
                //返回数据的格式
                datatype: "text",//"xml", "html", "script", "json", "jsonp", "text".
                success:function(data){
                    if(data=="nostock"){
                    	alert("该商品库存不足");
                    }
                    else{
                    	var num = parseInt(document.getElementById("num"+i).value);
                    	num = num+1;
                    	document.getElementById("num"+i).value = num;
                    	var price = parseFloat(document.getElementById("price"+i).innerHTML);
                    	var total = price*num;
                    	document.getElementById("totalprice"+i).innerHTML = total;
                    	document.getElementById("totalpricetag").innerHTML = data;
                    }
                }
            });
        }
        
        function min(i){
        	var num = parseInt(document.getElementById("num"+i).value);
        	if(num>1){
	        	$.ajax({
	                //提交数据的类型 POST GET
	                type:"POST",
	                //提交的网址
	                url:"/DessertHouse/SaleServlet",
	                //提交的数据
	                data:{type:"minNum",
	                	  commodity_id:i
	                },
	                //返回数据的格式
	                datatype: "text",//"xml", "html", "script", "json", "jsonp", "text".
	                success:function(data){
	                 
	                   	var num = parseInt(document.getElementById("num"+i).value);
	                   	num = num-1;
	                   	document.getElementById("num"+i).value = num;
	                   	var price = parseFloat(document.getElementById("price"+i).innerHTML);
	                   	var total = price*num;
	                   	document.getElementById("totalprice"+i).innerHTML = total;
	                   	document.getElementById("totalpricetag").innerHTML = data;
	                   
	                }
	            });
        	}
        }
        
        function deleteCommodity(i){
        	$.ajax({
                //提交数据的类型 POST GET
                type:"POST",
                //提交的网址
                url:"/DessertHouse/SaleServlet",
                //提交的数据
                data:{type:"delete",
                	  commodity_id:i
                },
                //返回数据的格式
                datatype: "text",//"xml", "html", "script", "json", "jsonp", "text".
                success:function(data){
                	location.reload();
                }
            });
        }
        
        function submit(){
        	var item = $("input[name='pay_way']:checked"); 
        	var len=item.length; 
        	if(len>0){
        		var type = $("input[name='pay_way']:checked").val(); 
       		
       			$.ajax({
                       //提交数据的类型 POST GET
                       type:"POST",
                       //提交的网址
                       url:"/DessertHouse/SaleServlet",
                       //提交的数据
                       data:{type:"sub",
                    	   paytype:type,
                       	  card:document.getElementById("card_input").value
                       },
                       //返回数据的格式
                       datatype: "text",//"xml", "html", "script", "json", "jsonp", "text".
                       success:function(data){
	                       	if(data=="nouser")
	                       		alert("该账户不存在！");
	                       	else if(data=="noactive")
	                       		alert("该账户状态异常，无法购买！");
	                       	else if(data=="nomoney")
	                       		alert("该账户余额不足！");
	                       	else{
	                       		alert("订单完成！");
	                       		location.reload();
	                       	}
                        
                       }
                   });	
       		}
               		
       	
       		else
        		alert("请选择付款方式")
        }
        
        function orderConfirm(id){
        	$.ajax({
                //提交数据的类型 POST GET
                type:"POST",
                //提交的网址
                url:"/DessertHouse/SaleServlet",
                //提交的数据
                data:{type:"orderget",
                	  orderId:id
                },
                //返回数据的格式
                datatype: "text",//"xml", "html", "script", "json", "jsonp", "text".
                success:function(data){
                	alert("确认成功！");
                	location.reload();
                }
            });
        }
    </script>
</head>

<body>
    
    <div id="indexmenu" style="padding-top:50px;height:800px;">
           <a href="#" onclick="showSale()" class="btn btn-2">销售</a> 
           <a href="#" onclick="showBooking()" class="btn btn-2">预定提货</a> 
           <a href="#" onclick="showMember()" class="btn btn-2">会员</a>
    </div>
    
<%
	Cart cart =(Cart) session.getAttribute("salecart");
	if(cart==null){
		cart = new Cart();
		cart.init();
	}
%>
    <div id="sale" class="right-container" style="height:800px;visibility:">
        <h1>销售</h1>
        <div style="position:relative;width:95%; margin-top:20px;">
            <div class="right_nr_search" style="left:0px;top:0px;">
               <input type="text" id="commodity_input" name="productKey" value="商品编号" onblur="if(this.value==''){this.value='商品编号';$('#commodity_input').css('color','#dbdada');}" onfocus="if(this.value=='商品编号'){this.value=''; $('#commodity_input').css('color','');}" style="color: rgb(219, 218, 218);">
               <a onclick="productAdd()" name="search_tj" class="search_tj"></a>
                
            </div>
            <table id="cart_table" cellspacing="0" style="position:relative;top:40px;">
                <thead id="table_head">
                    <tr>
                        <th style="height:30px;">
                            <p>商品详情</p>
                        </th>
                        <th style="height:30px;">
                            <p>单价</p>
                        </th>
                        <th style="height:30px;">
                            <p>数量</p>
                        </th>
                        <th style="height:30px;">
                            <p>金额</p>
                        </th>
                        <th style="height:30px;">
                            <p>操作</p>
                        </th>
                    </tr>
                </thead>
                <tbody id="userGroups" class="tbody">
                <%for(int i=0;i<cart.getList().size();i++){
                		PlanCommodity pc = (PlanCommodity) cart.getList().get(i);
                		String pid = "price"+i;
                		String nid = "num"+i;
                		String tpid = "totalprice"+i;
                	%>
                    <tr>
                        <td class="table_cell info">
                            <div style="height:40px;">
                                <p class="sys-ch" style="text-align:center;line-height:40px;"><%=pc.getName() %></p>
                            </div>
                        </td>
                        <td class="table_cell price">
                           <p id="<%=pid %>" class="sys-ch"><%=pc.getPrice() %></p>
                        </td>
                        <td class="table_cell num">
                            <div class="item-amount">
                                <a href="#" onclick="min('<%=i%>')">-</a>
                                <input id="<%=nid %>" class="numvalue" type="text" value="<%=pc.getNum()%>">
                                <a href="#" onclick="add('<%=i%>')">+</a>
                            </div>
                        </td>
                        <td class="table_cell price">
                           <p id="<%=tpid %>" class="sys-ch-bold" style="color:#A4313E"><%=pc.getNum()*pc.getPrice() %></p>
                        </td>
                        <td class="table_cell action">
                            <a href="#" onclick="deleteCommodity(<%=i %>)" class="sys-ch">删除</a>
                        </td>
                    </tr>
                <%} %>
                </tbody>
            </table>
            <div style="margin-top: 50px; height:125px;">
                <div style="text-align:right;">
                    <span class="title-ch-bold" style="color: #C43F50;padding-right:10px;line-height:30px;">总价：</span>
                    <span id="totalpricetag"><%=cart.getTotal() %></span>
                </div>
                <div style="text-align:right;margin-top:10px;">
                    <span class="title-ch-bold" style="color: #C43F50;padding-right:10px;line-height:30px;">支付方式：</span>
                    <label class="sys-ch"><input name="pay_way" type="radio" value="money" />现金</label>
                    <span class="sys-ch" style="margin-left:30px;">付款：</span>
                    <input id="pay_input" style="width:130px;height:30px;">
                    <span class="sys-ch" style="margin-left:30px;">找零：</span>
                    <span id="change" class="sys-ch-bold" style="color:#C43F50">0.0</span> 
                </div>
                <div style="text-align:right;margin-top:10px;">
                    <label class="sys-ch"><input name="pay_way" type="radio" value="card" />会员卡</label>
                    <span class="sys-ch" style="margin-left:15px;">卡号：</span>
                    <input id="card_input" style="width:240px;height:30px;">
                </div>
            </div>
            <a class="calBtn" onclick="submit()" style="line-height:40px;height:40px;width:150px;font-size:20px;" href="#" onclick="">确认</a>
        </div>
    </div>
    

    <div id="booking" class="right-container" style="height:800px;visibility:hidden">
        <h1>预定提货</h1>
        <div style="position:relative;width:95%; margin-top:20px;">
            <div class="right_nr_search" style="left:0px;top:0px;">
               <form>
                   <input type="text" id="productKey" name="productKey" value="订单号" onblur="if(this.value==''){this.value='订单号';$('#productKey').css('color','#dbdada');}" onfocus="if(this.value=='订单号'){this.value=''; $('#productKey').css('color','');}" style="color: rgb(219, 218, 218);">
                   <input name="search_tj" type="submit" value=" " class="search_tj">
                </form>
            </div>
            
            <table id="cart_table" cellspacing="0" style="position:relative;top:40px;">
                <thead id="table_head">
                    <tr>
                        <th style="height:30px;">
                            <p>订单编号</p>
                        </th>
                        <th style="height:30px;">
                            <p>预订人</p>
                        </th>
                        <th style="height:30px;">
                            <p>订单详情</p>
                        </th>
                        <th style="height:30px;">
                            <p>金额</p>
                        </th>
                        <th style="height:30px;">
                            <p>操作</p>
                        </th>
                    </tr>
                </thead>
                <tbody id="userGroups" class="tbody">
                <%
                for(int i=0;i<StoreOrderList.getOrderList().size();i++){
                	Order order = StoreOrderList.getOrder(i);%>
                    <tr>
                        <td class="table_cell admin" style="width:20%;">
                            <p class="sys-ch"><%=order.getId() %></p>
                        </td>
                        <td class="table_cell admin" style="width:15%;">
                            <p class="sys-ch"><%=order.getUser() %></p>
                        </td>
                        <td class="table_cell info">
                            <div style="">
                            <%
                            double total = 0;
                            for(int j=0;j<order.getCommodity().size();j++){
                            	total = total + order.getCommodity().get(j).getNum()*order.getCommodity().get(j).getPrice();%>
                            
                                <p class="sys-ch" style="text-align:center;line-height:30px;"><%=order.getCommodity().get(j).getName() %> x<%=order.getCommodity().get(j).getNum() %></p>
                            <%} %> 
                            </div>
                        </td>
                        <td class="table_cell price">
                           <p class="sys-ch-bold" style="color:#A4313E"><%=total %></p>
                        </td>
                        <td class="table_cell action" style="width:15%;">
                            <a href="#" onclick="orderConfirm(<%=order.getId() %>)" class="sys-ch">提货确认</a>
                        </td>
                    </tr>
                <%} %>  
                </tbody>
            </table>
            
        </div>
        
    </div>

</body>




</html>