<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="desserthouse.model.Store"%>
<%@ page import="net.sf.json.JSONObject.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="StoreList"
	type="desserthouse.action.StoreListBean"
	scope="session"></jsp:useBean>
<jsp:useBean id="storeitem" class="desserthouse.model.Store"
	scope="page"></jsp:useBean>
<jsp:useBean id="StaffList"
	type="desserthouse.action.StaffListBean"
	scope="session"></jsp:useBean>
<jsp:useBean id="staffitem" class="desserthouse.model.Staff"
	scope="page"></jsp:useBean>

<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>系统管理</title>
    
    <link rel="stylesheet" href="../css/slide.css">
    <link rel="stylesheet" href="../css/area.css">
    <link rel="stylesheet" href="../css/font.css">
	<link rel="stylesheet" href="../css/button.css">
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
            margin: 20px;
        }
        
        .lalala{
        	margin:20px 200px;
        }
        
    </style>
    
    <script src="../js/jquery.min.js"></script>
    <script type="text/javascript">
        function showShopList(){
            document.getElementById("store").style.visibility = "";
            document.getElementById("store_edit").style.visibility = "hidden";
            document.getElementById("staff").style.visibility = "hidden";
            document.getElementById("staff_edit").style.visibility = "hidden";
        }
        function showStaffList(){
            document.getElementById("store").style.visibility = "hidden";
            document.getElementById("store_edit").style.visibility = "hidden";
            document.getElementById("staff").style.visibility = "";
            document.getElementById("staff_edit").style.visibility = "hidden";
        }
        function showShopEdit(storeid,name,address,tel){
            
           	document.getElementById("store_id").value = storeid;
           	document.getElementById("store_id").disabled = true;
           	document.getElementById("store_name").value = name;
           	document.getElementById("store_address").value = address;
           	document.getElementById("store_tel").value = tel;
            document.getElementById("store_delete").style.display = "inline-block";
            document.getElementById("store").style.visibility = "hidden";
            document.getElementById("store_edit").style.visibility = "";
            document.getElementById("store_submit").style.marginLeft = "50px";
            document.getElementById("store_submit").onclick = function(){
            	if(document.getElementById("store_id").value == ""||
            			document.getElementById("store_name").value == ""||
            			document.getElementById("store_address").value == ""||
            			document.getElementById("store_tel").value == "")
            		alert("信息不完整");
            	else{
            		$.ajax({
                        //提交数据的类型 POST GET
                        type:"POST",
                        //提交的网址
                        url:"/DessertHouse/StoreServlet",
                        //提交的数据
                        data:{type:"update",
                        	  id:document.getElementById("store_id").value,
                        	  name:document.getElementById("store_name").value,
                              address:document.getElementById("store_address").value,
                              tel:document.getElementById("store_tel").value
                             },
                        //返回数据的格式
                        datatype: "text",//"xml", "html", "script", "json", "jsonp", "text".
                        success:function(data){
                            if(!data)
                                alert("信息填写有误,添加失败");
                            else{
                                alert("修改成功！");
                                window.location.href="admin.jsp";
                            }
                        }
                    });
            	}
            }
        }
        function showStaffEdit(id,password,name,tel,age,store,sex,position){
        	document.getElementById("staff").style.visibility = "hidden";
            document.getElementById("staff_edit").style.visibility = "";
            document.getElementById("staff_id").value = id;
           	document.getElementById("staff_id").disabled = true;
            document.getElementById("staff_password").value = password;
           	document.getElementById("staff_name").value = name;
           	document.getElementById("staff_tel").value = tel;
           	document.getElementById("staff_age").value = age;
            var select1=document.getElementById("staff_sex");
            for(var i = 0;i<select1.length;i++){      
                var ch=select1[i].value;                                      //循环遍历获取其值
                if(select1[i].value==sex){                                                 //比较select的数值
                    select1[i].selected =true;                                //设置为选中状态
                }
                else
                    select1[i].selected=false;                                   //设置为未选中状态。
            }
            var select2=document.getElementById("staff_store");
            for(var i = 0;i<select2.length;i++){      
                var ch=select2[i].value;                                      //循环遍历获取其值
                if(select2[i].value==store){                                                 //比较select的数值
                    select2[i].selected =true;                                //设置为选中状态
                }
                else
                    select2[i].selected=false;                                   //设置为未选中状态。
            }
            var select3=document.getElementById("staff_position");
            for(var i = 0;i<select3.length;i++){      
                var ch=select3[i].value;                                      //循环遍历获取其值
                if(select3[i].value==position){                                                 //比较select的数值
                    select3[i].selected =true;                                //设置为选中状态
                }
                else
                    select3[i].selected=false;                                   //设置为未选中状态。
            }
            
            document.getElementById("staff_delete").style.display = "inline-block";
            document.getElementById("staff_submit").style.marginLeft="50px";
            document.getElementById("staff_submit").onclick = function(){
            	if(document.getElementById("staff_id").value == ""||
            			document.getElementById("staff_name").value == ""||
            			document.getElementById("staff_password").value == ""||
            			document.getElementById("staff_tel").value == "" ||
                        document.getElementById("staff_age").value == "")
            		alert("信息不完整");
            	else{
                    var sexselect = document.getElementById("staff_sex").selectedIndex;
                    var storeselect = document.getElementById("staff_store").selectedIndex;
                    var positionselect = document.getElementById("staff_position").selectedIndex;
            		$.ajax({
                        //提交数据的类型 POST GET
                        type:"POST",
                        //提交的网址
                        url:"/DessertHouse/StaffServlet",
                        //提交的数据
                        data:{type:"update",
                        	  id:document.getElementById("staff_id").value,
                        	  name:document.getElementById("staff_name").value,
                              password:document.getElementById("staff_password").value,
                              tel:document.getElementById("staff_tel").value,
                              age:document.getElementById("staff_age").value,
                              sex:document.getElementById("staff_sex")[sexselect].value,
                              position:document.getElementById("staff_position")[positionselect].value,
                              store:document.getElementById("staff_store")[storeselect].value
                             },
                        //返回数据的格式
                        datatype: "text",//"xml", "html", "script", "json", "jsonp", "text".
                        success:function(data){
                            if(!data)
                                alert("信息填写有误,修改失败");
                            else{
                                alert("修改成功！");
                                window.location.href="admin.jsp"; 
                                showStaffList();
                            }
                        }
                    });
            	}
            }
         
        }
        function deleteShop(){
        	$.ajax({
                //提交数据的类型 POST GET
                type:"POST",
                //提交的网址
                url:"/DessertHouse/StoreServlet",
                //提交的数据
                data:{type:"delete",
                	  id:document.getElementById("store_id").value
                     },
                //返回数据的格式
                datatype: "text",//"xml", "html", "script", "json", "jsonp", "text".
                success:function(data){
                    if(!data)
                        alert("删除失败");
                    else{
                        alert("删除成功！");
                        window.location.href="admin.jsp"; 
                        showStaffList();
                    }
                }
            });
        }
        function deleteStaff(){
        	$.ajax({
                //提交数据的类型 POST GET
                type:"POST",
                //提交的网址
                url:"/DessertHouse/StaffServlet",
                //提交的数据
                data:{type:"delete",
                	  id:document.getElementById("staff_id").value
                     },
                //返回数据的格式
                datatype: "text",//"xml", "html", "script", "json", "jsonp", "text".
                success:function(data){
                    if(!data)
                        alert("删除失败");
                    else{
                        alert("删除成功！");
                        window.location.href="admin.jsp"; 
                        showStaffList();
                    }
                }
            });
        }
        function addShop(){
            document.getElementById("store_id").value = "";
            document.getElementById("store_id").disabled = false;
         	document.getElementById("store_name").value = "";
         	document.getElementById("store_address").value = "";
         	document.getElementById("store_tel").value = "";
         	document.getElementById("store_delete").style.display = "none";
         	document.getElementById("store").style.visibility = "hidden";
            document.getElementById("store_edit").style.visibility = "";
            
            document.getElementById("store_submit").style.marginLeft = "380px";
            document.getElementById("store_submit").onclick = function(){
            	if(document.getElementById("store_id").value == ""||
            			document.getElementById("store_name").value == ""||
            			document.getElementById("store_address").value == ""||
            			document.getElementById("store_tel").value == "")
            		alert("信息不完整");
            	else{
            		$.ajax({
                        //提交数据的类型 POST GET
                        type:"POST",
                        //提交的网址
                        url:"/DessertHouse/StoreServlet",
                        //提交的数据
                        data:{type:"add",
                        	  id:document.getElementById("store_id").value,
                        	  name:document.getElementById("store_name").value,
                              address:document.getElementById("store_address").value,
                              tel:document.getElementById("store_tel").value
                             },
                        //返回数据的格式
                        datatype: "text",//"xml", "html", "script", "json", "jsonp", "text".
                        success:function(data){
                            if(!data)
                                alert("信息填写有误,添加失败");
                            else{
                                alert("添加成功！");
                                window.location.href="admin.jsp"; 
                            }
                        }
                    });
            	}
            }
        }
        function addStaff(){
            document.getElementById("staff").style.visibility = "hidden";
            document.getElementById("staff_edit").style.visibility = "";
            document.getElementById("staff_delete").style.display = "none";
            
            document.getElementById("staff_id").value = "";
           	document.getElementById("staff_id").disabled = false;
            document.getElementById("staff_password").value = "";
           	document.getElementById("staff_name").value = "";
           	document.getElementById("staff_tel").value = "";
           	document.getElementById("staff_age").value = "";
            document.getElementById("staff_sex")[0].select = true;
            document.getElementById("staff_store")[0].select = true;
            document.getElementById("staff_position")[0].select = true;
            
            document.getElementById("staff_submit").style.marginLeft = "300px";
            document.getElementById("staff_submit").onclick = function(){
            	if(document.getElementById("staff_id").value == ""||
            			document.getElementById("staff_name").value == ""||
            			document.getElementById("staff_password").value == ""||
            			document.getElementById("staff_tel").value == "" ||
                        document.getElementById("staff_age").value == "")
            		alert("信息不完整");
            	else{
                    var sexselect = document.getElementById("staff_sex").selectedIndex;
                    var storeselect = document.getElementById("staff_store").selectedIndex;
                    var positionselect = document.getElementById("staff_position").selectedIndex;
            		$.ajax({
                        //提交数据的类型 POST GET
                        type:"POST",
                        //提交的网址
                        url:"/DessertHouse/StaffServlet",
                        //提交的数据
                        data:{type:"add",
                        	  id:document.getElementById("staff_id").value,
                        	  name:document.getElementById("staff_name").value,
                              password:document.getElementById("staff_password").value,
                              tel:document.getElementById("staff_tel").value,
                              age:document.getElementById("staff_age").value,
                              sex:document.getElementById("staff_sex")[sexselect].value,
                              position:document.getElementById("staff_position")[positionselect].value,
                              store:document.getElementById("staff_store")[storeselect].value
                             },
                        //返回数据的格式
                        datatype: "text",//"xml", "html", "script", "json", "jsonp", "text".
                        success:function(data){
                            if(!data)
                                alert("信息填写有误,添加失败");
                            else{
                                alert("添加成功！");
                                window.location.href="admin.jsp"; 
                                showStaffList();
                            }
                        }
                    });
            	}
            }
        }
    </script>
    
</head>


<body>

	<div>
        <div id="indexmenu" style="padding-top:50px;">
               <a href="#" class="btn btn-2" onclick="showShopList()">店铺管理</a> 
               <a href="#" class="btn btn-2" onclick="showStaffList()">店员管理</a>
        </div>
        
        <div class="right-container" id="store" style="visibility:">
            <h1>店铺管理</h1>
            
            <table id="cart_table" cellspacing="0">
                <thead id="table_head">
                    <tr>
                        <th style="height:44px;">
                            <p>店铺编号</p>
                        </th>
                        <th style="height:44px;">
                            <p>店名</p>
                        </th>
                        <th style="height:44px;">
                            <p>店铺地址</p>
                        </th>
                        <th style="height:44px;">
                            <p>电话</p>
                        </th>
                        <th style="height:44px;">
                            <p>操作</p>
                        </th>
                        
                    </tr>
                </thead>
                <tbody id="userGroups" class="tbody">
                <%
                int storeNum = StoreList.getStoreList().size();
                int storePages = storeNum/10 +1;
                int storeIndex = 10;
                if(storePages==1)
                	storeIndex = storeNum;
                for(int i=0;i<storeIndex;i++){
                	pageContext.setAttribute("storeitem", StoreList.getStore(i));
      
                %>
                    <tr>
                        <td class="table_cell admin" style="width:15%;">
                            <p class="sys-ch"><jsp:getProperty name="storeitem" property="id" /></p>
                        </td>
                        <td class="table_cell admin" style="width:15%;">
                           <p class="sys-ch"><jsp:getProperty name="storeitem" property="name" /></p>
                        </td>
                        <td class="table_cell admin" style="width:40%;">
                           <p class="sys-ch"><jsp:getProperty name="storeitem" property="address" /></p>
                        </td>
                        <td class="table_cell admin" style="width:20%;">
                           <p class="sys-ch"><jsp:getProperty name="storeitem" property="tel" /></p>
                        </td>
                        <td class="table_cell action">
                            <a href="#" class="sys-ch" onclick="showShopEdit('<%=StoreList.getStore(i).getId()%>','<%=StoreList.getStore(i).getName()%>','<%=StoreList.getStore(i).getAddress()%>','<%=StoreList.getStore(i).getTel()%>')">编辑</a>
                        </td>
                        
                    </tr>
                <%} %>
                
                </tbody>
            </table>
            <a class="getMore" href="#" onclick="addShop()" style="float:left;top:20px;width:150px;">+&nbsp;&nbsp;&nbsp;新增店铺</a>
           
            <%if(storePages>1){ %>
            <div class="page fr">
      			<%for(int j=1;j<=storePages;j++){ %>
                <a id=<%="page"+Integer.toString(j) %> class="a2" href="javascript:void();" onclick=""><%=j %></a>
                <%} %>
                <a id="nextpage" class="turing" href="javascript:void();" onclick="setList(2)">下一页</a>
            </div>
            <%} %>
        </div>
        
        <div class="right-container" id="store_edit" style="visibility:hidden;">
        <div>
            <a class="backBtn" href="#" onclick="showShopList()">
                <div style="width:150px;height:50px;">
                    <div class="left-arrow"></div>
                    <span class="sys-ch" style="font-size:20px;padding-left:15px;top:5px;">返回</span>
                </div>
            </a>
            
            <ul class="lalala">
                <li>
                    <span class="sys-ch">店铺编号：</span>
                    <input id="store_id" style="width:300px;height:30px;">
                </li>
                <li>
                    <span class="sys-ch">店铺名称：</span>
                    <input id="store_name" style="width:300px;height:30px;">
                </li>
                <li>
                    <span class="sys-ch">店铺地址：</span>
                    <input id="store_address" style="width:300px;height:30px;">
                </li>
                <li>
                    <span class="sys-ch">店铺电话：</span>
                    <input id="store_tel" style="width:300px;height:30px;">
                </li>
                
            </ul>
            
            <a class="ghbutton gray" id="store_delete" href="#" onclick="deleteShop()" style="margin-top:50px;margin-left:280px;width:100px;height:40px;font-size:16px;">删除</a>
            <a class="ghbutton pink" id="store_submit" href="#" onclick="" style="margin-top:20px;margin-left:50px;width:100px;height:40px;font-size:16px;">确认</a>
            
        </div>    
        </div>
        
        <div class="right-container" id="staff" style="visibility:hidden">
            <h1>店员管理</h1>
            
            <table id="cart_table" cellspacing="0">
                <thead id="table_head">
                    <tr>
                        <th style="height:44px;">
                            <p>员工号</p>
                        </th>
                        <th style="height:44px;">
                            <p>姓名</p>
                        </th>
                        <th style="height:44px;">
                            <p>联系电话</p>
                        </th>
                        <th style="height:44px;">
                            <p>性别</p>
                        </th>
                        <th style="height:44px;">
                            <p>年龄</p>
                        </th>
                        <th style="height:44px;">
                            <p>所属店铺</p>
                        </th>
                        <th style="height:44px;">
                            <p>职位</p>
                        </th>
                        <th style="height:44px;">
                            <p>操作</p>
                        </th>
                        
                    </tr>
                </thead>
                <tbody id="userGroups" class="tbody">
                	<%
	                int staffNum = StaffList.getStaffList().size();
	                int staffPages = staffNum/10 +1;
	                int staffIndex = 10;
	                if(staffPages==1)
	                	staffIndex = staffNum;
	                for(int i=0;i<staffIndex;i++){
	                	pageContext.setAttribute("staffitem", StaffList.getStaff(i));
	                %>
                    <tr>
                        <td class="table_cell admin" style="width:10%;">
                            <p class="sys-ch"><jsp:getProperty name="staffitem" property="id" /></p>
                        </td>
                        <td class="table_cell admin" style="width:15%;">
                            <p class="sys-ch"><jsp:getProperty name="staffitem" property="name" /></p>
                        </td>
                        <td class="table_cell admin" style="width:15%;">
                           <p class="sys-ch"><jsp:getProperty name="staffitem" property="tel" /></p>
                        </td>
                        <td class="table_cell admin" style="width:10%;">
                           <p class="sys-ch">
                           <%if(StaffList.getStaff(i).getSex().equals("male")){ %>
                           		男
                           <%}else{ %>
                           		女
                           		<%} %>
                           </p>
                        </td>
                        <td class="table_cell admin" style="width:10%;">
                           <p class="sys-ch"><jsp:getProperty name="staffitem" property="age" /></p>
                        </td>
                        <td class="table_cell admin" style="width:10%;">
                           <p class="sys-ch"><jsp:getProperty name="staffitem" property="storeId" /></p>
                        </td>
                        <td class="table_cell admin" style="width:15%;">
                           <p class="sys-ch">
                           <%if(StaffList.getStaff(i).getPosition().equals("saler")){ %>
                           		售货员
                           <%}else if(StaffList.getStaff(i).getPosition().equals("planner")){%>
                           		总店服务员
                           <%}else if(StaffList.getStaff(i).getPosition().equals("manager")){%>
                      			总经理
                      	   <%} %>
                           </p>
                        </td>
                        <td class="table_cell action">
                            <a href="#" onclick="showStaffEdit('<%=StaffList.getStaff(i).getId() %>','<%=StaffList.getStaff(i).getPassword() %>','<%=StaffList.getStaff(i).getName() %>','<%=StaffList.getStaff(i).getTel() %>','<%=StaffList.getStaff(i).getAge() %>','<%=StaffList.getStaff(i).getStoreId() %>','<%=StaffList.getStaff(i).getSex() %>','<%=StaffList.getStaff(i).getPosition() %>')" class="sys-ch">编辑</a>
                        </td>
                    </tr>
                   <%} %>
                </tbody>
            </table>
            
            <a class="getMore" href="#" onclick="addStaff()" style="float:left;top:20px;width:150px;">+&nbsp;&nbsp;&nbsp;新增员工</a>
            <%if(staffPages>1){ %>
            <div class="page fr">
      			<%for(int j=1;j<=staffPages;j++){ %>
                <a id=<%="page"+Integer.toString(j) %> class="a2" href="javascript:void();" onclick=""><%=j %></a>
                <%} %>
                <a id="nextpage" class="turing" href="javascript:void();" onclick="setList(2)">下一页</a>
            </div>
            <%} %>
            
        </div>
        
        <div class="right-container" id="staff_edit" style="visibility:hidden;">
        
            <a class="backBtn" href="#" onclick="showStaffList()">
                <div style="width:150px;height:50px;">
                    <div class="left-arrow"></div>
                    <span class="sys-ch" style="font-size:20px;padding-left:15px;top:5px;">返回</span>
                </div>
            </a>
            
            <ul class="lalala">
                <li>
                    <span class="sys-ch">员工编号：</span>
                    <input id="staff_id" style="width:300px;height:30px;">
                </li>
                <li>
                    <span class="sys-ch" style="margin-left:31px;">密码：</span>
                    <input id="staff_password" style="width:300px;height:30px;">
                </li>
                <li>
                    <span class="sys-ch" style="margin-left:31px;">姓名：</span>
                    <input id="staff_name" style="width:300px;height:30px;">
                </li>
                <li>
                    <span class="sys-ch">联系电话：</span>
                    <input id="staff_tel" style="width:300px;height:30px;">
                </li>
                <li>
                    <span class="sys-ch" style="margin-left:31px;">性别：</span>
                    <select id="staff_sex" style="width:150px;height:30px;">
                          <option value ="male">男</option>
                          <option value ="female">女</option>
                    </select>
                </li>
                <li>
                    <span class="sys-ch" style="margin-left:31px;">年龄：</span>
                    <input id="staff_age" style="width:150px;height:30px;">
                </li>
                <li>
                    <span class="sys-ch">所属店铺：</span>
                    <select id="staff_store" style="width:150px;height:30px;">
                    <%for(int i=0;i<storeNum;i++){ %>
                          <option value ="<%= StoreList.getStore(i).getId() %>"><%= StoreList.getStore(i).getName()%></option>
                    <%} %>
                    </select>
                </li>
                <li>
                    <span class="sys-ch" style="margin-left:31px;">职位：</span>
                    <select id="staff_position" style="width:150px;height:30px;">
                          <option value ="saler">销售员</option>
                          <option value ="planner">总店服务员</option>
                    </select>
                </li>
                
            </ul>
            
            <a class="ghbutton gray" id="staff_delete" href="#" onclick="deleteStaff()" style=" margin-left: 260px;width:100px;height:40px;font-size:16px;">删除</a>
            <a class="ghbutton pink" id="staff_submit" href="#" onclick="" style="margin-top:20px;margin-left:70px;width:100px;height:40px;font-size:16px;">确认</a>
            
        </div>
        
        
    </div>
</body>


</html>