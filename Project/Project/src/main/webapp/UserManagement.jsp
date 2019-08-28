<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>
<%@page import="edu.fa.model.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<link rel="apple-touch-icon" sizes="76x76"
	href="assets/img/apple-icon.png">
<link rel="icon" type="image/png" sizes="96x96"
	href="assets/img/favicon.png">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

<title>Customer Management</title>

<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'
	name='viewport' />
<meta name="viewport" content="width=device-width" />


<!-- Bootstrap core CSS     -->
<link href="assets/css/bootstrap.min.css" rel="stylesheet" />

<!-- Animation library for notifications   -->
<link href="assets/css/animate.min.css" rel="stylesheet" />

<!--  Paper Dashboard core CSS    -->
<link href="assets/css/paper-dashboard.css" rel="stylesheet" />

<!--  CSS for Demo Purpose, don't include it in your project     -->
<link href="assets/css/demo.css" rel="stylesheet" />

<!--  CSS for Pagination, don't include it in your project     -->
<link href="css/pagination.css" rel="stylesheet" />

<!--  Fonts and icons     -->
<link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
<link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>
<link href="assets/css/themify-icons.css" rel="stylesheet">
<link href="css/admin.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


</head>

<script type="text/javascript">
	function show_alert_success() {
		alert("Successfully");
	}
	//When error Resgister 
	function errorRegCus() {
		document.getElementById('id01').style.display='block';
	}
	function showEditCus() {
		document.getElementById('id03').style.display='block';
	}
</script>


<body<%if(session.getAttribute("success") != null) {%>
		onload="show_alert_success()"
	<% session.removeAttribute("success");
	}
	if (session.getAttribute("errorReg") != null) {%>
		onload="errorRegCus()"
	<%}
	if (session.getAttribute("customerinfo") != null || session.getAttribute("errorEditCus") != null) {%>
		onload="showEditCus()"
	<%}
	%>>


	<div class="wrapper">
		<div class="sidebar" data-background-color="white"
			data-active-color="danger">



			<div class="sidebar-wrapper">
				<div class="logo">
					<a href="EmpManagement.jsp" class="simple-text"> <img
						src="img/admin.png" alt="" height="50px" width="50px"><br>
						Welcome <% out.print(session.getAttribute("employeefirstname"));  %>
					</a>
				</div>

				<ul class="nav">
					<li><a href="EmpManagement.jsp"> <i class="ti-panel"></i>
							<p>Employee Management</p>
					</a></li>
					<li class="active"><a href="UserManagement.jsp"> <i
							class="ti-text"></i>
							<p>User Management</p>
					</a></li>

				</ul>
			</div>
		</div>

		<div class="main-panel">
			<nav class="navbar navbar-default">
				<div class="container-fluid">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle">
							<span class="sr-only">Toggle navigation</span> <span
								class="icon-bar bar1"></span> <span class="icon-bar bar2"></span>
							<span class="icon-bar bar3"></span>
						</button>
						<a class="navbar-brand" href="#">User Management</a>
						<button class="btn btn-primary"
							onclick="document.getElementById('id01').style.display='block'"
							style="width: 47%">Create new customer</button>
					</div>
					<div class="collapse navbar-collapse">
						<ul class="nav navbar-nav navbar-right">
							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown"> <img src="img/admin.png" alt=""
									height="20px" width="20px">
									<p class="notification">Settings</p> <b class="caret"></b>
							</a>
								<ul class="dropdown-menu">
									<li><a href="#">Profile</a></li>
									<li><a href="LoginController?param=logoutEmployee">Log
											out</a></li>

								</ul></li>

						</ul>

					</div>
				</div>
			</nav>


			<div class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<div class="card">


								<!-- Search button -->
								<form action="AdminManagementController?param=getCustomerList" class="form-horizontal" method="post">
									<div class="search-button">
										<input type="text" name="searchCus" placeholder="Search.."
											<c:if test="${not empty searchCus}">
    											value="<c:out value="${sessionScope.searchCus}"></c:out>"
    										</c:if>>
									</div>
								</form>
							</div>
						</div>

					</div>
				</div>
				<br>

				<div class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<div class="card">
								
								<div class="content table-responsive table-full-width">
									<table class="table table-striped">
										<thead>
											<th style="font-weight: bold">Full Name</th>
											<th style="font-weight: bold">Email</th>
											<th style="font-weight: bold">Phone Number</th>
											<th style="font-weight: bold">Address</th>
											<th style="font-weight: bold;">Action</th>
										</thead>
										<tbody>
											<c:if test="${empty customerList}">
												<c:redirect url = "AdminManagementController?param=getCustomerList"/>
											</c:if>
											<c:if test="${not empty customerList}">

												<c:set scope="request" var="nullList" value="-1" />

												<c:if test="${customerList != nullList}">
													<c:forEach items="${customerList}" var="list">
														<tr>
															<td><c:out value="${list.fullName}"></c:out></td>
															<td><c:out value="${list.email}"></c:out></td>
															<td><c:out value="${list.phoneNumber}"></c:out></td>
															<td><c:out value="${list.address}"></c:out></td>
															<td style="width: 5%">
																<form action="ChangeInfoController?param=loadInfoCustomerManagement" class="form-horizontal" method="post">
																	<button class="btn btn-primary" name="customerID" value="<c:out value="${list.customer_ID}"></c:out>" type="submit">Edit</button>
																</form>
															</td>
														</tr>
													</c:forEach>
												</c:if>
											</c:if>

										</tbody>
									</table>
									
									<c:if test="${pageNumber != 0}">
									
									<div align="center">
										<ul class="pagination modal-1">
											<li><a href="#" class="prev">&laquo;</a></li>
										
											<c:forEach var = "i" begin = "1" end = "${pageNumber}">
         									
         										<c:url value = "AdminManagementController?param=getCustomerList" var = "myURL">
   													<c:param name = "page" value = "${i}"/>
												</c:url>
         									
         										<li>
         											<a href="<c:out value="${myURL}"></c:out>"
         												<c:if test="${pageActive == i}">
															class="active"
														</c:if>
													><c:out value="${i}"></c:out></a>
												</li>
      										</c:forEach>
										
											<li><a href="#" class="next">&raquo;</a></li>
										</ul>
									</div>
									
									</c:if>
									
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
			<br>
		</div>



		<footer class="footer">
			<div class="container-fluid">

				<div class="copyright pull-right">
					&copy;
					<script>
						document
								.write(new Date().getFullYear())
					</script>
					, made with <i class="fa fa-heart heart"></i> by <a
						href="https://www.facebook.com/thuydx.98" target="_blank">Thuy Dao Xuan</a>
				</div>
			</div>
		</footer>
		<!-- Sign up -->
		<div class="sign-up">

			<div id="id01" class="modal1">
				<span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close modal1">&times;</span>
				<form class="modal-content1" method="post" action="RegisterController?param=register">
					<div class="container1">
						<h1>Create customer</h1>
						<p>Please fill in this form to create a customer.</p>
						<%
							if ((String) session.getAttribute("errorReg") != null) {
						%>
						<h4 style="color: red">
							<%
								out.print(session.getAttribute("errorReg"));
							%>
						</h4>
						<%
							}
						%>
						<hr>
						<label for="fullname"><b>Full Name</b></label> 
						<input type="text" placeholder="Enter Full Name" name="fullname" required> 
						
						<label for="email"><b>Email</b></label> 
						<input type="text" placeholder="Enter Email" name="email" required> 
						
						<label for="phonenumber"><b>Phone Number</b></label> 
						<input type="text" placeholder="Enter Phone Number" name="phonenumber" required>
						
						<label for="password"><b>Password</b></label> 
						<input type="password" placeholder="Enter Password" name="password" required> 
							
						<label for="repassword"><b>Re-Password</b></label>
						<input type="password" placeholder="Enter Password" name="repassword" required> 
							
						<label for="address"><b>Address</b></label>
						<input type="text" placeholder="Enter Address" name="address" required>

						<div class="clearfix">
							<button type="submit" name="button" value="manager" class="signupbtn1">Create</button>
							<button type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn1">Cancel</button>
						</div>
					</div>
				</form>
			</div>

			<div id="id03" class="modal1">

				<form class="modal-content1 animate" method="POST" action="ChangeInfoController?param=changeInfoCustomerManagement">
					<div class="imgcontainer">
						<span
							onclick="document.getElementById('id03').style.display='none'"
							class="close" title="Close Modal1">&times;</span>
					</div>
						
					<div class="container1">
						<h1>Edit customer</h1>
						<p>Please fill in this form to edit a customer.</p>
						<%
							if ((String) session.getAttribute("errorEditCus") != null) {
						%>
							<h4 style="color: red">
							<%
								out.print(session.getAttribute("errorEditCus"));
							%>
							</h4>
							<%
								session.removeAttribute("errorEditCus");
							}
							%>
						<hr>
						<label for="fullname"><b>Full Name</b></label> 
						<input type="text" disabled value='<c:out value="${customerinfo.fullName}"></c:out>'> 
						
						<label for="email"><b>Email</b></label> 
						<input type="text" disabled value='<c:out value="${customerinfo.email}"></c:out>'> 
						
						<label for="phonenumber"><b>Phone Number</b></label> 
						<input type="text" disabled value='<c:out value="${customerinfo.phoneNumber}"></c:out>'>
						
						<label for="password"><b>Password</b></label> 
						<input type="password" placeholder="Enter Password" name="password" required value='<c:out value="${customerinfo.password}"></c:out>'> 
							
						<label for="repassword"><b>Re-Password</b></label>
						<input type="password" placeholder="Enter Password" name="repassword" required value='<c:out value="${customerinfo.password}"></c:out>'> 
							
						<label for="address"><b>Address</b></label>
						<input type="text" placeholder="Enter Address" name="address" required value='<c:out value="${customerinfo.address}"></c:out>'>
						
						
						<button type="submit" name="customerid" value='<c:out value="${customerinfo.customer_ID}"></c:out>' class="signupbtn1">Update</button>

						<div class="clearfix" style="background-color: white">
							<button type="button" onclick="document.getElementById('id03').style.display='none'" class="cancelbtn1">Cancel</button>
						</div>
						<% session.removeAttribute("customerinfo"); %>
					</div>
				</form>
			</div>


			<script>
				// Get the modal
				var modal1 = document.getElementById('id01');
				var modal3 = document.getElementById('id03');

				// When the user clicks anywhere outside of the modal, close it
				window.onclick = function(event) {
					if (event.target == modal1) {
						modal1.style.display = "none";
					}
					if (event.target == modal3) {
						modal3.style.display = "none";
					}
				}
			</script>

		</div>
	</div>
</body>

<!--   Core JS Files   -->
<script src="assets/js/jquery-1.10.2.js" type="text/javascript"></script>
<script src="assets/js/bootstrap.min.js" type="text/javascript"></script>

<!--  Checkbox, Radio & Switch Plugins -->
<script src="assets/js/bootstrap-checkbox-radio.js"></script>

<!--  Charts Plugin -->
<script src="assets/js/chartist.min.js"></script>

<!--  Notifications Plugin    -->
<script src="assets/js/bootstrap-notify.js"></script>

<!--  Google Maps Plugin    -->
<script type="text/javascript"
	src="https://maps.googleapis.com/maps/api/js"></script>

<!-- Paper Dashboard Core javascript and methods for Demo purpose -->
<script src="assets/js/paper-dashboard.js"></script>

<!-- Paper Dashboard DEMO methods, don't include it in your project! -->
<script src="assets/js/demo.js"></script>

</html>