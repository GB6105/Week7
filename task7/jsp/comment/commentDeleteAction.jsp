<%@ page language ="java" contentType = "text/html" pageEncoding ="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %> 
<%@ page session = "true" %>

<%
    request.setCharacterEncoding("utf-8");
    String loginId = (String)session.getAttribute("user_id");
    String currentPostIdx = (String)session.getAttribute("currentPostIdx");
    String commentIdxValue = request.getParameter("comment_idx");
    Class.forName("org.mariadb.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bulletin_board","GB","6105");
    String sql = "DELETE FROM comment WHERE idx = ?";
    
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1,commentIdxValue);

    query.executeUpdate();
%>

<script>
    alert("댓글이 삭제되었습니다.")
    location.href ="/task7/jsp/post/postViewPage.jsp?idx="+"<%=currentPostIdx%>";

</script>