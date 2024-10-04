<%@ page language = "java" contentType = "text/html" pageEncoding ="utf-8"%>
<%@ page import = "java.sql.DriverManager"%>
<%@ page import = "java.sql.Connection"%>
<%@ page import = "java.sql.PreparedStatement"%>
<%@ page import = "java.sql.ResultSet"%>
<%@ page session = "true" %>

<%
    request.setCharacterEncoding("utf-8");

    String loginId = (String)session.getAttribute("user_id");

    Class.forName("org.mariadb.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bulletin_board","GB","6105");

    String sql = "SELECT * FROM post ORDER BY create_at  LIMIT 8";

    PreparedStatement query = connect.prepareStatement(sql);

    ResultSet postListResult = query.executeQuery();

%>

<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel = "stylesheet" type ="text/css" href = "/task7/css/post/post.css">
    <link rel = "stylesheet" type ="text/css" href = "/task7/css/post/postListUp.css">
    <title>Document</title>
</head>
<body>
    <h1 id = "title">게시글</h1>
    <table>
        <thead>
            <tr id ="tableHead">
                <td  id = "idx">번호</td>
                <td  id = "category">카테고리</td>
                <td  id = "postTitle" style = "text-align:center">제목</td>
                <td  id = "writerId" >작성자</td>
                <td  id = "viewCount">조회수</td>
                <td  id = "createDate">작성일</td>
            </tr>
        </thead>
        <tbody>
            <% while(postListResult.next()){
                String postIndex = postListResult.getString("idx");
                String postCategory = postListResult.getString("category_name");
                String postTitle = postListResult.getString("title");
                String postWriterId = postListResult.getString("user_id");
                String postViewCount = postListResult.getString("view");
                String postCreatedDate = postListResult.getString("create_at");
            %>
                <tr>
                    <td id = "idx" name = "idx"><%=postIndex%></td>
                    <td id = "category"> <%=postCategory%> </td>
                    <td id = "postTitle" onclick="openPost('<%=postIndex%>')"><%=postTitle%></td>
                    <td id = "writerId"> <%=postWriterId%> </td>
                    <td id = "viewCount"> <%=postViewCount%> </td>
                    <td id = "createDate"> <%=postCreatedDate%> </td>
                </tr>
            <% } %>
        
        </tbody>
    </table>
    <div>
        <button onclick ="window.open('/task7/html/post/postWriting.html')">새글 작성하기</button>
        <button >선택글 삭제하기</button>
    </div>

    <script>
        function openPost(indexValue){
            location.href="/task7/jsp/post/postViewPage.jsp?idx=" + indexValue;
        }
    </script>
   
s
</body>
</html>