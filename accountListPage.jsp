<%@ page language ="java" contentType = "text/html" pageEncoding ="utf-8" %>

<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%-- 데이터베이스로부터 오는 값을 받아주는 라이브러리 --%>
<%@ page import="java.sql.ResultSet" %> 

<%
    Class.forName("org.mariadb.jdbc.Driver"); //이게 오류나면 db가 설치가 안됫거나, 꺼져있거나 커넥터파일이 잘못됫거나
    
    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/web","GB","6105"); //db에 연결하는 부분

    String sql ="SELECT * FROM account"; // 
    
    PreparedStatement query = connect.prepareStatement(sql);//전송 준비중인 sql

    //셀렉트인 경우 query 변화
    ResultSet result = query.executeQuery();
    //받아온 값은 table일 것임
    //가장 첫번째 로우 컬럼의 값에 커서가 있음
    // 커서가 한줄이동 -> 읽음
    // 또 한줄 이동 -> 읽음
    // 반복문과 함께 써줌

    // result.next() // 커서를 한줄 이동 시킴
    // result.getString("id")
    // result.getString("pw")
    // result.next() // 그 다음줄
    // result.getString("id")
    // result.getString("pw")


    // while(result.next()){ // 다읽으면 result.next가 불가해짐 
    //     result.getString("id")
    //     result.getString("pw")


    // }

%>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>

<% while(result.next()) { %>
    
    <div>
        <span><%=result.getString("id")%></span>
        <span><%=result.getString("pw")%></span>

    </div>
<% } %>


</body>