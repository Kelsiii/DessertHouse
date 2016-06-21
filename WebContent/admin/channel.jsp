<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="desserthouse.model.StoreSale"%>
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
	    	
	    	var timeselect = document.getElementById("time").selectedIndex;

	    	$.ajax({
	            //提交数据的类型 POST GET
	            type:"POST",
	            //提交的网址
	            url:"/DessertHouse/StatServlet",
	            //提交的数据
	            data:{type:"channel-stat",
	            	time: document.getElementById("time")[timeselect].value,
	            },
	            //返回数据的格式
	            datatype: "text",//"xml", "html", "script", "json", "jsonp", "text".
	            success:function(data){
	                window.location.href="channel.jsp"; 
	            }
	        });
	    }
    </script>
    
</head>

<body>
    <div id="indexmenu" style="padding-top:50px;height:1000px;">
           <a href="manager.jsp" class="btn btn-2">销售计划</a>
           <a href="salestat.jsp" class="btn btn-2">销售统计</a>
           <a href="userstat.jsp" class="btn btn-2">会员统计</a>
           <a href="channel.jsp" class="btn btn-2">渠道统计</a>
           <a href="staffstat.jsp" class="btn btn-2">业绩统计</a>
    </div>
    <%String select = (String) session.getAttribute("selectyear"); %>
    <div class="right-container" id="user"  style="height:1000px;">
    	<h1>渠道统计</h1>
    	<span class="sys-ch" style="margin:20px 0px;"> 年度：</span>
        <select id="time" onchange="setStat()" style="width:150px;height:30px;margin:20px 0px;">
        	<option value ="2016"<%if(select.equals("2016")){ %> selected <%} %>>2016</option>
        	<option value ="2015"<%if(select.equals("2015")){ %> selected <%} %>>2015</option>
        	<option value ="2014"<%if(select.equals("2014")){ %> selected <%} %>>2014</option>
        </select>
    	<div id="channelchart1" style="margin-top:20px;width:100%;height:400px;"></div>
    	<script src="../js/echarts.min.js"></script>
    	<%List<double[]> channel= (List<double[]>) session.getAttribute("ChannelStat");
    	%>
        <script type="text/javascript">
	        var Chart1 = echarts.init(document.getElementById("channelchart1"));
	        var option = {
	        	    title: {
	        	        text: '渠道统计图'
	        	    },
	        	    tooltip : {
	        	        trigger: 'axis'
	        	    },
	        	    legend: {
	        	        data:['实体店','在线销售']
	        	    },
	        	    grid: {
	        	        left: '3%',
	        	        right: '4%',
	        	        bottom: '3%',
	        	        containLabel: true
	        	    },
	        	    xAxis : [
	        	        {
	        	            type : 'category',
	        	            boundaryGap : false,
	        	            data : ['一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月']
	        	        }
	        	    ],
	        	    yAxis : [
	        	        {
	        	            type : 'value'
	        	        }
	        	    ],
	        	    series : [
	        	        {
	        	            name:'实体店',
	        	            type:'line',
	        	            stack: '总量',
	        	            areaStyle: {normal: {}},
	        	            data:[<%=channel.get(0)[0] %>, <%=channel.get(0)[1] %>, <%=channel.get(0)[2] %>, <%=channel.get(0)[3] %>, <%=channel.get(0)[4] %>, <%=channel.get(0)[5] %>,
	        	                  <%=channel.get(0)[6] %>,<%=channel.get(0)[7] %>,<%=channel.get(0)[8] %>,<%=channel.get(0)[9] %>,<%=channel.get(0)[10] %>,<%=channel.get(0)[11] %>]
	        	        },
	        	        {
	        	            name:'在线销售',
	        	            type:'line',
	        	            stack: '总量',
	        	            areaStyle: {normal: {}},
	        	            data:[<%=channel.get(1)[0] %>, <%=channel.get(1)[1] %>, <%=channel.get(1)[2] %>, <%=channel.get(1)[3] %>, <%=channel.get(1)[4] %>, <%=channel.get(1)[5] %>,
	        	                  <%=channel.get(1)[6] %>,<%=channel.get(1)[7] %>,<%=channel.get(1)[8] %>,<%=channel.get(1)[9] %>,<%=channel.get(1)[10] %>,<%=channel.get(1)[11] %>]
	        	        }
	        	    ]
	        	};

	        Chart1.setOption(option);
        </script>
    	
    	<div id="channelchart2" style="margin-top:20px;width:100%;height:400px;"></div>
    	<%	int storenum = StoreList.getStoreList().size();
    		
    	%>
    	<%	Map map = (HashMap) session.getAttribute("StoreStat");
    		List<StoreSale> list1 = (List) map.get("01");
    		List<StoreSale> list2 = (List) map.get("02");
    		List<StoreSale> list3 = (List) map.get("03");
    		List<StoreSale> list4 = (List) map.get("04");
    		List<StoreSale> list5 = (List) map.get("05");
    		List<StoreSale> list6 = (List) map.get("06");
    		List<StoreSale> list7 = (List) map.get("07");
    		List<StoreSale> list8 = (List) map.get("08");
    		List<StoreSale> list9 = (List) map.get("09");
    		List<StoreSale> list10 = (List) map.get("10");
    		List<StoreSale> list11 = (List) map.get("11");
    		List<StoreSale> list12 = (List) map.get("12");
    	%>
    	<script type="text/javascript">
    		var Chart2 = echarts.init(document.getElementById("channelchart2"));
    		var option2 = {
    				title: {
	        	        text: '分店统计图'
	        	    },
    			    tooltip : {
    			        trigger: 'axis',
    			        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
    			            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
    			        }
    			    },
    			    legend: {
    			    	data:[<%for(int i=0;i<storenum-1;i++){%>'<%=list1.get(i).getName()%>',<%}%>'<%=list1.get(storenum-1).getName()%>']
    			        
    			    },
    			    grid: {
    			        left: '3%',
    			        right: '4%',
    			        bottom: '3%',
    			        containLabel: true
    			    },
    			    xAxis : [
    			        {
    			            type : 'category',
    			            data : ['一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月']
    			        }
    			    ],
    			    yAxis : [
    			        {
    			            type : 'value'
    			        }
    			    ],
    			    series : [
    			        <% for(int i=0;i<storenum-1;i++){%>
    			             
    			        {
    			            name:'<%= list1.get(i).getName()%>',
    			            type:'bar',
    			            data:[<%=list1.get(i).getPrice() %>, <%=list2.get(i).getPrice() %>, <%=list3.get(i).getPrice() %>, <%=list4.get(i).getPrice() %>, <%=list5.get(i).getPrice() %>, <%=list6.get(i).getPrice() %>,
    			                  <%=list7.get(i).getPrice() %>, <%=list8.get(i).getPrice() %>, <%=list9.get(i).getPrice() %>, <%=list10.get(i).getPrice() %>, <%=list11.get(i).getPrice() %>, <%=list12.get(i).getPrice() %>]
    			        },
    			        <%}%>
    			        <%int i=storenum-1;%>
    			        {
    			            name:'<%= list1.get(i).getName()%>',
    			            type:'bar',
    			            data:[<%=list1.get(i).getPrice() %>, <%=list2.get(i).getPrice() %>, <%=list3.get(i).getPrice() %>, <%=list4.get(i).getPrice() %>, <%=list5.get(i).getPrice() %>, <%=list6.get(i).getPrice() %>,
    			                  <%=list7.get(i).getPrice() %>, <%=list8.get(i).getPrice() %>, <%=list9.get(i).getPrice() %>, <%=list10.get(i).getPrice() %>, <%=list11.get(i).getPrice() %>, <%=list12.get(i).getPrice() %>]
    			        }
    			    ]
    			};
    		Chart2.setOption(option2);
    	</script>
    
    </div>
    	
    
</body>


</html>