<%@page import="java.time.LocalDate"%>

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


<link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
<link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>
<link href="assets/css/themify-icons.css" rel="stylesheet">

	<script type="text/javascript">
		function show_alert_success() {
			$(window).on('load', function() {
				$('#success').modal('show');
			});
		}
		function show_alert_fail() {
			$(window).on('load', function() {
				$('#error').modal('show');
			});
		}
	</script>

</head>
<body
	<%if (request.getAttribute("checkCancelBooking") != null) {%>
		onload="show_alert_success()"
			<%if (request.getAttribute("checkCancelBooking").equals("1")) {%>
				onload="show_alert_success()"
			<%}
			if (request.getAttribute("checkCancelBooking").equals("0")) {%>
				onload="show_alert_fail()"
			<%}
		request.removeAttribute("checkCancelBooking");
	}%>>


	<!--formden.js communicates with FormDen server to validate fields and submit via AJAX -->
	<script type="text/javascript"
		src="https://formden.com/static/cdn/formden.js"></script>

	<!-- Special version of Bootstrap that is isolated to content wrapped in .bootstrap-iso -->
	<link rel="stylesheet"
		href="https://formden.com/static/cdn/bootstrap-iso.css" />

	<!--Font Awesome (added because you use icons in your prepend/append)-->
	<link rel="stylesheet"
		href="https://formden.com/static/cdn/font-awesome/4.4.0/css/font-awesome.min.css" />

	<!-- Inline CSS based on choices in "Settings" tab -->
	<style>
.bootstrap-iso .formden_header h2, .bootstrap-iso .formden_header p,
	.bootstrap-iso form {
	font-family: Arial, Helvetica, sans-serif;
	color: black
}

.bootstrap-iso form button, .bootstrap-iso form button:hover {
	color: white !important;
}

.asteriskField {
	color: red;
}
</style>

	<!-- HTML Form (wrapped in a .bootstrap-iso div) -->
	<div class="wrapper">
		<div class="sidebar" data-background-color="white"
			data-active-color="danger">

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
					<li class="active"><a href="TicketsBooked.jsp"> <i
							class="ti-panel"></i>
							<p>View all tickets booked</p>
					</a></li>
					<li><a href="AvailableSeats.jsp"> <i
							class="ti-view-list-alt"></i>
							<p>View all of available seat</p>
					</a></li>
					<li><a href="SearchAndFilter.jsp"> <i class="ti-text"></i>
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
						<a class="navbar-brand" href="#">View all tickets booked </a>
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







			<div class="bootstrap-iso">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-6 col-sm-6 col-xs-12">
							<form
								action="BookingManagementController?param=getTicketBookedAvailableByStartDate"
								class="form-horizontal" method="post">
								<br />
								<div class="form-group ">
									<label class="control-label col-sm-2 requiredField" for="date">
										Date <span class="asteriskField"> * </span>
									</label>
									<div class="col-sm-10">
										<div class="input-group">
											<div class="input-group-addon">
												<i class="fa fa-calendar"> </i>
											</div>

											<input class="form-control" id="dateStart" name="dateStart"
												value=<c:if test="${empty sessionScope.dateStart}"><%out.print(LocalDate.now());%></c:if>
												<c:if test="${not empty sessionScope.dateStart}"><c:out value="${sessionScope.dateStart}"></c:out></c:if>
												min="<%out.print(LocalDate.now());%>"
												max="<%out.print(LocalDate.now().plusMonths(1));%>"
												type="date" />
										</div>
										<button class="btn btn-primary " name="submit" type="submit">Submit</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>

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
										format : 'dd/mm/yyyy',
										container : container,
										todayHighlight : true,
										autoclose : true,
									})
								})
			</script>

			<div class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<div class="card">
								<div class="header">
									<h4 class="title">Tickets booked</h4>
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
											<c:if test="${empty ticketsBooked}">
												<%
												response.sendRedirect("BookingManagementController?param=getTicketBookedAvailableByStartDate&page=1");
												%>
											</c:if>
											<c:if test="${not empty ticketsBooked}">

												<c:set scope="request" var="nullList" value="-1" />

												<c:if test="${ticketsBooked != nullList}">
													<c:forEach items="${ticketsBooked}" var="listTB">
														<tr>
															<td><c:out value="${listTB.numberPlate}"></c:out></td>
															<td><c:out value="${listTB.customerName}"></c:out></td>
															<td><c:out value="${listTB.timeStart}"></c:out></td>
															<td><c:out value="${listTB.startPlace}"></c:out></td>
															<td><c:out value="${listTB.finishPlace}"></c:out></td>
															<td>
																<form action="BookingManagementController?param=cancelBooking" class="form-horizontal" method="post">
																	<button class="btn btn-outline-success my-2 my-sm-0"
																		name="bookingID" onclick="return confirm('Are you sure you want to cancel this Booked?')"
																		value="<c:out value="${listTB.booking_ID}"></c:out>"
																		type="submit">Cancel</button>
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
         									
         										<c:url value = "BookingManagementController?param=getTicketBookedAvailableByStartDate" var = "myURL">
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
					href="Tickets booked">VINH ĐẸP TRAI</a>
			</div>
		</div>
	</footer>
	
	

<!-- Modal Success Cancel Booked -->
  <div class="modal fade" id="success" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Success Message</h4>
        </div>
        <div class="modal-body">
          <p style="color: green">You canceled successfully!</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
  
 <!-- Modal Fail Cancel Booked -->
  <div class="modal fade" id="error" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Error Message</h4>
        </div>
        <div class="modal-body">
          <p style="color: red">You canceled Fail!</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
  
  

	<!-- Extra JavaScript/CSS added manually in "Settings" tab -->
	<!-- Include jQuery -->
	<script type="text/javascript"
		src="https://code.jquery.com/jquery-1.11.3.min.js"></script>

	<!-- Include Date Range Picker -->
	<script type="text/javascript"
		src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css" />

	<script>
		$(document).ready(
				function() {
					var date_input = $('input[name="date"]'); //our date input has the name "date"
					var container = $('.bootstrap-iso form').length > 0 ? $(
							'.bootstrap-iso form').parent() : "body";
					date_input.datepicker({
						format : 'dd/mm/yyyy',
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