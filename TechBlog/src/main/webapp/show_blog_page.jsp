<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="com.tech.blog.entities.Categories"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.entities.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page errorPage="error_page.jsp"%>
<!--  validation for login -->
<%

User user = (User) session.getAttribute("currentUser");
if (user == null) {
	response.sendRedirect("login_page.jsp");
}
%>




<%
    
    	int postId=Integer.parseInt(request.getParameter("post_id"));
    PostDao d = new PostDao(ConnectionProvider.getConnection());
    	Post p = d.getPostById(postId);
    
    %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title><%= p.getpTitile() %>|| TechBlog by Prashant</title>
<!-- css -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- <!-- 	Css manual -->

<link href="css/mystyle.css" rel="stylesheet" type="text/css" />

<style>
.banner-background {
	clip-path: polygon(50% 0%, 80% 0, 100% 0, 100% 100%, 80% 90%, 50% 100%, 20% 90%, 0
		100%, 0 0, 20% 0);
}

.post-title {
	font-weight: 100;
	font-size: 30px;
}

.post-content {
	font-weight: 100;
	font-size: 25px;
}

.post-date {
	font-style: italic;
	font-weight: bold;
}

.post-user-info {
	font-size: 20px;
}

.row-user {
	border: 1px solid #e2e2e2;
	padding-top: 15px;
}

body {
	background: url(image/bg.jpg);
	background-size: cover;
	background-attachment: fixed;
}
</style>

</head>
<body>
	<div id="fb-root"></div>
	<script async defer crossorigin="anonymous"
		src="https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v16.0"
		nonce="qFDjploK"></script>

	<!-- 	start of navbar -->

	<nav class="navbar navbar-expand-lg navbar-dark primary-background">
		<a class="navbar-brand" href="index.jsp"><span class="	fa fa-cogs"></span>
			TechBlog</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link"
					href="profile.jsp"><span class="	fa fa-bell-o"></span> Prashant
						Sail <span class="sr-only">(current)</span></a></li>
				<!--       <li class="nav-item"> -->
				<!--         <a class="nav-link" href="#">Contact</a> -->
				<!--       </li> -->
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> <span class="	fa fa-check-square-o"></span>
						Categories
				</a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">Programming Language</a> <a
							class="dropdown-item" href="#">Programming Implementation</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Data Structure</a>
					</div></li>
				<li class="nav-item"><a class="nav-link " href="#"><span
						class="fa fa-address-card-o"></span> Contact us</a></li>

				<li class="nav-item"><a class="nav-link " href="#"
					data-toggle="modal" data-target="#add-post-modal"><span
						class="fa fa-asterisk"></span>Do Post</a></li>
			</ul>
			<ul class="navbar-nav mr-right">

				<li class="nav-item"><a class="nav-link " href="#!"
					data-toggle="modal" data-target="#profile-modal"> <span
						class="fa fa-user-circle"></span> <%=user.getName()%></a></li>

				<li class="nav-item"><a class="nav-link " href="LogoutServlet">
						<span class="fa fa-user-plus"></span> Logout
				</a></li>

			</ul>
		</div>
	</nav>

	<!-- 	end of navbar -->


	<!-- 	main content of the body -->

	<div class="container">

		<div class="row my-4">

			<div class="col-md-8 offset-md-2">

				<div class="card">

					<div class="card-header primary-background text-white">

						<h4 class="post-title"><%=p.getpTitile() %></h4>

					</div>

					<div class="card-body">
						<img class="card-img-top my-2" src="blog_pics/<%=p.getpPic()%>">

						<div class="row my-3 row-user">
							<div class="col-md-8">

								<% UserDao ud= new UserDao(ConnectionProvider.getConnection()); %>

								<p class="post-user-info">
									<a href="#!"><%= ud.getUserByUserId(p.getUserId()).getName() %></a>
									has posted :
								</p>
							</div>

							<div class="col-md-4">
								<p class="post-date"><%= DateFormat.getDateTimeInstance().format(p.getpDate()) %></p>
							</div>

						</div>

						<p class="post-content"><%=p.getpContent() %></p>

						<br> <br>
						<div class="post-code">
							<pre><%=p.getpCode() %></pre>
						</div>

					</div>
					<div class="card-footer primary-background">

						<%
						LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
						%>

						<a href="#!" onclick="doLike(<%=p.getPid() %>,<%=user.getId() %>)"
							class="btn btn-outline-light btn-sm"><i
							class="fa fa-thumbs-o-up"></i><span class="like-counter"><%=ld.countLikeOnPost(p.getPid()) %>
						</span></a> <a href="#!" class="btn btn-outline-light btn-sm"><i
							class="fa fa-commenting-o"></i><span>20 </span></a>
					</div>

					<div class="card-footer">

						<div class="fb-comments"
							data-href="http://localhost:8080/TechBlog/show_blog_page.jsp?post_id=<%=p.getPid() %>"
							data-width=""  data-numposts="5"></div>
					</div>

				</div>

			</div>

		</div>

	</div>

	<!-- 	end of main content of the body -->

	<!-- start	profile modal -->

	<!-- Modal -->
	<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header primary-background text-white text-center">
					<h5 class="modal-title" id="exampleModalLabel">Techblog</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="container text-center">
						<img src="pics/<%=user.getProfile()%>" class="img-fluid"
							style="border-radius: 50%; max-width: 150px;"> <br>
						<h5 class="modal-title mt-3" id="exampleModalLabel"><%=user.getName()%></h5>

						<!--       		details -->
						<div id="profile-details">

							<table class="table">

								<tbody>
									<tr>
										<th scope="row">ID :</th>
										<td><%=user.getId()%></td>

									</tr>
									<tr>
										<th scope="row">Email :</th>
										<td><%=user.getEmail()%></td>

									</tr>
									<tr>
										<th scope="row">Gender :</th>
										<td><%=user.getGender()%></td>

									</tr>
									<tr>
										<th scope="row">Status :</th>
										<td><%=user.getAbout()%></td>

									</tr>

									<tr>
										<th scope="row">Registered on :</th>
										<td><%=user.getDatetime().toString()%></td>

									</tr>
								</tbody>
							</table>
						</div>

						<!-- 						profile edit -->

						<div id="profile-edit" style="display: none">
							<h3 class="mt-2">Please Edit Carefully</h3>
							<form action="EditServlet" method="post"
								enctype="multipart/form-data">
								<table class="table">
									<tr>
										<td>ID :</td>
										<td><%=user.getId()%></td>
									</tr>
									<tr>
										<td>Email :</td>
										<td><input type="email" class="form-control"
											name="user_email" value="<%=user.getEmail()%>"></td>
									</tr>
									<tr>
										<td>Name :</td>
										<td><input type="text" class="form-control"
											name="user_name" value="<%=user.getName()%>"></td>
									</tr>
									<tr>
										<td>Password :</td>
										<td><input type="password" class="form-control"
											name="user_password" value="<%=user.getPassword()%>">
										</td>
									</tr>
									<tr>
										<td>Gender :</td>
										<td><%=user.getGender().toUpperCase()%></td>
									</tr>
									<tr>
										<td>About :</td>
										<td><textarea rows="3" class="form-control"
												name="user_about"><%=user.getAbout()%>
											</textarea></td>
									</tr>
									<tr>
										<td>New Profile:</td>
										<td><input type="file" name="img" class="form-control">
										</td>
									</tr>

								</table>

								<div class="container">
									<button type="submit" class="btn btn-outline-primary">Save</button>
								</div>


							</form>
						</div>



					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button id="edit-profile-button" type="button"
						class="btn btn-primary">EDIT</button>
				</div>
			</div>
		</div>
	</div>

	<!-- end of profile modal -->

	<!-- 	add post modal -->

	<!-- Modal -->
	<div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Provide the
						post details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">

					<form id="add-post-form" action="AddPostServlet" method="Post">

						<div class="form-group">
							<select class="form-control" name="cid">
								<option selected disabled>---Select Category---</option>
								<%
								PostDao postd = new PostDao(ConnectionProvider.getConnection());
								ArrayList<Categories> list = postd.getAllCategories();
								for (Categories c : list) {
								%>
								<option value="<%=c.getCid()%>"><%=c.getName()%></option>
								<%
								}
								%>
							</select>
						</div>

						<div class="form-group">
							<input name="pTitle" type="text" placeholder="Enter Post Title"
								class="form-control">
						</div>

						<div class="form-group">
							<textarea name="pContent" class="form-control"
								placeholder="Enter your Content" style="height: 150px"></textarea>
						</div>

						<div class="form-group">
							<textarea name="pCode" class="form-control"
								placeholder="Enter your Program (if any)" style="height: 150px"></textarea>
						</div>

						<div class="form-group">
							<label>Select your Pic</label> <br> <input type="file"
								name="pic">
						</div>

						<div class="container text-center">
							<button type="submit" class="btn btn-outline-primary">Post</button>
						</div>


					</form>



				</div>

			</div>
		</div>
	</div>

	<!-- end post modal -->




	<!-- 	javaScript -->
	<script src="https://code.jquery.com/jquery-3.6.3.min.js"
		integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU="
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
	<script src="js/myjs.js" type="text/javascript"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>

	<script>
		$(document).ready(function() {

			let editStatus = false;

			$('#edit-profile-button').click(function() {
				if (editStatus == false) {
					$('#profile-details').hide();

					$('#profile-edit').show();
					editStatus = true;
					$(this).text("Black");

				} else {
					$('#profile-details').show();

					$('#profile-edit').hide();
					editStatus = false;
					$(this).text("Edit");
				}

			});

		});
	</script>
	<!-- 	now add post js -->
	<script>
		$(document).ready(function(e) {
			
			$('#add-post-form').on('submit', function(event){
// 				this code get calls when submitted
				event.preventDefault();
				console.log("you have click on submit..");
				let form = new FormData(this);
				
// 				now requesting to server
			$.ajax({
				url: "AddPostServlet",
				type: 'POST',
				data: form,
				success : function(data, textStatus, jqXHR) {
					//success
					console.log(data)
					if(data.trim() == 'done')
						{
						swal("Good job!", "saved successfully", "success");
						}else{
							swal("Error!", "Something went wrong try again...", "error");
						}
				},
				error : function(jqXHR, textStatus, errorThrown) 
				{
					//error
					swal("Error!", "Something went wrong try again...", "error");
				},
				processData : false,
				contentType : false
			
			})
			});
				

				
		});
	</script>












</body>
</html>