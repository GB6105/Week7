<%@ page language = "java" contentType = "text/html" pageEncoding ="utf-8"%>
<%@ page import = "java.sql.DriverManager"%>
<%@ page import = "java.sql.Connection"%>
<%@ page import = "java.sql.PreparedStatement"%>
<%@ page import = "java.sql.ResultSet"%>
<%@ page session = "true" %>

<%-- 백엔드 통신 --%>
<%
    request.setCharacterEncoding("utf-8");
    String loginId = (String)session.getAttribute("user_id");
    String currentPostIdx = (String)session.getAttribute("currentPostIdx");

    String titleValue = request.getParameter("postTitle");
    String categoryValue = request.getParameter("category");
    String contentValue = request.getParameter("postContent");

    Class.forName("org.mariadb.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bulletin_board","GB","6105");

    // //SQL 작성
    String sql ="UPDATE post SET title = ?, category_name = ?, content = ? WHERE idx = ?"; // 
    
    //sql 전송준비상태로 만들기
    PreparedStatement query = connect.prepareStatement(sql);//전송 준비중인 sql

    query.setString(1,titleValue);
    query.setString(2,categoryValue);
    query.setString(3,contentValue);
    query.setString(4,currentPostIdx);

    //Quer 전송
    query.executeUpdate();
%>

<%-- 프론트 엔드 레이아웃 (위 데이터를 사용한) --%>

<script>
    alert("작성을 완료하였습니다.")
    location.href ="/task7/jsp/post/postViewPage.jsp?idx="+"<%=currentPostIdx%>";
</script>

<%-- jsp 에서 프론트엔드로 넘어오는 값은 자료형이 무시된채로 넘어온다. 큰따옴표를 붙여줘야한다.--%>