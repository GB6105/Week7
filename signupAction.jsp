<%@ page language ="java" contentType = "text/html" pageEncoding ="utf-8" %>

<%-- Conenector 파일을 찾아오는 라이브러리 여기서는 마리아디비 찾아옴 --%> 
<%@ page import="java.sql.DriverManager" %>
<%-- DB에 연결하는 라이브러리 --%>
<%@ page import="java.sql.Connection" %>
<%-- SQL을 만들어주는 라이브러리 --%>
<%@ page import="java.sql.PreparedStatement" %>

<%-- 백엔드 통신 --%>
<%
     //jsp 문법을 적을 수 있는 공간

    request.setCharacterEncoding("utf-8"); //받아온 값에 대한 인코딩 설정 안하면 유니코드 된다)
    String idValue = request.getParameter("id");  ///request는 이전 페이지를 의미함
    String pwValue = request.getParameter("pw");
    //DB 찾아오기
    Class.forName("org.mariadb.jdbc.Driver"); //이게 오류나면 db가 설치가 안됫거나, 꺼져있거나 커넥터파일이 잘못됫거나
    
    //DB 통신 연결
    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/web","GB","6105"); //db에 연결하는 부분
    // 데이터베이스 서버가 따로 있을 경우 ip주소를 loclahost 위치에 적어줘야함

    //SQL 작성 
    String sql ="INSERT INTO account (id, pw) VALUES (?,?)"; // 
    
    //sql 전송준비상태로 만들기
    PreparedStatement query = connect.prepareStatement(sql);//전송 준비중인 sql
    query.setString(1,idValue);
    query.setString(2,pwValue);

    //Quer 전송
    query.executeUpdate();
%>

<%-- 프론트 엔드 레이아웃 (위 데이터를 사용한) --%>

<script>
    console.log("<%=idValue%>") // 그냥 변수이름 쓰면 자바스크립트 변수 찾음 
    console.log("<%=pwValue%>") // 값이 적용되면 개발자 도구에 보여짐

    alert("회원가입이 성공하였습니다!")
    location.href ="index.html"
</script>

<%-- jsp 에서 프론트엔드로 넘어오는 값은 자료형이 무시된채로 넘어온다. 큰따옴표를 붙여줘야한다.--%>