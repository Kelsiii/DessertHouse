<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="desserthouse.model.Cart"%>
<%@ page import="desserthouse.model.PlanCommodity"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>购物车</title>
    
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
        }
        
        h1 {
            color: #2C1201;
            font-size: 30px;
            font-family: 微软雅黑;
        }

        a {
            text-decoration: none;
        }
        
        #totalpricetag{
            font-family: 黑体;
            font-size: 25px;
            font-weight: 600;
            color: #C43F50;
            float: right;
            padding-right: 30px;
            line-height: 50px;
        }
        
    </style>
    
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
                url:"/DessertHouse/OrderServlet",
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
	                url:"/DessertHouse/OrderServlet",
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
                url:"/DessertHouse/OrderServlet",
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
    </script>
    
</head>

<%
	Cart cart =(Cart) session.getAttribute("ordercart");
	if(cart==null){
		cart = new Cart();
		cart.init();
	}
%>    

<body>
    <div style="position:relative;width:70%; left:15%; margin-top:40px;">
        <h1>购物车</h1>
          
        <div>
            <table id="cart_table" cellspacing="0" >
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
            
              <div style="margin-top: 30px; height:100px;">
                  
                  <a id="" class="calBtn" href="calculate.jsp" onclick="">结    算</a>
                  <span id="totalpricetag"><%=cart.getTotal() %></span>
                  <span class="title-ch-bold" style="color: #C43F50;float:right;padding-right:10px;line-height:50px;">总计：</span>
              </div>
                
          </div>
          
          
      </div>
       
</body>


</html>