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
    String postIdx = request.getParameter("idx");
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
    <link rel = "stylesheet" type ="text/css" href = "/task7/css/post/postView.css">
    <link rel = "stylesheet" type ="text/css" href = "/task7/css/comment/comment.css">
    <title>Document</title>
</head>
<body>
    <h1 id = "title">게시글 확인하기</h1>
    <%-- 게시글 부분 --%>
    <article id = "postBody">
        <header id = "postHeader">
            <p id = "category"><%=postCategory%></p>
            <h1 id = "postTitle"><%=postTitle%></h1>
            <p id = "writerId">작성자: <%=postWriterId%></p>
            <p id = "viewCount">조회수: <%=postViewCount%></p>
        </header>
        <textarea id = "content"> <%=postContent%> </textarea>
    </article>
    <%-- 게시글 옵션 부분 --%>
    <div id = "postOption">
            <button class = "submitButton" id = "fixButton" onclick = "window.open('/task7/jsp/post/postFixPage.jsp?idx=' + 'session.getAttribute(currentPostIdx)')"> 수정하기 </button>
            <button class = "submitButton" id = "deleteButton" onclick ="checkDelete()"> 삭제하기 </button>
        </div>
    
    <%-- 댓글 부분 --%>
    <article id = "comment">
        <%-- 해당 게시글에 대한 댓글 전부 보여주기 --%>
        <% while(currentComments.next()){
                String currentCommentIdx = currentComments.getString("idx");
                String commentWriterId = currentComments.getString("user_idx");
                String loadedComment = currentComments.getString("content");
                boolean isOwner = loginId.equals(commentWriterId);
            %>
            
            <div class = "commentContainer">
                <p id = "loadedCommentWriterId"><%=commentWriterId%></p>
                <%-- 댓글 수정하기 박스 구현 --%>
                <div id = "loadedCommentContainer">
                    <input type = "text"  id = "loadedCommentContent" disabled placeholder ="<%=loadedComment%>"></input>
                    <button id = "submitFixedComment" onclick ="fixedCommentUpload(<%=currentCommentIdx%>)">등록</button>
                    <button id = "cancelFixComment" onclick ="cancelFix()">취소</button>
                </div>

                <%-- 댓글 옵션 부분 --%>
                <button class = "commentOption" id = "fixCommentButton" 
                style="display: <%= isOwner ? "inline" : "none" %>;" 
                onclick = "fixComment(<%=currentCommentIdx%>)">수정</button>
                <button class = "commentOption" id = "deleteCommentButton" 
                style="display: <%= isOwner ? "inline" : "none" %>;" 
                onclick = "deleteComment(<%=currentCommentIdx%>)">삭제</button>

            </div>
        <% } %>
        <%-- 댓글 작성 부분 --%>
        <div class = "commentContainer">
            <span><p><%=loginId%></p></span>
            <span><p style ="color:gray">:현재 접속 중인 계정</p></span>
            <input id = "commentInputBox" type = text placeholder ="댓글을 입력하세요" required></input>
            <button  onclick ="commentUpload()">댓글 등록하기</button>
            
        </div>
        
    </article>
    
    <script>
            //본인이 쓴 글이 아니면 옵션 박스 가리기
        window.onload = function(){
            if("<%=loginId%>"!=="<%=postWriterId%>"){
                document.getElementById("postOption").style.display = "none";
            }  
        }



        function checkDelete(){
            var checked = confirm("정말로 게시글을 삭제하시겠습니까?");
            if(checked == true){
                location.href = '/task7/jsp/post/postDeleteAction.jsp?idx=' + "<%=postIdx%>";
            }
        }

        function deleteComment(indexValue){
            var checked = confirm("정말로 댓글을 삭제하시겠습니까?");
            if(checked == true){
                location.href = '/task7/jsp/comment/commentDeleteAction.jsp?comment_idx=' + indexValue;
            }
        }

        function commentUpload(){
            var checked = confirm("댓글을 등록하시겠습니까?");
            var inputContent = document.getElementById("commentInputBox").value;
            if(checked == true){
                if(inputContent === "" ){
                    alert("댓글을 최소 두 글자 이상 작성하세요")
                    
                }else{
                    location.href = '/task7/jsp/comment/commentUploadAction.jsp?content='+inputContent +"&post=" +"<%=postIdx%>";
                }
            }
        }


        function fixComment(indexValue){
            //수정,삭제 안보이게 변동
            document.getElementById("fixCommentButton").style.display ="none";
            document.getElementById("deleteCommentButton").style.display ="none";

           //안보이던 (등록 취소)버튼 보이도록
            document.getElementById("submitFixedComment").style.display ="inline";
            document.getElementById("cancelFixComment").style.display ="inline";

            //비활성화 되었던 댓글 창 보이도록
            const fixCommentContainer = document.getElementById("loadedCommentContent");
            fixCommentContainer.style.border = "1px solid lightgrey";
            fixCommentContainer.style.width ="90%";
            fixCommentContainer.disabled = false;

        }

        function cancelFix(){
            //등록, 취소 안보이게 변동
            document.getElementById("submitFixedComment").style.display ="none";
            document.getElementById("cancelFixComment").style.display ="none";

            //다시 수정, 삭제 보이게 변동
            document.getElementById("fixCommentButton").style.display ="inline";
            document.getElementById("deleteCommentButton").style.display ="inline";

            //댓글창 비활성화
            const fixCommentContainer = document.getElementById("loadedCommentContent");

            fixCommentContainer.style.border = "none";
            fixCommentContainer.style.width ="100%";
            fixCommentContainer.disabled = true;
            //입력된 값 취소 시켜야함

        }

        //이제 변경된 값을 보내야함
        function fixedCommentUpload(indexValue){
            console.log(indexValue);
            var check = confirm("댓글을 수정하시겠습니까?");
            //var getIndex = document.getElementById("submitFixedComment").getAttribute('commentIndex');
            var fixedCommentContent = document.getElementById("loadedCommentContent").value;
            
            if(check ==true){
                if(fixedCommentContent === "" ){
                    alert("댓글을 최소 두 글자 이상 작성하세요")
                }else{
                    location.href ='/task7/jsp/comment/commentFixAction.jsp?comment_idx='+indexValue +"&fixed_content=" +fixedCommentContent ;
                }
            }
        }
    </script>

    
</body>
</html>