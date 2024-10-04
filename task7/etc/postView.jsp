<%@ page language = "java" contentType = "text/html" pageEncoding ="utf-8"%>
<%@ page import = "java.sql.DriverManager"%>
<%@ page import = "java.sql.Connection"%>
<%@ page import = "java.sql.PreparedStatement"%>
<%@ page import = "java.sql.ResultSet"%>
<%@ page session = "true" %>

<%
    request.setCharacterEncoding("utf-8");
    String login_id = (String)session.getAttribute("user_id");
    String post_idx = request.getParameter("idx");
    String postTitle ="";
    String postWriterId ="";
    String postCategory ="";
    String postViewCount ="";
    String postContent ="";

    Class.forName("org.mariadb.jdbc.Driver");
    Connection connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/bulletin_board","GB","6105");

    String sql ="SELECT * FROM post WHERE idx = ?"; // 
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1,post_idx);

    ResultSet result = query.executeQuery();

    if(result.next()){
        postTitle = result.getString("title");
        postWriterId = result.getString("user_id");
        postCategory = result.getString("category_name");
        postViewCount = result.getString("view");
        postContent = result.getString("content");
    }

    String sql2 = "SELECT * FROM comment WHERE post_idx =?";
    PreparedStatement query2= connect.prepareStatement(sql2);
    query2.setString(1,post_idx);

    ResultSet result2 = query2.executeQuery();


%>

<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel = "stylesheet" type ="text/css" href = "/task7/css/post/post.css">
    <link rel = "stylesheet" type ="text/css" href = "/task7/css/post/postView.css">
    <title>Document</title>
</head>
<body>
    <h1 id = "title">게시글 확인하기</h1>
    <article id = "postBody">
        <header id = "postHeader">
            <p id = "category"><%=postCategory%></p>
            <h1 id = "postTitle"><%=postTitle%></h1>
            <p id = "writerId">작성자: <%=postWriterId%></p>
            <p id = "viewCount">조회수: <%=postViewCount%></p>
        </header>
        <p id = "content"> <%=postContent%> </p>
    </article>
    <div id = "postOption">
            <button class = "submitButton" id = "fixButton" type = "submit"> 수정하기 </button>
            <button class = "submitButton" id = "deleteButton" onclick ="checkDelete()"> 삭제하기 </button>
        </div>
    <article id = "comment">
        <% while(result2.next()){ %>
            <div class = "commentContainer">
                <p id ="loadedCommentWriterId"><%=result2.getString("user_idx")%></p>
                <p id = "loadedCommentContent"><%=result2.getString("content")%></p>
            </div>
        <% } %>
        <div class = "commentContainer">
            <span><p><%=login_id%></p></span>
            <span><p style ="color:gray">:현재 접속 중인 계정</p></span>
            <input id = "commentInputBox" type = text placeholder ="댓글을 입력하세요"></input>
            <button name = "inputContent" onclick ="commentUpload()">댓글 등록하기</button>
            
        </div>
        
    </article>
    
    <script>
        //본인이 쓴 글이 아니면 옵션 박스 가리기
        window.onload = function(){
            if("<%=login_id%>"!=="<%=postWriterId%>"){
                document.getElementById("postOption").style.display = "none";
            }
        }

        function checkDelete(){
            var checked = confirm("정말로 게시글을 삭제하시겠습니까?");
            if(checked == true){
                location.href = '/task7/jsp/post/postDeleteAction.jsp?idx=' + "<%=post_idx%>";
            }
        }

        function commentUpload(){
            var checked = confirm("댓글을 등록하시겠습니까?");
            if(checked == true){
                location.href = '/task7/jsp/comment/commentUploadAction.jsp?post_idx=' + "<%=post_idx%>" +"content="+"<%=inputContent%>";
            }
        }
    </script>

    
</body>
</html>