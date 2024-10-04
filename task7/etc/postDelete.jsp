<%@ page language ="java" contentType = "text/html" pageEncoding ="utf-8" %>

<%-- Conenector 파일을 찾아오는 라이브러리 여기서는 마리아디비 찾아옴 --%> 
<%@ page import="java.sql.DriverManager" %>
<%-- DB에 연결하는 라이브러리 --%>
<%@ page import="java.sql.Connection" %>
<%-- SQL을 만들어주는 라이브러리 --%>
<%@ page import="java.sql.PreparedStatement" %>
<%-- 데이터베이스로부터 오는 값을 받아주는 라이브러리 --%>
<%@ page import="java.sql.ResultSet" %> 
<%-- 세션사용을 가능하게 해주는 라이브러리 --%>
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