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

<!--  Seat     -->
<link href="css/seatManagement.css" rel="stylesheet" />

<link
	href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css"
	rel="stylesheet">
<link href='https://fonts.googleapis.com/css?family=Muli:400,300'
	rel='stylesheet' type='text/css'>
<link href="assets/css/themify-icons.css" rel="stylesheet">
<link href="css/searchSeat.css" rel="stylesheet">

<script type="text/javascript">
	function show_alert_success() {
		alert("Successfully");
	}
	//When error Resgister 
	function infoBookedSeat() {
		$(window).on('load', function() {
			$('#exampleModal').modal('show');
		});
	}
	function showNewBooking() {
		$(window).on('load', function() {
			$('#createNewBooking').modal('show');
		});
	}

</script>


</head>
<body
	<%if ((String) session.getAttribute("employeefirstname") == null) {
		response.sendRedirect("Login.jsp");
	}
	if (session.getAttribute("bookinginfo") != null) {%>
		onload="infoBookedSeat()" 
	<%}
	if (session.getAttribute("SeatEmpty") != null || session.getAttribute("errorReg") != null) {%>
			onload="showNewBooking()"
	<%}%>>





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
					<li><a href="TicketsBooked.jsp"> <i class="ti-panel"></i>
							<p>View all tickets booked</p>
					</a></li>
					<li class="active"><a href="AvailableSeats.jsp"> <i
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
						<a class="navbar-brand" href="#">View all of available seats </a>
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
								action="BookingTicketsController?param=getBookedSeatsByPlaceTimeDate"
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

											<input class="form-control" id="datestart" name="datestart"
												value=<c:if test="${empty datestart}"><%out.print(LocalDate.now());%></c:if>
												<c:if test="${not empty datestart}"><c:out value="${datestart}"></c:out></c:if>
												min="<%out.print(LocalDate.now());%>"
												max="<%out.print(LocalDate.now().plusMonths(1));%>"
												type="date" />
										</div>

										<c:import
											url="/BookingManagementController?param=loadSchedules" />

										<select class="form-control" name="schedule_id">
											<c:forEach items="${scheduleList}" var="list">
												<option value="<c:out value="${list.schedule_ID}"></c:out>"
													<c:if test="${schedule_id == list.schedule_ID}">selected</c:if>>
													<c:out value="${list.timeStart}"></c:out>
													<c:out value="${list.startPlace}"></c:out>
													<c:out value=" - "></c:out>
													<c:out value="${list.finishPlace}"></c:out>
													<c:out value="${list.numberPlate}"></c:out>
													<c:out value="${list.busType}"></c:out>
												</option>
											</c:forEach>
										</select> <br>
										<div align="right">
											<button class="btn btn-primary" name="button" value="manager"
												type="submit">Submit</button>
										</div>
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
									<h4 class="title">SEAT CHART</h4>
									<p class="category">Seat chart of your choose</p>
								</div>
								<div class="content table-responsive table-full-width">



									<c:if test="${not empty seatList}">

										<c:if test="${busType == 1}">
											<div class="plane">

												<ol class="seats" type="A">
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="1"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 1}">
																		style="background: red"
																	</c:if>
																</c:forEach>>01</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="18"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 18}">
																		style="background: red"
																	</c:if>
																</c:forEach>>18</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="17"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 17}">
																		style="background: red"
																	</c:if>
																</c:forEach>>17</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="24"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 24}">
																		style="background: red"
																	</c:if>
																</c:forEach>>24</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="41"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 41}">
																		style="background: red"
																	</c:if>
																</c:forEach>>41</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="40"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 40}">
																		style="background: red"
																	</c:if>
																</c:forEach>>40</button>
														</form>
													</li>

												</ol>


												<ol class="seats" type="A">
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="2"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 2}">
																		style="background: red"
																	</c:if>
																</c:forEach>>02</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="19"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 19}">
																		style="background: red"
																	</c:if>
																</c:forEach>>19</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="16"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 16}">
																		style="background: red"
																	</c:if>
																</c:forEach>>16</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="25"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 25}">
																		style="background: red"
																	</c:if>
																</c:forEach>>25</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="42"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 42}">
																		style="background: red"
																	</c:if>
																</c:forEach>>42</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="39"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 39}">
																		style="background: red"
																	</c:if>
																</c:forEach>>39</button>
														</form>
													</li>
												</ol>


												<ol class="seats" type="A">
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="3"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 3}">
																		style="background: red"
																	</c:if>
																</c:forEach>>03</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="20"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 20}">
																		style="background: red"
																	</c:if>
																</c:forEach>>20</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="15"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 15}">
																		style="background: red"
																	</c:if>
																</c:forEach>>15</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="26"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 26}">
																		style="background: red"
																	</c:if>
																</c:forEach>>26</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="43"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 43}">
																		style="background: red"
																	</c:if>
																</c:forEach>>43</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="38"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 38}">
																		style="background: red"
																	</c:if>
																</c:forEach>>38</button>
														</form>
													</li>
												</ol>

												<ol class="seats" type="A">
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="4"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 4}">
																		style="background: red"
																	</c:if>
																</c:forEach>>04</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="21"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 21}">
																		style="background: red"
																	</c:if>
																</c:forEach>>21</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="14"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 14}">
																		style="background: red"
																	</c:if>
																</c:forEach>>14</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="27"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 27}">
																		style="background: red"
																	</c:if>
																</c:forEach>>27</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="44"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 44}">
																		style="background: red"
																	</c:if>
																</c:forEach>>44</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="37"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 37}">
																		style="background: red"
																	</c:if>
																</c:forEach>>37</button>
														</form>
													</li>
												</ol>

												<ol class="seats" type="A">
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="5"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 5}">
																		style="background: red"
																	</c:if>
																</c:forEach>>05</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="22"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 22}">
																		style="background: red"
																	</c:if>
																</c:forEach>>22</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="13"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 13}">
																		style="background: red"
																	</c:if>
																</c:forEach>>13</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="28"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 28}">
																		style="background: red"
																	</c:if>
																</c:forEach>>28</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="45"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 45}">
																		style="background: red"
																	</c:if>
																</c:forEach>>45</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="36"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 36}">
																		style="background: red"
																	</c:if>
																</c:forEach>>36</button>
														</form>
													</li>
												</ol>

												<ol class="seats" type="A">
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="6"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 6}">
																		style="background: red"
																	</c:if>
																</c:forEach>>06</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="23"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 23}">
																		style="background: red"
																	</c:if>
																</c:forEach>>23</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="12"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 12}">
																		style="background: red"
																	</c:if>
																</c:forEach>>12</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="29"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 29}">
																		style="background: red"
																	</c:if>
																</c:forEach>>29</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="46"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 46}">
																		style="background: red"
																	</c:if>
																</c:forEach>>46</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="35"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 35}">
																		style="background: red"
																	</c:if>
																</c:forEach>>35</button>
														</form>
													</li>
												</ol>

												<ol class="seats" type="A">
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="7"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 7}">
																		style="background: red"
																	</c:if>
																</c:forEach>>07</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="8"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 8}">
																		style="background: red"
																	</c:if>
																</c:forEach>>08</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="9"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 9}">
																		style="background: red"
																	</c:if>
																</c:forEach>>09</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="10"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 10}">
																		style="background: red"
																	</c:if>
																</c:forEach>>10</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="11"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 11}">
																		style="background: red"
																	</c:if>
																</c:forEach>>11</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="30"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 30}">
																		style="background: red"
																	</c:if>
																</c:forEach>>30</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="31"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 31}">
																		style="background: red"
																	</c:if>
																</c:forEach>>31</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="32"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 32}">
																		style="background: red"
																	</c:if>
																</c:forEach>>32</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="33"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 33}">
																		style="background: red"
																	</c:if>
																</c:forEach>>33</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="34"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 34}">
																		style="background: red"
																	</c:if>
																</c:forEach>>34</button>
														</form>
													</li>
												</ol>

												<script
													src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
											</div>
										</c:if>
										<c:if test="${busType == 2}">
											<div class="plane">

												<ol class="seats" type="A">
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="1"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 1}">
																		style="background: red"
																	</c:if>
																</c:forEach>>01</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="2"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 2}">
																		style="background: red"
																	</c:if>
																</c:forEach>>02</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="3"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 3}">
																		style="background: red"
																	</c:if>
																</c:forEach>>03</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="4"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 4}">
																		style="background: red"
																	</c:if>
																</c:forEach>>04</button>
														</form>
													</li>
													<li class="seat">
												</ol>

												<ol class="seats" type="A">
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="5"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 5}">
																		style="background: red"
																	</c:if>
																</c:forEach>>05</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="6"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 6}">
																		style="background: red"
																	</c:if>
																</c:forEach>>06</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="7"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 7}">
																		style="background: red"
																	</c:if>
																</c:forEach>>07</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="8"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 8}">
																		style="background: red"
																	</c:if>
																</c:forEach>>08</button>
														</form>
													</li>
													<li class="seat">
												</ol>

												<ol class="seats" type="A">
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="9"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 9}">
																		style="background: red"
																	</c:if>
																</c:forEach>>09</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="10"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 10}">
																		style="background: red"
																	</c:if>
																</c:forEach>>10</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="11"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 11}">
																		style="background: red"
																	</c:if>
																</c:forEach>>11</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="12"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 12}">
																		style="background: red"
																	</c:if>
																</c:forEach>>12</button>
														</form>
													</li>
													<li class="seat">
												</ol>

												<ol class="seats" type="A">
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="13"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 13}">
																		style="background: red"
																	</c:if>
																</c:forEach>>13</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="14"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 14}">
																		style="background: red"
																	</c:if>
																</c:forEach>>14</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat"></li>
													<li class="seat"></li>
													<li class="seat">
												</ol>

												<ol class="seats" type="A">
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="15"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 15}">
																		style="background: red"
																	</c:if>
																</c:forEach>>15</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="16"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 16}">
																		style="background: red"
																	</c:if>
																</c:forEach>>16</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat"></li>
													<li class="seat"></li>
													<li class="seat">
												</ol>

												<ol class="seats" type="A">
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="17"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 17}">
																		style="background: red"
																	</c:if>
																</c:forEach>>17</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="18"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 18}">
																		style="background: red"
																	</c:if>
																</c:forEach>>18</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="19"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 19}">
																		style="background: red"
																	</c:if>
																</c:forEach>>19</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="20"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 20}">
																		style="background: red"
																	</c:if>
																</c:forEach>>20</button>
														</form>
													</li>
													<li class="seat">
												</ol>

												<ol class="seats" type="A">
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="21"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 21}">
																		style="background: red"
																	</c:if>
																</c:forEach>>21</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="22"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 22}">
																		style="background: red"
																	</c:if>
																</c:forEach>>22</button>
														</form>
													</li>
													<li class="seat"></li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="23"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 23}">
																		style="background: red"
																	</c:if>
																</c:forEach>>23</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="24"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 24}">
																		style="background: red"
																	</c:if>
																</c:forEach>>24</button>
														</form>
													</li>
													<li class="seat">
												</ol>

												<ol class="seats" type="A">
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="25"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 25}">
																		style="background: red"
																	</c:if>
																</c:forEach>>25</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="26"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 26}">
																		style="background: red"
																	</c:if>
																</c:forEach>>26</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="27"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 27}">
																		style="background: red"
																	</c:if>
																</c:forEach>>27</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="28"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 28}">
																		style="background: red"
																	</c:if>
																</c:forEach>>28</button>
														</form>
													</li>
													<li class="seat">
														<form
															action="BookingManagementController?param=chooseSeat"
															method="post">
															<button type="submit" name="seat" value="29"
																<c:forEach items="${seatList}" var="seats">
																	<c:if test="${seats == 29}">
																		style="background: red"
																	</c:if>
																</c:forEach>>29</button>
														</form>
													</li>
													<li class="seat">
												</ol>

											</div>
											<script
												src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
										</c:if>
									</c:if>



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
						href="https://www.facebook.com/thuydx.98" target="_blank">THUY
						DAO XUAN</a>
				</div>
			</div>
		</footer>

		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">Booked
							Infomation</h5>
						<button type="button" class="close" data-dismiss="modal1"
							aria-label="Close">
							<span>&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form id="cancelbooking" method="POST"
							action="BookingManagementController?param=cancelBooking">

							<div class="form-group">
								<label for="fullname"><b>Customer Name: </b> <i
									style="color: red"><c:out value="${bookinginfo.fullName}"></c:out></i></label>
							</div>

							<div class="form-group">
								<label for="email"><b>Email: </b> <i style="color: red"><c:out
											value="${bookinginfo.email}"></c:out></i></label>
							</div>

							<div class="form-group">
								<label for="phonenumber"><b>Phone Number: </b><i
									style="color: red"><c:out
											value="${bookinginfo.phoneNumber}"></c:out></i></label>
							</div>

							<div class="form-group">
								<label for="address"><b>Address: </b><i
									style="color: red"><c:out value="${bookinginfo.address}"></c:out></i></label>
							</div>

							<div class="form-group">
								<label for="bookingdate"><b>Booking Date: </b><i
									style="color: red"><c:out
											value="${bookinginfo.bookingDate}"></c:out></i></label>
							</div>

							<div class="form-group">
								<label for="seat"><b>Seat(s) List: </b> <i
									style="color: red"> <c:forEach
											items="${bookinginfo.seatList}" var="seat">
											<c:out value="${seat}"></c:out>
										</c:forEach>
								</i> </label>

							</div>

							<div class="form-group">
								<label for="decription"><b>Decription: </b><i
									style="color: red"><c:out
											value="${bookinginfo.description}"></c:out></i></label>
							</div>
							<div class="modal-footer">
								<button type="submit" form="cancelbooking"
									class="btn btn-primary" name="bookingID"
									value='<c:out value="${bookinginfo.booking_ID}"></c:out>' onclick="return confirm('Are you sure you want to cancel this Booked?')"
									class="signupbtn1">Cancel Booking</button>

								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">Close</button>
								<%
									session.removeAttribute("bookinginfo");
									session.setAttribute("flagCalcelBooking", "AvailableSeats");
								%>
							</div>
						</form>
					</div>

				</div>
			</div>
		</div>


		<div class="modal fade" id="createNewBooking" tabindex="-1"
			role="dialog" aria-labelledby="exampleModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">Create new
							user</h5>
						<button type="button" class="close" data-dismiss="modal1"
							aria-label="Close">
							<span>&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form method="POST" action="RegisterController?param=register">
							<%
							if ((String) session.getAttribute("errorReg") != null) {
							%>
							<h4 style="color: red">
							<%
								out.print(session.getAttribute("errorReg"));
								session.removeAttribute("errorReg");
							%>
							</h4>
							<%
							}
							%>
							<div class="form-group">
								<!-- Name field -->
								<label class="control-label " for="fullname">Fullname</label> 
								<input class="form-control" id="fullname" name="fullname" type="text" />
							</div>
							<div class="form-group">
								<!-- Subject field -->
								<label class="control-label " for="email">Email</label> 
								<input class="form-control" id="email" name="email" type="text" />
							</div>

							<div class="form-group">
								<label class="control-label requiredField" for="phonenumber">Phone Number<span class="asteriskField">*</span>
								</label> <input class="form-control" id="phonenumber" name="phonenumber" type="text" />
							</div>
							<div class="form-group">
								<label class="control-label requiredField" for="address">Address<span class="asteriskField">*</span></label> 
								<input class="form-control" id="address" name="address" type="text" />
							</div>
							<div class="form-group">
								<label class="control-label requiredField" for="password">Password<span class="asteriskField">*</span></label> 
								<input class="form-control" id="password" name="password" type="password" />
							</div>
							<div class="form-group">
								<label class="control-label requiredField" for="repassword">Re-Password<span class="asteriskField">*</span></label> 
								<input class="form-control" id="repassword" name="repassword" type="password" />
							</div>
							<div class="modal-footer">
								<button class="btn btn-primary " name="button" value="AvailableSeats" type="submit">Booking</button>
								<button type="button" class="btn btn-secondary" data-dismiss="modal"  onclick=<%session.removeAttribute("SeatEmpty");%>>Close</button>
								
							</div>
						</form>
					</div>

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
		$(document).ready(
				function() {
					var date_input = $('input[name="date"]'); //our date input has the name "date"
					var container = $('.bootstrap-iso form').length > 0 ? $(
							'.bootstrap-iso form').parent() : "body";
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