<%@ page language = "java" contentType = "text/html" pageEncoding ="utf-8"%>
<%@ page import = "java.sql.DriverManager"%>
<%@ page import = "java.sql.Connection"%>
<%@ page import = "java.sql.PreparedStatement"%>
<%@ page import = "java.sql.ResultSet"%>
<%@ page session = "true" %>

<%
    // String loginId = (String)session.getAttribute("user_id");
    // session.removeAttribute(loginId);
    String loginId = (String)session.getAttribute("user_id");

    HttpSession session = request.getSession();
    session.removeAttribute(loginId);
%>

<script>

    console.log("<%=loginId%>")
    console.log("<%=afterlogin_id%>")
    alert("로그아웃 되었습니다.")
    <%-- location.href ="/task7/index.html" --%>
</script>