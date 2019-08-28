<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>

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

<title>Employee Management</title>

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
	function errorRegEmp() {
		document.getElementById('id01').style.display='block';
	}
	function showEditEmp() {
		document.getElementById('id03').style.display='block';
	}
</script>


<body
	<%if(session.getAttribute("success") != null) {%>
		onload="show_alert_success()"
	<% session.removeAttribute("success");
	}
	if (session.getAttribute("errorRegEmp") != null) {%>
		onload="errorRegEmp()"
	<%}
	if (session.getAttribute("employeeinfo") != null || session.getAttribute("errorEditEmp") != null) {%>
		onload="showEditEmp()"
	<%}
	%>>


	<div class="wrapper">
		<div class="sidebar" data-background-color="white"
			data-active-color="danger">



			<div class="sidebar-wrapper">
				<div class="logo">
					<a href="EmpManagement.jsp" class="simple-text"> <img
						src="img/admin.png" alt="" height="50px" width="50px"> <br />
						Welcome <% out.print(session.getAttribute("employeefirstname")); %>
					</a>
				</div>

				<ul class="nav">
					<li class="active"><a href="EmpManagement.jsp"> <i class="ti-panel"></i>
							<p>Employee Management</p>
					</a></li>
					<li><a href="UserManagement.jsp"> <i class="ti-text"></i>
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
						<a class="navbar-brand" href="#">Employee Management</a>
						<button class="btn btn-primary"
										onclick="document.getElementById('id01').style.display='block'" style=" width: 42%">Create new employee</button>
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
									<li><a href="LoginController?param=logoutEmployee">Log out</a></li>

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
								<form action="AdminManagementController?param=getEmployeeList" class="form-horizontal" method="post">
									<div class="search-button">
										<input type="text" name="searchEmp" placeholder="Search.."
											<c:if test="${not empty searchEmp}">
    											value="<c:out value="${sessionScope.searchEmp}"></c:out>"
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
											<th style="font-weight: bold">ID Number</th>
											<th style="font-weight: bold">User Name</th>
											<th style="font-weight: bold">Manager</th>
											<th style="font-weight: bold">Role</th>
											<th colspan="2"  style="font-weight: bold;">Action</th>
										</thead>
										<tbody>
											<c:if test="${empty employeeList}">
												<c:redirect url = "AdminManagementController?param=getEmployeeList"/>
											</c:if>
											<c:if test="${not empty employeeList}">

												<c:set scope="request" var="nullList" value="-1" />

												<c:if test="${employeeList != nullList}">
													<c:forEach items="${employeeList}" var="list">
														<tr>
															<td><c:out value="${list.lastName}"></c:out><c:out value=" "></c:out><c:out value="${list.firstName}"></c:out></td>
															<td><c:out value="${list.idNumber}"></c:out></td>
															<td><c:out value="${list.userName}"></c:out></td>
															<td><c:out value="${list.managerName}"></c:out></td>
															<td><c:out value="${list.roleName}"></c:out></td>
															
																<c:set scope="request" var="check1" value="1" />
																 <c:if test="${list.status == check1}">
																 	<td style="width: 5%">
																 		<form action="ChangeInfoController?param=loadInfoEmployee" class="form-horizontal" method="post">
																			<button class="btn btn-primary" name="employeeID"
																				value="<c:out value="${list.employee_ID}"></c:out>"
																				type="submit">Edit</button>
																		</form>
																	</td>
																	<td style="width: 5%">
																 		<form action="AdminManagementController?param=quitEmployee" class="form-horizontal" method="post">
																			<button class="btn btn-outline-success my-2 my-sm-0" name="employeeID"  onclick="return confirm('Are you sure you want quit this person?')"
																				value="<c:out value="${list.employee_ID}"></c:out>"
																				type="submit">Quit</button>
																		</form>
																	</td>
																</c:if>
																<c:if test="${list.status != check1}">
																	<td colspan="2" >
																		<div align="center" style="font-weight: bold; color: red">Quited</div>
																	</td>
																</c:if>
															
														
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
         									
         										<c:url value = "AdminManagementController?param=getEmployeeList" var = "myURL">
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
							document.write(new Date().getFullYear())
						</script>
						, made with <i class="fa fa-heart heart"></i> by <a
							href="https://www.facebook.com/thuydx.98" target="_blank">Thuy Dao Xuan</a>
					</div>
				</div>
			</footer>

	<!-- Create Account -->
								<div class="sign-up">

									<div id="id01" class="modal1">
										<span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close modal1">&times;</span>
										<form class="modal-content1" method="post"
											action="RegisterController?param=registerEmployee">
											<div class="container1">
												<h1>Create Employee</h1>
												<p>Please fill in this form to create an employee.</p>
												<%
													if ((String) session.getAttribute("errorRegEmp") != null) {
												%>
												<h4 style="color: red">
													<%
														out.print(session.getAttribute("errorRegEmp"));
													%>
												</h4>
												<%
													session.removeAttribute("errorRegEmp");
													}
												%>
												<hr>

												<label for="firstname"><b>First Name</b></label> 
												<input type="text" placeholder="Enter First Name" name="firstname" required> 
													
												<label for="lastname"><b>Last Name</b></label> 
												<input type="text" placeholder="Enter Last Name" name="lastname" required> 
												
												<label for="email"><b>Email</b></label>
												<input type="text" placeholder="Enter Email" name="email" required> 
												
												<label for="IDnumber"><b>ID Number</b></label> 
												<input type="text" placeholder="Enter ID Number" name="idnumber" required> 
												
												<label for="phonenumber"><b>Phone number</b></label> 
												<input type="text" placeholder="Enter Phone number" name="phonenumber" required> 
												
												<label for="Adress"><b>Address</b></label>
												<input type="text" placeholder="Enter Addres" name="address" required> 
												
												<label for="Username"><b>Username</b></label>
												<input type="text" placeholder="Enter Username" name="username"> 
												
												<label for="Password"><b>Password</b></label>
												<input type="password" placeholder="Enter Password" name="password"> 
												
												<label for="repassword"><b>Re-Password</b></label>
												<input type="password" placeholder="Enter Re-Password" name="repassword"> 
												
												<label for="setrole"><b>Set Role</b></label>
												<div class="select-box">
													<select name="role">
														<option value="2">Ticket Seller</option>
														<option value="3" selected>Driver</option>
														<option value="4">Assistant</option>
													</select>
												</div>

												<div class="clearfix">
													<button type="submit" class="signupbtn1">Create</button>
													<button type="button"
														onclick="document.getElementById('id01').style.display='none'"
														class="cancelbtn1">Cancel</button>
												</div>
											</div>
										</form>
									</div>
								</div>
								
									<!-- Edit Account -->
								
								<div class="sign-up">

									<div id="id03" class="modal1">
										<span onclick="document.getElementById('id03').style.display='none'" class="close" title="Close modal1">&times;</span>
										<form class="modal-content1" method="post"
											action="ChangeInfoController?param=changeInfoEmployee">
											<div class="container1">
												<h1>Edit Employee Infomation</h1>
												<p>Please fill in this form to edit an employee.</p>
												<%
													if ((String) session.getAttribute("errorEditEmp") != null) {
												%>
												<h4 style="color: red">
													<%
														out.print(session.getAttribute("errorEditEmp"));
													%>
												</h4>
												<%
													session.removeAttribute("errorEditEmp");
													}
												%>
												<hr>

												<label for="firstname"><b>First Name</b></label> 
												<input type="text" placeholder="Enter First Name" name="firstname" value='<c:out value="${employeeinfo.firstName}"></c:out>' required> 
													
												<label for="lastname"><b>Last Name</b></label> 
												<input type="text" placeholder="Enter Last Name" name="lastname" value='<c:out value="${employeeinfo.lastName}"></c:out>' required> 
												
												<label for="email"><b>Email</b></label>
												<input type="text" placeholder="Enter Email" name="email" value='<c:out value="${employeeinfo.email}"></c:out>' required> 
												
												<label for="IDnumber"><b>ID Number</b></label> 
												<input type="text" placeholder="Enter ID Number" name="idnumber" value='<c:out value="${employeeinfo.idNumber}"></c:out>' required> 
												
												<label for="phonenumber"><b>Phone number</b></label> 
												<input type="text" placeholder="Enter Phone number" name="phonenumber" value='<c:out value="${employeeinfo.phoneList[0]}"></c:out>' required> 
												
												<label for="Adress"><b>Address</b></label>
												<input type="text" placeholder="Enter Addres" name="address" value='<c:out value="${employeeinfo.address}"></c:out>' required> 
												
												<label for="Username"><b>Username</b></label>
												<input type="text" placeholder="Enter Username" value='<c:out value="${employeeinfo.userName}"></c:out>' name="username"> 
												
												<label for="Password"><b>Password</b></label>
												<input type="password" placeholder="Enter Password" value='<c:out value="${employeeinfo.password}"></c:out>' name="password"> 
												
												<label for="repassword"><b>Re-Password</b></label>
												<input type="password" placeholder="Enter Re-Password" value='<c:out value="${employeeinfo.password}"></c:out>' name="repassword"> 
												
												<label for="setrole"><b>Set Role</b></label>
												<div class="select-box">
													<select name="role">
														<option value="2"
																<c:if test="${employeeinfo.roleList[0] == 2}">selected</c:if>
														>Ticket Seller</option>
														<option value="3"
															<c:if test="${employeeinfo.roleList[0] == 3}">selected</c:if>
														>Driver</option>
														<option value="4"
															<c:if test="${employeeinfo.roleList[0] == 4}">selected</c:if>
														>Assistant</option>
													</select>
												</div>

												<div class="clearfix">
													<button type="submit" name="employeeid" value='<c:out value="${employeeinfo.employee_ID}"></c:out>' class="signupbtn1">Update</button>
													<button type="button"
														onclick="document.getElementById('id03').style.display='none'"
														class="cancelbtn1">Cancel</button>
												</div>
											</div>
											<% session.removeAttribute("employeeinfo"); %>
										</form>
									</div>
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


<script type="text/javascript">
	$(document).ready(function() {

		demo.initChartist();

		$.notify({
			icon : 'ti-gift',
			message : "Welcome <b><%out.print(session.getAttribute("employeelastname") + " " + session.getAttribute("employeefirstname"));%> </b> - Have a great day."

			}, {
				type : 'success',
				timer : 2000
				});

	});
	
</script>
</html>