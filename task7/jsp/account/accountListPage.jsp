<%@ page language = "java" contentType = "text/html" pageEncoding = "utf-8" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%
    Class.forName("org.mariadb.jdbc.Driver");

    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/web","GB","6105");
    String sql = "SELECT * FROM account";
    PreparedStatement query = connect.prepareStatement(sql);

    ResultSet result = query.executeQuery();
    
%>

<!-- page 구현 부분 -->
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