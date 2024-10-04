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


<!-- 백엔드 통신 부분 -->
<%
    request.setCharacterEncoding("utf-8");
    //id pw 가져오기
    String idValue = request.getParameter("id_value");
    String pwValue = request.getParameter("pw_value");

    //DB 연결하기
    Class.forName("org.mariadb.jdbc.Driver");
    //DB 통신 연결 // 내 DB 중에서 게시판 DB를 연결
    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bulletin_board","GB","6105");
   
    //sql문 작성 및 전송
    String sql = "SELECT password FROM user WHERE id = ?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, idValue);

    //받아온 pw를 저장 (앞으로 값비교에 사용)
    ResultSet result_password = query.executeQuery();
    String extracted_password ="";
    if(result_password.next()){
        extracted_password = result_password.getString("password");
    }

    if(extracted_password.equals(pwValue)){//자바에서 ==는 객체를 비교, equls가 값을 비교
        session.setAttribute("user_id", idValue); //세션에 id를 저장
    }

    String from_id = (String)session.getAttribute("user_id");

%>


<script>

    console.log("<%=idValue%>")
    console.log("<%=pwValue%>")
    console.log("<%=extracted_password%>")
    console.log("<%=from_id%>")

    if("<%=extracted_password%>" == "<%=pwValue%>"){
        alert("로그인에 성공하였습니다!")
        location.href = "/task7/html/main.html"

    }else{
        alert("ID와 PW를 확인해주세요!")
        location.href = "/task7/index.html"
    }

</script>