<%@ page language ="java" contentType = "text/html" pageEncoding ="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %> 

<%
    request.setCharacterEncoding("utf-8");
    String nameValue = request.getParameter("name");
    String idValue = request.getParameter("id");
    String birthdayValue = request.getParameter("birthday");
    String phoneValue = request.getParameter("phone_number");

    Class.forName("org.mariadb.jdbc.Driver");

    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bulletin_board","GB","6105");

    String sql = "SELECT password FROM user WHERE name = ? AND id = ? AND birthday = ? AND phone_number = ?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1,nameValue);
    query.setString(2,idValue);
    query.setString(3,birthdayValue);
    query.setString(4,phoneValue);

    ResultSet result= query.executeQuery();
    String find_password = "";
    if(result.next()){
        find_password = result.getString("password");
    }

%>

<script>
    if("<%=find_password%>"){
        console.log("<%=find_password%>")
        alert("회원님의 비밀번호는 " + "<%=find_password%>" + "입니다.")
        location.href = "/task7/index.html"
    }else{
        alert("입력하신 정보에 해당하는 비밀번호를 찾을 수 없습니다.\n 다시 시도해보세요")
        location.href = "/task7/html/account/findPwPage.html"
    }
    
</script>
