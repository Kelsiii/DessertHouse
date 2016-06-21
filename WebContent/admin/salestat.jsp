<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="desserthouse.model.PlanCommodity"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="PlanList"
	type="desserthouse.action.PlanListBean"
	scope="session"></jsp:useBean>
<jsp:useBean id="planitem" class="desserthouse.model.Plan"
	scope="page"></jsp:useBean>
<jsp:useBean id="SaleStat"
	type="desserthouse.action.SaleStatisticBean"
	scope="session"></jsp:useBean>
<jsp:useBean id="StoreList"
	type="desserthouse.action.StoreListBean"
	scope="session"></jsp:useBean>
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
	    	var storeselect = document.getElementById("store").selectedIndex;
	    	var timeselect = document.getElementById("time").selectedIndex;

	    	$.ajax({
	            //提交数据的类型 POST GET
	            type:"POST",
	            //提交的网址
	            url:"/DessertHouse/StatServlet",
	            //提交的数据
	            data:{type:"commodity-stat",
	            	store: document.getElementById("store")[storeselect].value,
	            	timetype: document.getElementById("time")[timeselect].value,
	            },
	            //返回数据的格式
	            datatype: "text",//"xml", "html", "script", "json", "jsonp", "text".
	            success:function(data){
	                window.location.href="salestat.jsp"; 
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
        <h1>销售统计</h1>
        <%
    	Map map = (HashMap) session.getAttribute("CommodityStat"); 
    	int breadnum = (int) map.get("breadnum");
    	int cakenum = (int) map.get("cakenum");
    	int dessertnum = (int) map.get("dessertnum");
    	int drinknum = (int) map.get("drinknum");
    	double breadprice = (double) map.get("breadprice");
    	double cakeprice = (double) map.get("cakeprice");
    	double dessertprice = (double) map.get("dessertprice");
    	double drinkprice = (double) map.get("drinkprice");
    	%>
        <div style="margin-top:20px;">
            <div style="width:70%;position:relative;float:left;">
    <%String selecttime = (String) session.getAttribute("selecttime");
    	String selectstore = (String) session.getAttribute("selectstore");
    %>
            	<span class="sys-ch" style=""> 统计范围：</span>
		        <select id="time" style="width:150px;height:30px;">
		        	<option value ="month" <%if(selecttime.equals("month")){ %> selected <%} %>>本月</option>
		        	<option value ="season" <%if(selecttime.equals("season")){ %> selected <%} %>>本季度</option>
		        	<option value ="year" <%if(selecttime.equals("year")){ %> selected <%} %>>本年度</option>
		        </select>
		        <span class="sys-ch" style="margin-left:30px;">店铺：</span>
		        <select id="store" style="width:150px;height:30px;">
		        <option value ="all" selected>所有门店</option>
		        <%for(int i=0;i<StoreList.getStoreList().size();i++){
		        	%>
		              <option value ="<%= StoreList.getStore(i).getId() %>"
		              <%if(selectstore.equals(StoreList.getStore(i).getId())){ %> selected <%} %>
		              ><%= StoreList.getStore(i).getName()%></option>
		        <%} %>
		        </select>
		        <a class="ghbutton gray" href="#" onclick="setStat()" style="margin-left:30px;width:100px;height:30px;font-size:14px;">查询</a>
                
                <table id="cart_table" cellspacing="0" >
                    <thead id="table_head">
                        <tr>
                            <th style="height:44px;">
                                <p>商品详情</p>
                            </th>
                            <th style="height:44px;" >
                                <p>单价</p>
                            </th>
                            <th style="height:44px;">
                                <p>销量</p>
                            </th>
                        </tr>
                    </thead>
                    <tbody id="userGroups" class="tbody">
                    <%
                    List<PlanCommodity> list = SaleStat.getCommodityList();
                    for(int i=0;i<list.size();i++){
                    	PlanCommodity pc = list.get(i);
                    %>
                        <tr>
                            <td class="table_cell" style="width:450px;">
                                <p class="sys-ch" style="line-height:40px;"><%=pc.getName() %></p>
                            </td>
                            <td class="table_cell">
                               <p style="text-align:center"><%=pc.getPrice() %></p>
                            </td>
                            <td class="table_cell">
                                <p style="text-align:center"><%=pc.getNum() %></p>
                            </td>
                        </tr>
                    <%} %>
                    </tbody>
                </table>
            </div>
            <%Comparator<PlanCommodity> comparator = new Comparator<PlanCommodity>(){  
                public int compare(PlanCommodity s1, PlanCommodity s2) {  
                     
                    if(s1.getNum()!=s2.getNum()){  
                        return s1.getNum()-s2.getNum();  
                    }  
                    else{  
                        return s1.getId().compareTo(s2.getId());
                    }  
                }  
            };
            Collections.sort(list,comparator);  
            int k = list.size();
            %>
            <div style="width:25%;position:relative;float:right;">
            	<div id="salechart" style="position:relative;float:left;width:100%;height:350px;margin-bottom:20px"></div>
            	<script src="../js/echarts.min.js"></script>
            	<script type="text/javascript">
    		var userChart2 = echarts.init(document.getElementById("salechart"));
    		var option2 = {
   				
   			    tooltip: {
   			        trigger: 'item',
   			        formatter: "{a} <br/>{b}: {c} ({d}%)"
   			    },
   			    legend: {
   			        x: 'center',
   			        y: 'bottom',
   			        data:['面包销量','甜点销量','蛋糕销量','饮料销量','面包销售额','甜点销售额','蛋糕销售额','饮料销售额']
   			    },
   			    series: [
   			        {
   			            name:'销售额',
   			            type:'pie',
   			            selectedMode: 'single',
   			            radius: [0, '30%'],

   			            label: {
   			                normal: {
   			                    show: false,
   			                    position: 'inner'
   			                }
   			            },
   			            labelLine: {
   			                normal: {
   			                    show: false
   			                }
   			            },
   			            data:[
   			                {value:<%=breadprice%>, name:'面包销售额', selected:true},
   			                {value:<%=drinkprice%>, name:'饮料销售额'},
   			                {value:<%=dessertprice%>, name:'甜点销售额'},
   			                {value:<%=cakeprice%>, name:'蛋糕销售额'}
   			            ]
   			        },
   			        {
   			            name:'销量分布',
   			            type:'pie',
   			            radius: ['40%', '55%'],

   			            data:[
   			                {value:<%=breadnum%>, name:'面包销量'},
   			                {value:<%=drinknum%>, name:'饮料销量'},
   			                {value:<%=dessertnum%>, name:'甜点销量'},
   			                {value:<%=cakenum%>, name:'蛋糕销量'}
   			            ]
   			        }
   			    ]
   			};
	    	userChart2.setOption(option2);
    	</script>
    
                <h2 id="stat-type">热销排行</h2>
                <ul>
                    <li>
                        <img class="pic" src="../images/<%=list.get(k-1).getId() %>.jpg">
                        <span class="sys-ch-bold" style="position:relative;top:30px;margin-left:20px;"><%=list.get(k-1).getName() %></span>        
                    </li>
                    <li>
                        <img class="pic" src="../images/<%=list.get(k-2).getId() %>.jpg">
                        <span class="sys-ch-bold" style="position:relative;top:30px;margin-left:20px;"><%=list.get(k-2).getName() %></span>        
                    </li>
                    <li>
                        <img class="pic" src="../images/<%=list.get(k-3).getId() %>.jpg">
                        <span class="sys-ch-bold" style="position:relative;top:30px;margin-left:20px;"><%=list.get(k-3).getName() %></span>        
                    </li>
                    <li>
                        <img class="pic" src="../images/<%=list.get(k-4).getId() %>.jpg">
                        <span class="sys-ch-bold" style="position:relative;top:30px;margin-left:20px;"><%=list.get(k-4).getName() %></span>        
                    </li>
                    <li>
                        <img class="pic" src="../images/<%=list.get(k-5).getId() %>.jpg">
                        <span class="sys-ch-bold" style="position:relative;top:30px;margin-left:20px;"><%=list.get(k-5).getName() %></span>        
                    </li>
                </ul>
                
            </div>
        </div>
    </div>
    	
    
</body>


</html>