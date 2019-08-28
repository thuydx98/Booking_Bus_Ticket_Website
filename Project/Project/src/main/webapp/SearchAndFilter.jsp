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

<title>Booking Bus Ticket System</title>

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
<link
	href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css"
	rel="stylesheet">
<link href='https://fonts.googleapis.com/css?family=Muli:400,300'
	rel='stylesheet' type='text/css'>
<link href="assets/css/themify-icons.css" rel="stylesheet">
</head>
<body
	<%if ((String) session.getAttribute("employeefirstname") == null)
				response.sendRedirect("Login.jsp");%>>

	<div class="wrapper">
		<div class="sidebar" data-background-color="white"
			data-active-color="danger">

			<!--
        Tip 1: you can change the color of the sidebar's background using: data-background-color="white | black"
        Tip 2: you can change the color of the active button using the data-active-color="primary | info | success | warning | danger"
    -->

			<div class="sidebar-wrapper">
				<div class="logo">
					<a href="TicketsBooked.jsp" class="simple-text"> <img
						src="img/john-small.png" alt="" height="50px" width="50px">
						<br /> Welcome
						<div style="color: blue; font-weight: bold">
							<%
								out.print(session.getAttribute("employeelastname") + " " + session.getAttribute("employeefirstname"));
							%>
						</div>
					</a>
				</div>

				<ul class="nav">
					<li><a href="TicketsBooked.jsp"> <i class="ti-panel"></i>
							<p>View all tickets booked</p>
					</a></li>
					<li>
					<li><a href="AvailableSeats.jsp"> <i
							class="ti-view-list-alt"></i>
							<p>View all of available seat</p>
					</a></li>
					<li class="active"><a href="SearchAndFilter.jsp"> <i
							class="ti-text"></i>
							<p>Search & filter tickets and seats</p>
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
						<a class="navbar-brand" href="#">Search & filter tickets and
							seats</a>
					</div>
					<div class="collapse navbar-collapse">
						<ul class="nav navbar-nav navbar-right">

							<li class="dropdown"><a href="#" class="dropdown-toggle"
								data-toggle="dropdown"> <img src="img/john-small.png" alt=""
									height="20px" width="20px">
									<p class="notification"></p>
									<p>Settings</p> <b class="caret"></b>
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
						<div class="col-lg-6 col-sm-3">
							<form action="BookingManagementController?param=searchBooking"
								class="form-horizontal" method="post">
								<div class="card">
									<div class="content">
										<div class="row">
											<nav class="navbar navbar-light bg-light">
												<p style="text-align: center">Search tickets and seats</p>
												<c:if test="${not empty errorNullSearch}">
													<p style="color: red; margin-left: 3%">
														<c:out value="${errorNullSearch}"></c:out>
													</p>
												</c:if>
												<input class="form-control" id="searchBT" name="searchBT"
													type="text" placeholder="Search" aria-label="Search"
													<c:if test="${not empty searchBT}">
    													value="<c:out value="${sessionScope.searchBT}"></c:out>"
    												</c:if>>

												<button class="btn btn-outline-success my-2 my-sm-0"
													type="submit">Search</button>
											</nav>
										</div>
									</div>

								</div>
							</form>
						</div>
						<div class="content">
							<div class="container-fluid">
								<div class="row">
									<div class="col-md-12">
										<div class="card">
											<div class="header">
												<h4 class="title">Available Seats</h4>
												<p class="category">Available Seats</p>
											</div>
											<div class="content table-responsive table-full-width">
												<table class="table table-striped">
													<thead>
														<th style="font-weight: bold">Number Plate</th>
														<th style="font-weight: bold">Customer Name</th>
														<th style="font-weight: bold">Start Time</th>
														<th style="font-weight: bold">Start Place</th>
														<th style="font-weight: bold">Finish Place</th>
														<th style="font-weight: bold">Cancel</th>

													</thead>
													<tbody>
														<c:if test="${not empty searchBookingList}">

															<c:set scope="request" var="nullList" value="-1" />

															<c:if test="${searchBookingList != nullList}">
																<c:forEach items="${searchBookingList}" var="listSB">
																	<tr>
																		<td><c:out value="${listSB.numberPlate}"></c:out></td>
																		<td><c:out value="${listSB.customerName}"></c:out></td>
																		<td><c:out value="${listSB.timeStart}"></c:out></td>
																		<td><c:out value="${listSB.startPlace}"></c:out></td>
																		<td><c:out value="${listSB.finishPlace}"></c:out></td>
																		<td><c:set scope="request" var="check1" value="1" />
																			<c:set scope="request" var="check2" value="2" /> <c:set
																				scope="request" var="check0" value="0" /> <c:if
																				test="${listSB.status == check1}">
																				<form
																					action="BookingManagementController?param=cancelBooking"
																					class="form-horizontal" method="post">
																					<button
																						class="btn btn-outline-success my-2 my-sm-0"
																						name="bookingID" onclick="return confirm('Are you sure you want to cancel this Booked?')"
																						value="<c:out value="${listSB.booking_ID}"></c:out>"
																						type="submit">Cancel</button>
																				</form>
																			</c:if> <c:if test="${listSB.status == check0}">
																				<div style="font-weight: bold; color: red">Canceled</div>
																			</c:if> <c:if test="${listSB.status == check2}">
																				<div style="font-weight: bold; color: green">Done!</div>
																			</c:if></td>
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
         									
         															<c:url value = "BookingManagementController?param=searchBooking" var = "myURL">
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
					</div>
				</div>


				<footer class="footer">
					<div class="container-fluid">

						<div class="copyright pull-right">
							&copy;
							<script>
								document.write(new Date().getFullYear())
							</script>
							, made with <i class="fa fa-heart heart"></i> by <a
								href="TicketsBooked.jsp">VINH ĐẸP TRAI</a>
						</div>
					</div>
				</footer>

			</div>
			<!-- Extra JavaScript/CSS added manually in "Settings" tab -->
			<!-- Include jQuery -->


			<!-- Extra JavaScript/CSS added manually in "Settings" tab -->
			<!-- Include jQuery -->
			<script type="text/javascript"
				src="https://code.jquery.com/jquery-1.11.3.min.js"></script>

			<!-- Include Date Range Picker -->
			<script type="text/javascript"
				src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>
			<link rel="stylesheet"
				href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css" />

			<script>
				$(document)
						.ready(
								function() {
									var date_input = $('input[name="date"]'); //our date input has the name "date"
									var container = $('.bootstrap-iso form').length > 0 ? $(
											'.bootstrap-iso form').parent()
											: "body";
									date_input.datepicker({
										format : 'mm/dd/yyyy',
										container : container,
										todayHighlight : true,
										autoclose : true,
									})
								})
			</script>
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