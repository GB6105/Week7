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

<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel = "stylesheet" type ="text/css" href = "/task7/css/account/myPage.css">

    <title>Document</title>

</head>
<body>
    <h1 id ="title">My account</h1>
    <article id = "infoContainer">
        <div>Name: <%=userName%></div>
        <div>Id: <%=userId%></div>
        <div>Pw: <%=userPw%></div>
        <div>Gender: <%=userGender%></div>
        <div>Birth: <%=userBirthday%></div>
        <div>Phone: <%=userPhone%></div>
        <div>Email: <%=userEmail%></div>
        <div>Address: <%=userAddress%></div>    

        <div id = "accountOption">
            <button onclick ="window.open('/task7/jsp/account/accountFixPage.jsp')">정보 수정하기</button>
            <button onclick ="checkResign()">회원 탈퇴</button>
        </div>

        <div id ="linkContainor">
            <button onclick ="window.open('postListUpPage.jsp')">내 게시글 보기</button>
            <button onclick ="window.open('comment.html')">내 댓글 보기</button>
        </div>
    </article>

    <script>
        function checkResign(){
            var checked = confirm("정말로 탈퇴하시겠습니까?");
            if(checked == true){
                location.href = '/task7/jsp/account/resignAction.jsp';
            }
        }
    </script>

</body>
</html>