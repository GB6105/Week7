<%@ page language ="java" contentType = "text/html" pageEncoding ="utf-8" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %> 

<%
    request.setCharacterEncoding("utf-8");
    String nameValue = request.getParameter("name");
    String birthdayValue = request.getParameter("birthday");
    String phoneValue = request.getParameter("phone_number");

    Class.forName("org.mariadb.jdbc.Driver");

    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bulletin_board","GB","6105");

    String sql = "SELECT id FROM user WHERE name =? AND birthday =? AND phone_number =?";
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1,nameValue);
    query.setString(2,birthdayValue);
    query.setString(3,phoneValue);

    ResultSet result= query.executeQuery();
    String find_id = "";
    if(result.next()){
        find_id = result.getString("id");
    }

%>

<script>
    if("<%=find_id%>"){
        console.log("<%=find_id%>")
        alert("회원님의 id는 " + "<%=find_id%>" + "입니다.")
        location.href = "/task7/index.html"
    }else{
        alert("입력하신 정보에 해당하는 id를 찾을 수 없습니다.\n 회원가입을 진행해주세요")
        location.href = "/task7/html/account/findIdPage.html"
    }
    
</script>
