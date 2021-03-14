<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="naram.kim.recruit.model.*" %>
<%@page import="java.util.ArrayList" %>
 	
<%
	RecruitmentDAO dao = RecruitmentDAO.getInstance();
	
	int pg = 1;

	String page_num = request.getParameter("pg");
	
	int rowSize = 10;
	
	if(page_num == null) {
		page_num = "1";
		pg = 1;
	}
	
	if(page_num != null) {
		pg = Integer.parseInt(page_num);
	}
	
	int from = (pg * rowSize) - (rowSize - 1);
	int to = (pg * rowSize);
	
	ArrayList<RecruitmentVO> list = dao.listRecruitment(from, to);
	
	int total = dao.listRecruitmentTotal();
	int allPage = (int)Math.ceil(total / (double)rowSize);
	int block = 10;
	
	int startPage = ((pg - 1) / block * block) + 1;
	int endPage = ((pg - 1) / block * block + block);
	if (endPage > allPage) {
		endPage = allPage;
	}
	
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <!-- Theme Made By www.w3schools.com -->
  <title>Jobcruit</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <link href="https://fonts.googleapis.com/css?family=Gelasio|Nanum+Myeongjo&display=swap" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <style>
  @font-face { 
  	font-family: 'NEXON Lv1 Gothic OTF';
  	src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@2.1/NEXON Lv1 Gothic OTF.woff') format('woff');
  	font-weight: normal;
  	font-style: normal;
  }
  body {	
    font: 400 15px NEXON Lv1 Gothic OTF, serif;
    line-height: 1.8;
    color: #F1B7C4;
  }
  h2 {
    font-size: 24px;
    text-transform: uppercase;
    color: #ffffff;
    font-weight: 600;
    margin-bottom: 30px;
  }
  h4 {
    font-size: 19px;
    line-height: 1.375em;
    color: #ffffff;
    font-weight: 400;
    margin-bottom: 30px;
  }
  a {
  	text-decoration:none;
  	color: #F1B7C4;
  }
  a:hover, a:visited {
  	color: #F1B7C4;
  	text-decoration:none;
  }
  .jumbotron {
    background-color: #F1B7C4;
    color: #fff;
    padding: 50px 25px;
    font-family: 'NEXON Lv1 Gothic OTF', serif;
  }
  .container-fluid {
    padding: 50px 50px;
  }
  .bg-grey {
    background-color: #F1B7C4;
  }
  .thumbnail {
    padding: 0 0 15px 0;
    border: none;
    border-radius: 0;
  }
  .thumbnail img {
    width: 100%;
    height: 100%;
    margin-bottom: 10px;
  }
  .navbar {
    margin-bottom: 0;
    background-color: #F1B7C4;
    z-index: 9999;
    border: 0;
    font-size: 12px !important;
    line-height: 1.42857143 !important;
    letter-spacing: 4px;
    border-radius: 0;
    font-family: 'Gelasio', 'Nanum Myeongjo', serif;
  }
  .navbar li a, .navbar .navbar-brand {
    color: #fff !important;
  }
  .navbar-nav li a:hover, .navbar-nav li.active a {
    color: #F1B7C4 !important;
    background-color: #fff !important;
  }
  .navbar-default .navbar-toggle {
    border-color: transparent;
    color: #fff !important;
  }
  .contact-p {
  	font-size: 18px;
  	color: #FFFFFF;
  }
  .contact-a {
  	color: #FFFFFF;
  }
  .contact-a:hover {
  	color: #FFFFFF;
  }
  input[type="text"] {
  	width : 1000px;
  	padding-left : 10px;
  	color: #F1B7C4;
  	border: none;
  	margin-right: 5px;
  }
  .search_btn {
  	border: none;
  	background-color: #DB8AA0;
  	color: #FFFFFF;
  	padding: 3px 20px 3px 20px;
  	text-align: center;
  	text-decoration: none;
  	display: inline-block;
  	border-radius: 5px;
  }
  .search_btn:hover {
  	background: #DB8AA0; 
  	color: #FFFFFF;
  	text-decoration:none;
  }
  footer .glyphicon {
    font-size: 20px;
    margin-bottom: 20px;
    color:#FFFFFF;
  }
  footer .footer-p {
  	color:#FFFFFF;
  }
  footer .footer-a {
  	color:#FFFFFF;
  }
  .slideanim {visibility:hidden;}
  .slide {
    animation-name: slide;
    -webkit-animation-name: slide;
    animation-duration: 1s;
    -webkit-animation-duration: 1s;
    visibility: visible;
  }
  @keyframes slide {
    0% {
      opacity: 0;
      transform: translateY(70%);
    } 
    100% {
      opacity: 1;
      transform: translateY(0%);
    }
  }
  @-webkit-keyframes slide {
    0% {
      opacity: 0;
      -webkit-transform: translateY(70%);
    } 
    100% {
      opacity: 1;
      -webkit-transform: translateY(0%);
    }
  }
  @media screen and (max-width: 768px) {
    .col-sm-4 {
      text-align: center;
      margin: 25px 0;
    }
    .btn-lg {
      width: 100%;
      margin-bottom: 35px;
    }
  }
  </style>
</head>
<body id="myPage" data-spy="scroll" data-target=".navbar" data-offset="60">
<nav class="navbar navbar-default navbar-fixed-top">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="Jobcruit_main.jsp">Jobcruit</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#recruit">RECRUIT</a></li>
        <li><a href="#portfolio">PORTFOLIO</a></li>
        <li><a href="#contact">CONTACT</a></li>
      </ul>
    </div>
  </div>
</nav>

<div class="jumbotron text-center">
	<img src="../images/Logo.png" alt="JobCruit 로고" style="width:300px; height:300px;">
  	<p>잡코리아, 인크루트에 올라온 최신 공고들을 스크레이핑해서 하나의 페이지에서 보여드립니다.</p>
  	<form name="frm" id="frm" method="get" action="Jobcruit_search.jsp">
      <input type="text" name="search_keyword" size="100" id="search_keyword" placeholder="회사명 혹은 타이틀명으로 검색 가능합니다." required />
      <button class="search_btn">검색</button>
  	</form>
</div>

<!-- Container (About Section) -->
<div id="recruit" class="container-fluid">
  <div class="row">
<h2 class="text-center">Recruit</h2>
<div class="container-fluid bg-grey">
  <div>
  <%
  for (int i = 0; i < list.size(); i++) {
	  RecruitmentVO r = list.get(i);
	  
	  System.out.println(r.getTitle());
  %>
  <div style="background-color:white; padding:0px;">
    <table class="table table-hover">
    <thead>
      <tr>
        <th width=250px>회사명</th>
        <th width=470px>제목</th>
        <th width=250px>사이트명</th>
        <th width=380px>분야1</th>
        <th width=150px>분야2</th>
        <th width=150px>분야3</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td width=250px><%=r.getCompany()%><!--  ${li.company } --></td>
        <td width=470px><a class="title" href="<%=r.getTitlelink()%>" target="_blank"><%=r.getTitle()%></a></td>
        <td width=250px><%=r.getSite_name()%></td>
        <td width=380px><%=r.getField1()%></td>
        <% if (r.getField2() != null) { %>
        <td width=200px><%=r.getField2()%></td>
        <% } %>
        <% if (r.getField3() != null) { %>
        <td width=200px><%=r.getField3()%></td>
        <% } %>
      </tr>
    </tbody>
    <thead>
    <tr>
        <th>경력</th>
        <th>학력</th>
        <th>정규직/계약직</th>
        <th>지역</th>
        <th>마감일</th>
        <th>평점</th>
    </thead>
    <tbody>
    <tr>
    	<% if (r.getCareer() != null) {%>
        <td><%=r.getCareer()%></td>
        <% } %>
        <% if (r.getAcademic() != null) {%>
        <td><%=r.getAcademic()%></td>
        <% } %>
        <% if (r.getWorkingcondition() != null) {%>
        <td><%=r.getWorkingcondition()%></td>
        <% } %>
        <% if (r.getArea() != null) { %>
        <td><%=r.getArea()%></td>
        <% } %>
        <td><%=r.getDeadline()%></td>
        <% if (r.getStar() != 0.0) { %>
        <td><%=r.getStar()%></td>
        <% } %>
    </tr>
    </tbody>
  </table>
    </div>
  <%
  }
  %>
  </div>
  
<table width="100%" cellpadding="0" cellspacing="0" border="0">
  <tr><td colspan="4" height="5"></td></tr>
  <tr>
	<td align="center">
		<%
			if(pg>block) {
		%>
			[<a href="Jobcruit_main.jsp?pg=1" style="color: #FFFFFF;">◀◀</a>]
			[<a href="Jobcruit_main.jsp?pg=<%=startPage-1%>" style="color: #FFFFFF;">◀</a>]
		<%
			}
		%>
		
		<%
			for(int i=startPage; i<=endPage; i++){
				if(i==pg){
		%>
					<u style="color: #FFFFFF;"><b>[<%=i%>]</b></u>
		<%
				}else{
		%>
					[<a href="Jobcruit_main.jsp?pg=<%=i %>" style="color: #FFFFFF;"><%=i %></a>]
		<%
				}
			}
		%>
		
		<%
			if(endPage<allPage){
		%>
			[<a href="Jobcruit_main.jsp?pg=<%=endPage+1%>" style="color: #FFFFFF;">▶</a>]
			[<a href="Jobcruit_main.jsp?pg=<%=allPage%>" style="color: #FFFFFF;">▶▶</a>]
		<%
			}
		%>
		</td>
		</tr>
</table>
</div>
</div>
</div>

<!-- Container (Portfolio Section) -->
<div id="portfolio" class="container-fluid text-center bg-grey">
  <h2>PORTFOLIO</h2><br>
  <div class="row text-center slideanim">
    <div>
      <div class="thumbnail">
        <img src="../images/Seo.jpg" alt="서리태" style="width:350px; height:350px; margin-top:20px">
        <p><strong>서리태</strong></p>
        <p>JSP, HTML, CSS 수정</p>
        <p>Jobkorea, Incruit, Jobplanet Scraping</p>
      </div>
    </div>
  </div>
</div>

<!-- Container (Contact Section) -->
<div id="contact" class="container-fluid text-center bg-grey">
  <h2>CONTACT</h2>
  <div class="row text-center slideanim">
    <div class="container-fluid bg-grey">
      <p class="contact-p">Contact us and we'll get back to you within 24 hours.</p>
      <p class="contact-p"><span class="glyphicon glyphicon-map-marker"></span> Yongin, South Korea</p>
      <p class="contact-p"><span class="glyphicon glyphicon-envelope"></span> tlsdmswjs3@chungbuk.ac.kr</p>
      <p class="contact-p"><span class="glyphicon glyphicon-globe"></span> <a href="https://github.com/Kimnaram/" class="contact-a">https://github.com/Kimnaram/</a></p>
    </div>
  </div>
</div>

<footer class="container-fluid text-center bg-grey">
  <a href="#myPage" title="To Top">
    <span class="glyphicon glyphicon-chevron-up"></span>
  </a>
  <p class="footer-p">Jobcruit Made By <a href="https://se0r1-tae27.tistory.com/" class="footer-a" title="Visit tistoty">서리태</a></p>
</footer>

<script>
$(document).ready(function(){
  // Add smooth scrolling to all links in navbar + footer link
  $(".navbar a, footer a[href='#myPage']").on('click', function(event) {
    // Make sure this.hash has a value before overriding default behavior
    if (this.hash !== "") {
      // Prevent default anchor click behavior
      event.preventDefault();

      // Store hash
      var hash = this.hash;

      // Using jQuery's animate() method to add smooth page scroll
      // The optional number (900) specifies the number of milliseconds it takes to scroll to the specified area
      $('html, body').animate({
        scrollTop: $(hash).offset().top
      }, 900, function(){
   
        // Add hash (#) to URL when done scrolling (default click behavior)
        window.location.hash = hash;
      });
    } // End if
  });
  
  $(window).scroll(function() {
    $(".slideanim").each(function(){
      var pos = $(this).offset().top;

      var winTop = $(window).scrollTop();
        if (pos < winTop + 600) {
          $(this).addClass("slide");
        }
    });
  });
})
</script>

</body>
</html>