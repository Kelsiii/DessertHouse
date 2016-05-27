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
    </script>
    
    <script type="text/javascript">
    	function showPlan(){
    		document.getElementById("plan").style.visibility = "";
    		document.getElementById("sale").style.visibility = "hidden";
    		document.getElementById("user").style.visibility = "hidden";
    		document.getElementById("indexmenu").style.height = '580px';
    	}
    	
    	function showSale(){
    		document.getElementById("plan").style.visibility = "hidden";
    		document.getElementById("sale").style.visibility = "";
    		document.getElementById("user").style.visibility = "hidden";
    		document.getElementById("indexmenu").style.height = '1500px';
    	}
    	
    	function showUser(){
    		document.getElementById("user").style.visibility = "";
    		document.getElementById("plan").style.visibility = "hidden";
    		document.getElementById("sale").style.visibility = "hidden";
    		document.getElementById("indexmenu").style.height = '580px';
    	}
    </script>
</head>

<body>
    <div id="indexmenu" style="padding-top:50px;">
           <a href="#" onclick="showPlan()" class="btn btn-2">销售计划</a> 
           <a href="#" onclick="showSale()" class="btn btn-2">销售统计</a>
           <a href="#" onclick="showUser()" class="btn btn-2">会员统计</a>
    </div>
    
    <div class="right-container" id="plan" style="visibility:">
        <h1>待审核销售计划</h1>
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
                        <p>操作</p>
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
    
    <div class="right-container" id="sale" style="visibility:hidden;height:1500px;">
        <h1>销售统计</h1>
        
        <div style="margin-top:20px;">
            <div style="width:70%;position:relative;float:left;">
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
                    //先排年龄  
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
            <div style="width:25%;position:relative;float:right;padding-top:20px;">
                <h2>月度热销</h2>
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
    	
    <div class="right-container" id="user" style="visibility:hidden;">
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
    </div>
</body>

</html>