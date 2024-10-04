<%@ page language = "java" contentType = "text/html" pageEncoding ="utf-8"%>
<%@ page import = "java.sql.DriverManager"%>
<%@ page import = "java.sql.Connection"%>
<%@ page import = "java.sql.PreparedStatement"%>
<%@ page import = "java.sql.ResultSet"%>
<%@ page session = "true" %>

<%
    request.setCharacterEncoding("utf-8");

    String loginId = (String)session.getAttribute("user_id");
    String userId ="";
    String userPw = "";
    String userName = "";
    String userGender = "";
    String userBirthday = "";
    String userPhone = "";
    String userEmail = "";
    String userAddress = "";

    Class.forName("org.mariadb.jdbc.Driver");

    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bulletin_board","GB","6105");

    String sql = "SELECT * FROM user WHERE id = ?";
    
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1,loginId);

    ResultSet result = query.executeQuery();


    if(result.next()){
        userId = result.getString("id");
        userPw = result.getString("password");
        userName = result.getString("name");
        userGender = result.getString("gender");
        userBirthday = result.getString("birthday");
        userPhone = result.getString("phone_number");
        userEmail = result.getString("email");
        userAddress = result.getString("address");
    }
%>

<%-- HTML 구현 부분 --%>

<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" type = "text/css" href = "/task7/css/account/accountMenu.css">
    
</head>
<body>
    <h1 id = "title">회원 정보 수정하기</h1>
    <form action ="/task7/jsp/account/accountFixAction.jsp" method ="post" >

        <!-- 아이디 입력받기(두 글자 이상, 영어(대소문자)&숫자로만 가능) -->
        <input class = "container" id = "idContainer" type = "text" name = 'id' value = "<%=userId%>" minlength = "2" pattern ="[a-zA-Z0-9]*" required disabled>
        <!-- 비밀번호 입력받기(8~16글자 제한, 영어(대소문자)&숫자로만 가능) -->
        <input class = "container" id = "pwContainer" type = "password" name = 'pw' placeholder = 'password (8~16 letters)' minlength = "8" maxlength="16" pattern ="[a-zA-Z0-9]*" required >
        <!-- 이메일 입력받기 -->
        <div class = "container" id = "emailContainer">
            <input id = "emailInputContainer" type = "text" name = 'email_address' placeholder = 'email_address' pattern ="[a-zA-Z0-9]*" required >@
            <select name = "domain" id = "domainList" required>
                <option value = "">choose email</option>
                <option value = "@naver.com">naver.com</option>
                <option value = "@gmail.com">gmail.com</option>
            </select>
        </div>



        <!-- 이름 입력받기(영어(대소문자),한글로만 가능) -->
        <div class = "container" id = "nameContainer">
            <input type = "text" name ='firstName' id = "firstName" placeholder = 'firstName' pattern = "[ㄱ-ㅎ가-힣a-zA-Z]*"required>
            <input type = "text" name ='lastName' id = "lastName" placeholder = 'lastName' pattern = "[ㄱ-ㅎ가-힣a-zA-Z]*"required>
        </div>
        
        <!-- <input type = "type" placeholder = ' age' > 이거 생년월일로 갈아치우는게 훨씬 나을듯 -->
        
        <!-- 생일 입력 받기 -->
        <div class = "container" id = "brithdayContainer">
            <div>Birth: <%=userBirthday%></div>
        </div>
        <!-- 성별 선택받기 -->
        <div class = "container" id = "genderContainer">
            <div>Gender: <%=userGender%></div>
        </div>

        <!-- <input type ="date" min = "1924-01-01" max = "2023-12-31" name ="birthday" step ="7"> -->

        <!-- 전화번호 입력받기 -->
        <input class = "container" type = "tel" name = 'phone_number' placeholder = 'phone_number (010-0000-0000)' pattern ="(010)-[0-9]{3,4}-[0-9]{4}"required>
        
        <input class = "container" type = "text" name ='address' placeholder = 'address' pattern = "[A-Z][a-z]*" required >

        <button id = "confirmButton" type = "submit">수정 하기</button>
    </form>
        
    <script>
        for(var i = 1954; i<=2024; i++){
            const yearOption = document.createElement('option')
            yearOption.setAttribute('value',i)
            yearOption.innerText =i

            document.getElementById('birth_year').appendChild(yearOption)
        }
        for(var i = 1; i<=12; i++){
            const monthOption = document.createElement('option');
            monthOption.setAttribute('value',i);            
            monthOption.innerText = i.toString().padStart(2,'0');

            document.getElementById('birth_month').appendChild(monthOption)
        }
        for(var i = 1; i<=31; i++){
            const dayOption = document.createElement('option');
            dayOption.setAttribute('value',i);            
            dayOption.innerText = i.toString().padStart(2,'0');

            document.getElementById('birth_day').appendChild(dayOption)
        }
        
    </script>
</body>
</html>