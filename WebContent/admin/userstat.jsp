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
    
    
</head>

<body>
    <div id="indexmenu" style="padding-top:50px;height:1000px;">
           <a href="manager.jsp" class="btn btn-2">销售计划</a>
           <a href="salestat.jsp" class="btn btn-2">销售统计</a>
           <a href="userstat.jsp" class="btn btn-2">会员统计</a>
           <a href="channel.jsp" class="btn btn-2">渠道统计</a>
           <a href="staffstat.jsp" class="btn btn-2">业绩统计</a>
    </div>
    
    <div class="right-container" id="user"  style="height:1000px;">
    	<h1>会员统计</h1>
    	<%
    	Map map = (HashMap) session.getAttribute("UserStat"); 
    	int level1 = (int) map.get("level1");
    	int level2 = (int) map.get("level2");
    	int level3 = (int) map.get("level3");
    	int level4 = (int) map.get("level4");
    	int age18 = (int) map.get("less18");
    	int age25 = (int) map.get("1825");
    	int age35 = (int) map.get("2535");
    	int age50 = (int) map.get("3550");
    	int agemore = (int) map.get("more50");
    	int inactive = (int) map.get("inactive");
    	int active = (int) map.get("active");
    	int stop = (int) map.get("stop");
    	int paused = (int) map.get("paused");
    	%>
    	<div id="userchart1" style="position:relative;float:left;margin-top:20px;width:47%;height:380px;"></div>
    	<script src="../js/echarts.min.js"></script>
	    <script type="text/javascript">
	    	var userChart1 = echarts.init(document.getElementById("userchart1"));
	    	var option={
	    	    title : {
	    	        text: '会员状态',
	    	        x:'center'
	    	    },
	    	    tooltip : {
	    	        trigger: 'item',
	    	        formatter: "{a} <br/>{b} : {c} ({d}%)"
	    	    },
	    	    legend: {
	    	        x : 'center',
	    	        y : 'bottom',
	    	        data:['未激活','正常','暂停','注销']
	    	    },
	    	    toolbox: {
	    	        show : false,
	    	        feature : {
	    	            mark : {show: true},
	    	            dataView : {show: true, readOnly: false},
	    	            magicType : {
	    	                show: true,
	    	                type: ['pie', 'funnel']
	    	            },
	    	            restore : {show: true},
	    	            saveAsImage : {show: true}
	    	        }
	    	    },
	    	    calculable : true,
	    	    series : [
	    	        {
	    	            name:'面积模式',
	    	            type:'pie',
	    	            radius : [30, 110],
	    	            center : ['50%', 200],
	    	            roseType : 'area',
	    	            data:[
	    	                {value:<%=inactive%>, name:'未激活'},
	    	                {value:<%=active%>, name:'正常'},
	    	                {value:<%=paused%>, name:'暂停'},
	    	                {value:<%=stop%>, name:'注销'}
	    	            ]
	    	        }
	    	    ]
	    	};
	    	userChart1.setOption(option);
	    
	    </script>
    	
    	<div id="userchart2" style="margin-top:20px;position:relative;float:right;width:47%;height:380px;"></div>
    	<script type="text/javascript">
    		var userChart2 = echarts.init(document.getElementById("userchart2"));
    		var option2 = {
   				title : {
   	    	        text: '会员分布',
   	    	        x:'center'
   	    	    },
   			    tooltip: {
   			        trigger: 'item',
   			        formatter: "{a} <br/>{b}: {c} ({d}%)"
   			    },
   			    legend: {
   			        x: 'center',
   			        y: 'bottom',
   			        data:['普通会员','高级会员','白银会员','钻石会员','小于18','18~25','25~35','35~50','大于50']
   			    },
   			    series: [
   			        {
   			            name:'会员等级',
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
   			                {value:<%=level1%>, name:'普通会员', selected:true},
   			                {value:<%=level2%>, name:'高级会员'},
   			                {value:<%=level3%>, name:'白银会员'},
   			                {value:<%=level4%>, name:'钻石会员'}
   			            ]
   			        },
   			        {
   			            name:'年龄分布',
   			            type:'pie',
   			            radius: ['40%', '55%'],

   			            data:[
   			                {value:<%=age18%>, name:'小于18'},
   			                {value:<%=age25%>, name:'18~25'},
   			                {value:<%=age35%>, name:'25~35'},
   			                {value:<%=age50%>, name:'35~50'},
   			                {value:<%=agemore%>, name:'大于50'}
   			            ]
   			        }
   			    ]
   			};
	    	userChart2.setOption(option2);
    	</script>
    
    	<div id="userchart3" style="margin-top:470px;width:100%;height:400px;"></div>
    	<%
    	Map map2 = (HashMap) session.getAttribute("UserLevel"); 
    	int[] user1 = (int[]) map2.get("level1");
    	int[] user2 = (int[]) map2.get("level2");
    	int[] user3 = (int[]) map2.get("level3");
    	int[] user4 = (int[]) map2.get("level4");
    	%>
    	<script type="text/javascript">
    		var userChart3 = echarts.init(document.getElementById("userchart3"));
    		var option3={
    				title : {
       	    	        text: '会员等级',
       	    	        x:'center'
       	    	    },
    			    tooltip : {
    			        trigger: 'axis',
    			        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
    			            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
    			        }
    			    },
    			    legend: {
    			        data: ['小于18', '18~25','25~35','35~50','大于50'],
    			        bottom: 0
    			    },
    			    grid: {
    			        left: '3%',
    			        right: '4%',
    			        bottom: '3%',
    			        containLabel: true
    			    },
    			    xAxis:  {
    			        type: 'value'
    			    },
    			    yAxis: {
    			        type: 'category',
    			        data: ['普通会员','高级会员','白银会员','钻石会员']
    			    },
    			    series: [
    			        {
    			            name: '小于18',
    			            type: 'bar',
    			            stack: '总量',
    			            label: {
    			                normal: {
    			                    show: true,
    			                    position: 'insideRight'
    			                }
    			            },
    			            data: [<%=user1[0]%>, <%=user2[0]%>, <%=user3[0]%>, <%=user4[0]%>]
    			        },
    			        {
    			            name: '18~25',
    			            type: 'bar',
    			            stack: '总量',
    			            label: {
    			                normal: {
    			                    show: true,
    			                    position: 'insideRight'
    			                }
    			            },
    			            data: [<%=user1[1]%>, <%=user2[1]%>, <%=user3[1]%>, <%=user4[1]%>]
    			        },
    			        {
    			            name: '25~35',
    			            type: 'bar',
    			            stack: '总量',
    			            label: {
    			                normal: {
    			                    show: true,
    			                    position: 'insideRight'
    			                }
    			            },
    			            data: [<%=user1[2]%>, <%=user2[2]%>, <%=user3[2]%>, <%=user4[2]%>]
    			        },
    			        {
    			            name: '35~50',
    			            type: 'bar',
    			            stack: '总量',
    			            label: {
    			                normal: {
    			                    show: true,
    			                    position: 'insideRight'
    			                }
    			            },
    			            data: [<%=user1[3]%>, <%=user2[3]%>, <%=user3[3]%>, <%=user4[3]%>]
    			        },
    			        {
    			            name: '大于50',
    			            type: 'bar',
    			            stack: '总量',
    			            label: {
    			                normal: {
    			                    show: true,
    			                    position: 'insideRight'
    			                }
    			            },
    			            data: [<%=user1[4]%>, <%=user2[4]%>, <%=user3[4]%>, <%=user4[4]%>]
    			        }
    			    ]
    			};
    		userChart3.setOption(option3);
    	</script>
    
    </div>
    	
    
</body>


</html>