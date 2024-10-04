<%@ page language ="java" contentType = "text/html" pageEncoding ="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>

<%-- 백엔드 통신 --%>
<%
    request.setCharacterEncoding("utf-8"); //받아온 값에 대한 인코딩 설정 안하면 유니코드 된다)
    String idValue = request.getParameter("id");  ///request는 이전 페이지를 의미함
    String pwValue = request.getParameter("pw");
    String nameValue = request.getParameter("name");
    String genderValue = request.getParameter("gender");

    String yearValue = request.getParameter("year");
    String monthValue = request.getParameter("month");
    String dayValue = request.getParameter("day");
    String birthdayValue = yearValue + "-"+ monthValue + "-"+dayValue;

    String phoneValue = request.getParameter("phone_number");

    String emailValue = request.getParameter("email_address");
    String domainValue = request.getParameter("domain");
    String emailAddressValue = emailValue + domainValue;
    
    String addressValue = request.getParameter("address");
    
    //DB 찾아오기
    Class.forName("org.mariadb.jdbc.Driver"); //이게 오류나면 db가 설치가 안됫거나, 꺼져있거나 커넥터파일이 잘못됫거나
    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bulletin_board","GB","6105"); //db에 연결하는 부분

    String sql ="INSERT INTO user (id, password,name,gender,birthday,phone_number,email,address) VALUES (?,?,?,?,?,?,?,?)"; // 

    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1,idValue);
    query.setString(2,pwValue);
    query.setString(3,nameValue);
    query.setString(4,genderValue);
    query.setString(5,birthdayValue);
    query.setString(6,phoneValue);
    query.setString(7,emailAddressValue);
    query.setString(8,addressValue);

    query.executeUpdate();
%>

<%-- 프론트 엔드 레이아웃 (위 데이터를 사용한) --%>

<script>
    console.log("<%=idValue%>")
    console.log("<%=pwValue%>") 
    console.log("<%=nameValue%>")
    console.log("<%=genderValue%>")
    console.log("<%=birthdayValue%>")
    console.log("<%=phoneValue%>")
    console.log("<%=nameValue%>")
    console.log("<%=emailValue%>")
    console.log("<%=addressValue%>")
    alert("회원가입이 성공하였습니다!,로그인하여 주세요")
    location.href ="/task7/index.html"
</script>
