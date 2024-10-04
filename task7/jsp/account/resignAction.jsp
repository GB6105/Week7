<%@ page language ="java" contentType = "text/html" pageEncoding ="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %> 
<%@ page session = "true" %>

<%
    String login_id = (String)session.getAttribute("user_id");
    Class.forName("org.mariadb.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bulletin_board","GB","6105");
    String sql = "DELETE FROM user WHERE id = ?";
    
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1,login_id);

    query.executeUpdate();
%>

<script>
    console.log("<%=login_id%>")
    alert("회원 탈퇴가 완료되었습니다.")
    location.href = "/task7/index.html"

</script>