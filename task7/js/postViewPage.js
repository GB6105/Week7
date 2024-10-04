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
                location.href = '/task7/jsp/comment/commentUploadAction.jsp?content='+inputContent +"&post=" +"<%=postIdx%>";
            }
        }

        //not using
        