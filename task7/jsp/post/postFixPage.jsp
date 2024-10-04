<%@ page language = "java" contentType = "text/html" pageEncoding ="utf-8"%>
<%@ page import = "java.sql.DriverManager"%>
<%@ page import = "java.sql.Connection"%>
<%@ page import = "java.sql.PreparedStatement"%>
<%@ page import = "java.sql.ResultSet"%>
<%@ page session = "true" %>

<%-- 백엔드 통신파트 --%>
<%
    request.setCharacterEncoding("utf-8");
    String loginId = (String)session.getAttribute("user_id");
    String postIdx = (String)session.getAttribute("currentPostIdx");

    String postTitle ="";
    String postWriterId ="";
    String postCategory ="";
    String postViewCount ="";
    String postContent ="";

    Class.forName("org.mariadb.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bulletin_board","GB","6105");

    String sql ="SELECT * FROM post WHERE idx = ?"; // 
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1,postIdx);

    ResultSet currentPosts = query.executeQuery();

    if(currentPosts.next()){
        postTitle = currentPosts.getString("title");
        postWriterId = currentPosts.getString("user_id");
        postCategory = currentPosts.getString("category_name");
        postViewCount = currentPosts.getString("view");
        postContent = currentPosts.getString("content");
    }

    String sql2 = "SELECT * FROM comment WHERE post_idx =?";
    PreparedStatement query2= connect.prepareStatement(sql2);
    query2.setString(1,postIdx);

    ResultSet currentComments = query2.executeQuery();

    //게시글에 들어오면 이 이후의 작업에 대해 수월하게 하기 위해서 현재 보고있는 게시글의 idx를 세션으로 저장
    session.setAttribute("currentPostIdx", postIdx);

%>

<%-- HTML 구현 파트 --%>
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel = "stylesheet" type ="text/css" href = "/task7/css/post/post.css">
    <link rel = "stylesheet" type ="text/css" href = "/task7/css/post/postWriting.css">
    <title>Document</title>
</head>
<body>
    <h1 id = "title">게시글 수정하기</h1>
    <form action = "/task7/jsp/post/postFixUploadAction.jsp">
        <input type = "text" name = "postTitle" id = "titleContainer" minlength="2" placeholder="제목을 입력하세요" value ="<%=postTitle%>" required>
        <select name = "category" id = "categoryList" required>
            <option value = "">말머리를 선택하세요</option>
            <option value = "essay">essay</option>
            <option value = "humour">humour</option>
            <option value = "normal">normal</option>
            <option value = "notice">notice</option>
        </select>
        
        <textarea name = "postContent" id = "contentContainer" minlength="10" placeholder="내용을 입력하세요" required><%=postContent%></textarea>
        <button id = "submitButton" type = "submit"> 작성하기 </button>
    </form>
    

</body>
</html>