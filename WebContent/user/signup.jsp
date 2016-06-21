<%@page import="desserthouse.logic.UserManager"%>
<%@page import="desserthouse.logic.impl.UserManagerImpl"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>用户注册</title>

	<!-- Stylesheets -->
	<link rel="stylesheet" href="../css/area.css">
	<link rel="stylesheet" href="../css/button.css">
	<link rel="stylesheet" href="../css/font.css">
	<link rel="stylesheet" href="../css/input.css">
	
	<style>
        body{
            background-color: #F1D0C5;
        }
        a {
            color: #fff;
            text-decoration: none;
        }
    </style>
    <script src="../js/jquery.min.js"></script>
    <script type="text/javascript">
		function register(){
			if(document.getElementById("password").value=="")
				alert("请填写密码");
			else if(document.getElementById("card").value=="")
				alert("请填写付款卡号");
			else if(document.getElementById("password").value!=document.getElementById("password2").value)
				alert("两次密码输入不一致");
			else{
                $.ajax({
                    //提交数据的类型 POST GET
                    type:"POST",
                    //提交的网址
                    url:"/DessertHouse/RegisterServlet",
                    //提交的数据
                    data:{password:document.getElementById("password").value,
                          tel:document.getElementById("tel").value,address:document.getElementById("address").value,
                          card:document.getElementById("card").value,id:document.getElementById("userid").innerHTML
                         },
                    //返回数据的格式
                    datatype: "text",//"xml", "html", "script", "json", "jsonp", "text".
                    success:function(data){
                        if(!data)
                            alert("信息填写有误");
                        else{
                            alert("注册成功！");
                            location.href="login.jsp";
                        }
                    }
                });
			}
		}
	</script>
    
</head>

<body>
	<%
	UserManager uc =new UserManagerImpl();
	String userid = uc.getUserNum();  
	%>
    <div style="top:20px;font-family:Lucida Console;font-size: 2em;width:auto">
        <h5 style="margin-left:3%;color:#B20837">Welcome! Member <span id="userid"><%=userid %></span>. </h5>
        <h6 style="margin-left:3%;color:#B20837">Please fill in the blank to register. </h6>
        
        <span class="input input--hoshi">
            <input class="input__field input__field--hoshi" type="password" id="password" />
            <label class="input__label input__label--hoshi input__label--hoshi-color-1" >
                <span class="input__label-content input__label-content--hoshi">Password*</span>
            </label>
        </span>
        <span class="input input--hoshi">
            <input class="input__field input__field--hoshi" type="password" id="password2" />
            <label class="input__label input__label--hoshi input__label--hoshi-color-1" >
                <span class="input__label-content input__label-content--hoshi">Password Again*</span>
            </label>
        </span>
        
        <span class="input input--hoshi">
            <input class="input__field input__field--hoshi" type="text" id="tel" />
            <label class="input__label input__label--hoshi input__label--hoshi-color-1" >
                <span class="input__label-content input__label-content--hoshi">Tel</span>
            </label>
        </span>
        
        <span class="input input--hoshi">
            <input class="input__field input__field--hoshi" type="text" id="address" />
            <label class="input__label input__label--hoshi input__label--hoshi-color-1" >
                <span class="input__label-content input__label-content--hoshi">Address</span>
            </label>
        </span>
        
        <span class="input input--hoshi">
            <input class="input__field input__field--hoshi" type="text" id="card" />
            <label class="input__label input__label--hoshi input__label--hoshi-color-1" >
                <span class="input__label-content input__label-content--hoshi">Bank Card*</span>
            </label>
        </span>
        
        <div onclick="register()" class="sim-button button10" style="float:right;right:33%"><span style="font-size:18px;color:#B20837">Register</span></div>
        
    </div>
    <script src="../js/classie.js"></script>
    <script>
        (function() {
            // trim polyfill : https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/Trim
            if (!String.prototype.trim) {
                (function() {
                    // Make sure we trim BOM and NBSP
                    var rtrim = /^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g;
                    String.prototype.trim = function() {
                        return this.replace(rtrim, '');
                    };
                })();
            }

            [].slice.call( document.querySelectorAll( 'input.input__field' ) ).forEach( function( inputEl ) {
                // in case the input is already filled..
                if( inputEl.value.trim() !== '' ) {
                    classie.add( inputEl.parentNode, 'input--filled' );
                }

                // events:
                inputEl.addEventListener( 'focus', onInputFocus );
                inputEl.addEventListener( 'blur', onInputBlur );
            } );

            function onInputFocus( ev ) {
                classie.add( ev.target.parentNode, 'input--filled' );
            }

            function onInputBlur( ev ) {
                if( ev.target.value.trim() === '' ) {
                    classie.remove( ev.target.parentNode, 'input--filled' );
                }
            }
        })();
    </script>
</body>


</html>