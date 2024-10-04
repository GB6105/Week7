<%@ page language ="java" contentType = "text/html" pageEncoding ="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %> 
<%@ page session = "true" %>

<%
    request.setCharacterEncoding("utf-8");
    String login_id = (String)session.getAttribute("user_id");
    String currentPostIdx = (String)session.getAttribute("currentPostIdx");
    Class.forName("org.mariadb.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bulletin_board","GB","6105");
    String sql = "DELETE FROM post WHERE idx = ?";
    
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1,currentPostIdx);

    query.executeUpdate();
%>

<script>
    alert("게시글이 삭제되었습니다.")
    location.href = "/task7/jsp/post/postListUpPage.jsp"

</script>