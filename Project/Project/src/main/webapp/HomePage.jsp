<%@page import="edu.fa.model.Customer"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Booking Bus Ticket System</title>
<link rel="stylesheet" href="css/demo.css">
<link rel="stylesheet" href="css/header-second-bar.css">
<link rel="stylesheet"
	href="css/footer-distributed-with-address-and-phones.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="css/header-user-dropdown.css">
<link rel="stylesheet" href="css/login_resgister.css">
<link rel="stylesheet" href="css/SlideShow/slide.css">
<link rel="stylesheet" href="css/seating-chart.css">

</head>
<body <%if ((String) session.getAttribute("error") != null) {%>
			onload="errorLogin()"
		<%}
	if ((String) session.getAttribute("wrongPlace") != null) {%>
			onload="wrongPlace()"
		<%
			session.removeAttribute("wrongPlace");
		}
	if ((String) session.getAttribute("bookedsuccess") != null) {%>
		onload="bookedSuccess()"
	<%
		session.removeAttribute("bookedsuccess");
	}
	if ((String) session.getAttribute("nullSeatList") != null) {%>
		onload="nullSeatList()"
	<%
		session.removeAttribute("nullSeatList");
	}
	if ((String) session.getAttribute("errorReg") != null) {%>
			onload="errorReg()"
	<%}
		if (request.getAttribute("customerinfo") != null || (String) session.getAttribute("errorUpd") != null) {%>
			onload="changeInfo()" 
	<%}%>>
	
	
	<div id="wrapper">
		<header class="header-two-bars">

			<div class="header-first-bar">

				<div class="header-limiter">

					<h1>
						<a href="BookingTicketsController?param=loadPlaces">Bus<span>logo</span></a>
					</h1>

					<nav>
						<a href="BookingTicketsController?param=loadPlaces"
							class="selected" onclick="backHome()">HOME</a> <a href="#">SCHEDULE</a>
						<a href="#">Reports</a>
					</nav>
					<%
						if (session.getAttribute("customername") == null) {
					%>
					<a href="#"
						onclick="document.getElementById('id02').style.display='block'"
						class="logout-button">Register</a> <a href="#"
						onclick="document.getElementById('id01').style.display='block'"
						class="logout-button">Log In</a> <a href="Login.jsp"
						class="logout-button">Bus Management</a>
					<%
						} else {
					%>
					<div class="header-user-dropdown">
						<div class="header-limiter">
							<div class="header-user-menu">
								<img src="img/logo_user.png" alt="User Image" />
								<p>
									<%
										out.print(session.getAttribute("customername"));
									%>
								</p>
								<ul>
									<li><a href="ChangeInfoController?param=loadInfoCustomer">Profile</a></li>
									<li><a href="MyBooking.jsp">My Booking</a></li>
									<li><a href="LoginController?param=logout"
										class="highlight">Logout</a></li>
								</ul>
							</div>
						</div>
					</div>
					<%
						}
					%>
				</div>
			</div>


			<!-- Login -->
			<div id="id01" class="modal">

				<form class="modal-content animate" method="POST"
					action="LoginController?param=login">
					<div class="imgcontainer">
						<span
							onclick="document.getElementById('id01').style.display='none'"
							class="close" title="Close Modal">&times;</span> <img
							src="img/logo_user.png" alt="AvatarLogin" class="avatar">
					</div>

					<div class="container">
						<%
							if ((String) session.getAttribute("error") != null) {
						%>
						<h4 style="color: red">
							<%
								out.print((String) session.getAttribute("error"));
							 	session.removeAttribute("error");
							%>
						</h4>
						<%
							}
						%>
						<label for="username"><b>User Name</b></label> <input type="text"
							placeholder="Enter Username" name="username" required> <label
							for="password"><b>Password</b></label> <input type="password"
							placeholder="Enter Password" name="password" required>

						<button type="submit">Login</button>
						<label> <input type="checkbox" checked="checked"
							name="remember"> Remember me
						</label>
					</div>

					<div class="container" style="background-color: #f1f1f1">
						<button type="button"
							onclick="document.getElementById('id01').style.display='none'"
							class="cancelbtn">Cancel</button>
						<span class="psw">Forgot <a href="#">password?</a></span>
					</div>
				</form>
			</div>


			<!-- Resgister -->
			<div id="id02" class="modal">

				<form class="modal-content animate" method="POST"
					action="RegisterController?param=register">
					<div class="imgcontainer">
						<span
							onclick="document.getElementById('id02').style.display='none'"
							class="close" title="Close Modal">&times;</span> <img
							src="img/logo_user.png" alt="Avatar" class="avatar">
					</div>

					<div class="container">
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
						<label for="fullname"><b>Full Name</b></label> <input type="text"
							placeholder="Enter Full Name" name="fullname" required> <label
							for="email"><b>Email</b></label> <input type="text"
							placeholder="Enter Email" name="email" required> <label
							for="phonenumber"><b>Phone Number</b></label> <input type="text"
							placeholder="Enter Phone Number" name="phonenumber" required>

						<label for="password"><b>Password</b></label> <input
							type="password" placeholder="Enter Password" name="password"
							required> <label for="repassword"><b>Re-Password</b></label>
						<input type="password" placeholder="Enter Password"
							name="repassword" required> <label for="address"><b>Address</b></label>
						<input type="text" placeholder="Enter Address" name="address"
							required>

						<button type="submit">Register</button>
						<!-- <label> <input type="checkbox" checked="checked" name="remember"> Remember me </label> -->
					</div>

					<div class="container" style="background-color: #f1f1f1">
						<button type="button"
							onclick="document.getElementById('id02').style.display='none'"
							class="cancelbtn">Cancel</button>
						<!-- <span class="psw">Forgot <a href="#">password?</a></span> -->
					</div>
				</form>
			</div>

			<!-- Update information -->
			<div id="id03" class="modal">

				<form class="modal-content animate" method="POST"
					action="ChangeInfoController?param=changeInfoCustomer">
					<div class="imgcontainer">
						<span
							onclick="document.getElementById('id03').style.display='none'"
							class="close" title="Close Modal">&times;</span> <img
							src="img/logo_user.png" alt="Avatar" class="avatar">
					</div>

					<div class="container">
						<%
							if ((String) session.getAttribute("errorUpd") != null) {
						%>
						<h4 style="color: red">
							<%
								out.print(session.getAttribute("errorUpd"));
					 			session.removeAttribute("errorUpd");
							%>
						</h4>
						<%
							}
						%>

						<%
							if (request.getAttribute("customerinfo") != null) {
								Customer customer = (Customer) request.getAttribute("customerinfo");
								String name = customer.getFullName();
						%>

						<br /> <label for="fullname"><b>Full Name</b></label> <input
							type="text" placeholder="Enter Full Name" value="<%=name%>"
							name="fullname" required> <label for="email"><b>Email</b></label>
						<input type="text" placeholder="Enter Email"
							value="<%=customer.getEmail()%>" name="email" required> <label
							for="phonenumber"><b>Phone Number</b></label> <input type="text"
							placeholder="Enter Phone Number"
							value="<%=customer.getPhoneNumber()%>" name="phonenumber"
							required> <label for="password"><b>Password</b></label> <input
							type="password" placeholder="Enter Password"
							value="<%=customer.getPassword()%>" name="password" required>
						<label for="repassword"><b>Re-Password</b></label> <input
							type="password" placeholder="Enter Password"
							value="<%=customer.getPassword()%>" name="repassword" required>
						<label for="address"><b>Address</b></label> <input type="text"
							placeholder="Enter Address" value="<%=customer.getAddress()%>"
							name="address" required>
						<%
							}
						%>
						<button type="submit">Update</button>
					</div>

					<div class="container" style="background-color: #f1f1f1">
						<button type="button"
							onclick="document.getElementById('id03').style.display='none'"
							class="cancelbtn">Cancel</button>
						<!-- <span class="psw">Forgot <a href="#">password?</a></span> -->
					</div>
				</form>
			</div>

			<script>
				// Get the modal
				var modal1 = document.getElementById('id01');
				var modal2 = document.getElementById('id02');
				var modal2 = document.getElementById('id03');
				// When the user clicks anywhere outside of the modal, close it
				window.onclick = function(event) {
					if (event.target == modal1) {
						modal1.style.display = "none";
					}
					if (event.target == modal2) {
						modal2.style.display = "none";
					}
					if (event.target == modal3) {
						modal3.style.display = "none";
					}
				}

				//When error Login 
				function errorLogin() {
					document.getElementById('id01').style.display = "block";
				}

				//When error Resgister 
				function errorReg() {
					document.getElementById('id02').style.display = "block";
				}
				//Show table change Information
				function changeInfo() {
					document.getElementById('id03').style.display = "block";
				}
				
				// When choose wrong Start Placeand Finish Place
				function wrongPlace() {
					alert("Không tìm thấy tuyến bạn đã chọn");
				}
				
				// When User Booked tickets succefully
				function bookedSuccess() {
					alert("Chúc mừng bạn! Bạn đã đặt vé thành công...");
				}
				
				// When User was not choose any seat
				function nullSeatList() {
					alert("Bạn chưa chọn ghế nào để đặt. Vui lòng chọn ghế...");
				}
			</script>
		</header>






		<div
			style="background-color: white; margin-top: 5px; margin-bottom: 5px; margin-left: 10%; margin-right: 10%; height: 100%;">
			<div>
				<div>
					<img class="slides" src="img/TB_Slide_1.png" style="width: 100%">
					<img class="slides" src="img/TB_Slide_2.png" style="width: 100%">
					<img class="slides" src="img/TB_Slide_3.png" style="width: 100%">



				</div>
			</div>

			<!-- auto change img -->
			<script>
				var myIndex = 0;
				carousel();

				function carousel() {
					var i;
					var x = document.getElementsByClassName("slides");
					for (i = 0; i < x.length; i++) {
						x[i].style.display = "none";
					}
					myIndex++;
					if (myIndex > x.length) {
						myIndex = 1
					}
					x[myIndex - 1].style.display = "block";
					setTimeout(carousel, 5000); // Change image every 2 seconds
				}
			</script>
			<%
				if (session.getAttribute("timeList") == null && request.getAttribute("bookedseats") == null) {
			%>


			<c:import url="/BookingTicketsController?param=loadPlaces" />

			<div
				style="margin: 20px; display: block; overflow: auto; background-color: #f2f2f2;"
				id="bookStart" style="margin: 20px; display: block;">
				<h1 align="center" style="align-items: center; margin-bottom: 5px;">BOOKING
					ONLINE</h1>
				<hr style="margin-right: 10%; margin-left: 10%;">
				<form
					action="BookingTicketsController?param=getTimeByPlaceDateAmount"
					method="POST">
					<div style="margin-right: 30%; margin-left: 30%;">
						<label for="Cb_start"><b style="font-size: 15px;">START
								PLACE</b></label>
						<div class="input-group">
							<select name="startplace"
								class="select2 form-control select2-hidden-accessible"
								style="font-size: 15px; width: 100%; padding: 12px 20px; margin: 8px 0; display: inline-block; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box;"
								id="Cb_start" tabindex="-1" aria-hidden="true">
								<c:forEach items="${placeList}" var="place">
									<option value="<c:out value="${place.place_ID}"></c:out>">
										<c:out value="${place.placeName}"></c:out></option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="col-md-3" style="margin-right: 30%; margin-left: 30%;">
						<label for="Cb_finish"><b style="font-size: 15px;">FINISH
								PLACE</b></label>
						<div class="input-group">
							<select name="finishplace" class="select2 form-control select2-hidden-accessible"
								style="font-size: 15px; width: 100%; padding: 12px 20px; margin: 8px 0; display: inline-block; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box;"
								id="Cb_finish" tabindex="-1" aria-hidden="true">
								<c:forEach items="${placeList}" var="place">
									<option value="<c:out value="${place.place_ID}"></c:out>">
										<c:out value="${place.placeName}"></c:out></option>
								</c:forEach>
							</select>

						</div>
					</div>
					<div class="col-md-3" style="margin-right: 30%; margin-left: 30%;">
						<label for="Txt_Num"><b style="font-size: 15px;">DATE START</b></label>
						<div class="input-group">
							<input name="datestart"
								class="select2 form-control select2-hidden-accessible"
								type="date"
								style="font-size: 15px; padding: 12px 20px; margin: 8px 0; display: inline-block; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box;"
								name="myDate" id="myDate">
						</div>
					</div>
					<div style="margin-right: 30%; margin-left: 30%;">
						<label for="Txt_Num"><b style="font-size: 15px;">AMOUNT</b></label>
						<div>
							<select
								style="font-size: 15px; padding: 12px 20px; margin: 8px 0; display: inline-block; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box;"
								name="amount" id="Txt_Num" tabindex="-1" aria-hidden="true">
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
							</select>

						</div>
					</div>

					<div style="margin-right: 30%; margin-left: 30%;"
						style="padding-top: 30px; width: 20%; margin-top: 10px;">
						<button type="submit">NEXT</button>
					</div>
				</form>
			</div>
			<%
				} else {
			%>
			<!-- BOOKING SEAT  -->
			<div id="bookSeat"
				style="margin: 20px; display: block; overflow: auto;">




				<div class="book-step" style="width: 100%; height: 100%;"
					id="div_Step3">
					<h2 class="header" style="width: 100%;" align="center">Chọn
						ghế</h2>
					<div class="row" style="width: 100%; overflow: auto;">
						<div style="width: 35%; margin: 5px; float: left;">
							<div class="row">
								<div class="col-md-12 form-group">
									<span id="sp_Title">Từ <c:if test="${startplace == 1}">TP.Hồ Chí Minh</c:if>
										<c:if test="${startplace == 2}">Lâm Đồng</c:if> đến <c:if
											test="${finishplace == 1}">TP.Hồ Chí Minh</c:if> <c:if
											test="${finishplace == 2}">Lâm Đồng</c:if> ngày <c:out
											value="${datestart}"></c:out></span>
								</div>
							</div>
							<div class="row">
								<div id="Cb_ChuyenXe" class="col-md-12 form-group">
									<label for="Cb_ChuyenXe">Chọn chuyến xe</label>
									<div>
										<form action="BookingTicketsController?param=getBookedSeatsByPlaceTimeDate" method="POST">
											<input type="hidden" name="typeBus" id="typeBus" value="<c:out value="${typeBus}"></c:out>"> 
											<input type="hidden" name="number" id="number" value="<c:out value="${schedule_id}"></c:out>"> 
											
											<select name="schedule_id" id="schedule_id">
												<option disabled selected value> -- Vui lòng chọn tuyến xe bạn muốn đi -- </option>
												<c:forEach items="${timeList}" var="list">
													<option id="<c:out value="${list.schedule_ID}"></c:out>" value="<c:out value="${list.schedule_ID}"></c:out>" data-type-bus="<c:out value="${list.typeBus}"></c:out>"
													<c:if test="${list.schedule_ID == schedule_id}">
														selected
													</c:if>
													>
														<c:out value="${list.typeBus}"></c:out> -
														<c:out value="${list.timeStart}"></c:out>
													</option>
												</c:forEach>
												
											</select> 
											<input type="hidden" id="datestart" name="datestart" value="<c:out value="${datestart}"></c:out>">
											<button type="submit">GET</button>
										</form>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12 form-group">
									<br> <label for="Txt_Note">Yêu cầu</label>
									<div>
										<form action="BookingTicketsController?param=bookingSeats" name="bookseat" method="post">
											<input type="text" id="Txt_Note" name="decription"
												placeholder="Vd: có kèm trẻ em" class="form-control">
									</div>
								</div>
							</div>

							<!-- <div style="padding-top: 30px;">
								<div class="pull-right">
									<a href="http://thanhbuoibus.com.vn/Booking/#"
										class="btn btn-default green btn-step" data-step="4"
										style="margin-left: 10px;" id="Bt_DatGhe">Hoàn tất chọn
										ghế <i class="fa fa-angle-right"></i>
									</a> <a href="http://thanhbuoibus.com.vn/Booking/#"
										class="btn btn-default green btn-step" data-step="1"
										data-validate="0" style="margin-left: 10px;">Trở lại</a> <a
										href="http://thanhbuoibus.com.vn/Booking/"
										class="btn btn-default green" style="margin-left: 10px;"
										id="Bt_Cancel">Hủy</a>
								</div>
							</div> -->
							<div class="clearfix"></div>
							<div style="margin-top: 30px;">
								<div class="plane">
									<div class="row">
										<h3>Ghi chú</h3>
									</div>
									<div class="row">
										<div class="col-xs-12 form-group">Click vào sơ đồ ghế để
											chọn/bỏ chọn ghế</div>
									</div>
									<ol class="seats">
										<li class="seat"><input type="checkbox" id="a" /> <label
											for="a">&nbsp</label></li>
										<li style="margin-top: 10px;">Ghế trống</li>
									</ol>
									<ol class="seats">
										<li class="seat"><input type="checkbox" disabled id="b" />
											<label for="b">&nbsp</label></li>
										<li style="margin-top: 10px;">Ghế đã có khách</li>
									</ol>
									<ol class="seats">
										<li class="seat"><input type="checkbox" checked="checked"
											id="c" /> <label for="c">&nbsp</label></li>
										<li style="margin-top: 10px;">Ghế đã chọn</li>
									</ol>

								</div>
							</div>
						</div>
						<div style="width: 30%; float: left; margin: 5px; height: 100%;">
							<div id="div_chart">

								<div class="seating-chart" style="overflow: auto;">



									<c:if test="${typeBus == 'Giường Nằm'}">
										<div class="row">
											<div class="col-2 driver" style="float: left;">
												<div>Lái xe</div>
											</div>
											<div style="width: 30%; float: right;" class="col-2 door">
												<div>Cửa lên</div>
											</div>
										</div>
										<br>
										<div class="chart-title" align="center">Tầng dưới</div>
										<div class="plane">

											<ol class="seats" type="A">
												<li class="seat"><input type="checkbox" name="checkbox"
													value="1"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 1}">
													disabled
												</c:if>
											</c:forEach>
													id="1" /> <label for="1">1</label></li>


												<li class="seat"></li>

												<li class="seat"><input type="checkbox" name="checkbox"
													value="18"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 18}">
													disabled
												</c:if>
											</c:forEach>
													id="18" /> <label for="18">18</label></li>

												<li class="seat"></li>

												<li class="seat"><input type="checkbox" name="checkbox"
													value="17"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 17}">
													disabled
												</c:if>
											</c:forEach>
													id="17" /> <label for="17">17</label></li>

											</ol>


											<ol class="seats" type="A">
												<li class="seat"><input type="checkbox" name="checkbox"
													value="2"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 2}">
													disabled
												</c:if>
											</c:forEach>
													id="2" /> <label for="2">2</label></li>
												<li class="seat"></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="19"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 19}">
													disabled
												</c:if>
											</c:forEach>
													id="19" /> <label for="19">19</label></li>
												<li class="seat"></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="16"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 16}">
													disabled
												</c:if>
											</c:forEach>
													id="16" /> <label for="16">16</label></li>
											</ol>


											<ol class="seats" type="A">
												<li class="seat"><input type="checkbox" name="checkbox"
													value="3"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 3}">
													disabled
												</c:if>
											</c:forEach>
													id="3" /> <label for="3">3</label></li>
												<li class="seat"></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="20"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 20}">
													disabled
												</c:if>
											</c:forEach>
													id="20" /> <label for="20">20</label></li>
												<li class="seat"></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="15"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 15}">
													disabled
												</c:if>
											</c:forEach>
													id="15" /> <label for="15">15</label></li>
											</ol>

											<ol class="seats" type="A">
												<li class="seat"><input type="checkbox" name="checkbox"
													value="4"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 4}">
													disabled
												</c:if>
											</c:forEach>
													id="4" /> <label for="4">4</label></li>
												<li class="seat"></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="21"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 21}">
													disabled
												</c:if>
											</c:forEach>
													id="21" /> <label for="21">21</label></li>
												<li class="seat"></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="14"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 14}">
													disabled
												</c:if>
											</c:forEach>
													id="14" /> <label for="14">14</label></li>
											</ol>

											<ol class="seats" type="A">
												<li class="seat"><input type="checkbox" name="checkbox"
													value="5"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 5}">
													disabled
												</c:if>
											</c:forEach>
													id="5" /> <label for="5">5</label></li>
												<li class="seat"></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="22"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 22}">
													disabled
												</c:if>
											</c:forEach>
													id="22" /> <label for="22">22</label></li>
												<li class="seat"></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="13"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 13}">
													disabled
												</c:if>
											</c:forEach>
													id="13" /> <label for="13">13</label></li>
											</ol>

											<ol class="seats" type="A">
												<li class="seat"><input type="checkbox" name="checkbox"
													value="6"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 6}">
													disabled
												</c:if>
											</c:forEach>
													id="6" /> <label for="6">6</label></li>
												<li class="seat"></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="23"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 23}">
													disabled
												</c:if>
											</c:forEach>
													id="23" /> <label for="23">23</label></li>
												<li class="seat"></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="12"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 12}">
													disabled
												</c:if>
											</c:forEach>
													id="12" /> <label for="12">12</label></li>
											</ol>

											<ol class="seats" type="A">
												<li class="seat"><input type="checkbox" name="checkbox"
													value="7"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 7}">
													disabled
												</c:if>
											</c:forEach>
													id="7" /> <label for="7">7</label></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="8"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 8}">
													disabled
												</c:if>
											</c:forEach>
													id="8" /> <label for="8">8</label></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="9"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 9}">
													disabled
												</c:if>
											</c:forEach>
													id="9" /> <label for="9">9</label></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="10"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 10}">
													disabled
												</c:if>
											</c:forEach>
													id="10" /> <label for="10">10</label></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="11"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 11}">
													disabled
												</c:if>
											</c:forEach>
													id="11" /> <label for="11">11</label></li>
											</ol>

										</div>

										<br>
										<div class="chart-title" align="center">Tầng trên</div>

										<div class="plane">

											<ol class="seats" type="A">
												<li class="seat"><input type="checkbox" name="checkbox"
													value="24"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 24}">
													disabled
												</c:if>
											</c:forEach>
													id="24" /> <label for="24">24</label></li>
												<li class="seat"></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="41"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 41}">
													disabled
												</c:if>
											</c:forEach>
													id="41" /> <label for="41">41</label></li>
												<li class="seat"></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="40"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 40}">
													disabled
												</c:if>
											</c:forEach>
													id="40" /> <label for="40">40</label></li>

											</ol>


											<ol class="seats" type="A">
												<li class="seat"><input type="checkbox" name="checkbox"
													value="25"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 25}">
													disabled
												</c:if>
											</c:forEach>
													id="25" /> <label for="25">25</label></li>
												<li class="seat"></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="42"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 42}">
													disabled
												</c:if>
											</c:forEach>
													id="42" /> <label for="42">42</label></li>
												<li class="seat"></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="39"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 39}">
													disabled
												</c:if>
											</c:forEach>
													id="39" /> <label for="39">39</label></li>
											</ol>


											<ol class="seats" type="A">
												<li class="seat"><input type="checkbox" name="checkbox"
													value="26"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 26}">
													disabled
												</c:if>
											</c:forEach>
													id="26" /> <label for="26">26</label></li>
												<li class="seat"></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="43"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 43}">
													disabled
												</c:if>
											</c:forEach>
													id="43" /> <label for="43">43</label></li>
												<li class="seat"></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="38"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 38}">
													disabled
												</c:if>
											</c:forEach>
													id="38" /> <label for="38">38</label></li>
											</ol>

											<ol class="seats" type="A">
												<li class="seat"><input type="checkbox" name="checkbox"
													value="27"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 27}">
													disabled
												</c:if>
											</c:forEach>
													id="27" /> <label for="27">27</label></li>
												<li class="seat"></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="44"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 44}">
													disabled
												</c:if>
											</c:forEach>
													id="44" /> <label for="44">44</label></li>
												<li class="seat"></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="37"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 37}">
													disabled
												</c:if>
											</c:forEach>
													id="37" /> <label for="37">37</label></li>
											</ol>

											<ol class="seats" type="A">
												<li class="seat"><input type="checkbox" name="checkbox"
													value="28"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats ==28}">
													disabled
												</c:if>
											</c:forEach>
													id="28" /> <label for="28">28</label></li>
												<li class="seat"></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="45"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 45}">
													disabled
												</c:if>
											</c:forEach>
													id="45" /> <label for="45">45</label></li>
												<li class="seat"></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="36"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 36}">
													disabled
												</c:if>
											</c:forEach>
													id="36" /> <label for="36">36</label></li>
											</ol>

											<ol class="seats" type="A">
												<li class="seat"><input type="checkbox" name="checkbox"
													value="29"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 29}">
													disabled
												</c:if>
											</c:forEach>
													id="29" /> <label for="29">29</label></li>
												<li class="seat"></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="46"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 46}">
													disabled
												</c:if>
											</c:forEach>
													id="46" /> <label for="46">46</label></li>
												<li class="seat"></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="35"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 35}">
													disabled
												</c:if>
											</c:forEach>
													id="35" /> <label for="35">35</label></li>
											</ol>

											<ol class="seats" type="A">
												<li class="seat"><input type="checkbox" name="checkbox"
													value="30"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 30}">
													disabled
												</c:if>
											</c:forEach>
													id="30" /> <label for="30">30</label></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="31"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 31}">
													disabled
												</c:if>
											</c:forEach>
													id="31" /> <label for="31">31</label></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="32"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 32}">
													disabled
												</c:if>
											</c:forEach>
													id="32" /> <label for="32">32</label></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="33"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 33}">
													disabled
												</c:if>
											</c:forEach>
													id="33" /> <label for="33">33</label></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="34"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 34}">
													disabled
												</c:if>
											</c:forEach>
													id="34" /> <label for="34">34</label></li>
											</ol>

										</div>
									</c:if>

									<c:if test="${typeBus == 'Ghế Ngồi'}">
										<div class="row">
											<div class="col-2 driver" style="float: left;">
												<div>Lái xe</div>
											</div>
											<div style="width: 30%; float: right;" class="col-2 door">
												<div>Cửa lên</div>
											</div>
										</div>
										<br>
										<br>
										<div class="plane">
											<ol class="seats" type="A">
												<li class="seat"><input type="checkbox" name="checkbox"
													value="1"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 1}">
													disabled
												</c:if>
											</c:forEach>
													id="1" /> <label for="1">1</label></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="2"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 2}">
													disabled
												</c:if>
											</c:forEach>
													id="2" /> <label for="2">2</label></li>
												<li class="seat"></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="3"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 3}">
													disabled
												</c:if>
											</c:forEach>
													id="3" /> <label for="3">3</label></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="4"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 4}">
													disabled
												</c:if>
											</c:forEach>
													id="4" /> <label for="4">4</label></li>
											</ol>
											<ol class="seats" type="A">
												<li class="seat"><input type="checkbox" name="checkbox"
													value="5"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 5}">
													disabled
												</c:if>
											</c:forEach>
													id="5" /> <label for="5">5</label></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="6"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 6}">
													disabled
												</c:if>
											</c:forEach>
													id="6" /> <label for="6">6</label></li>
												<li class="seat"></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="7"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 7}">
													disabled
												</c:if>
											</c:forEach>
													id="7" /> <label for="7">7</label></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="8"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 8}">
													disabled
												</c:if>
											</c:forEach>
													id="8" /> <label for="8">8</label></li>
											</ol>
											<ol class="seats" type="A">
												<li class="seat"><input type="checkbox" name="checkbox"
													value="9"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 9}">
													disabled
												</c:if>
											</c:forEach>
													id="9" /> <label for="9">9</label></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="10"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 10}">
													disabled
												</c:if>
											</c:forEach>
													id="10" /> <label for="10">10</label></li>
												<li class="seat"></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="11"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 11}">
													disabled
												</c:if>
											</c:forEach>
													id="11" /> <label for="11">11</label></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="12"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 12}">
													disabled
												</c:if>
											</c:forEach>
													id="12" /> <label for="12">12</label></li>
											</ol>
											<ol class="seats" type="A">
												<li class="seat"><input type="checkbox" name="checkbox"
													value="13"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 13}">
													disabled
												</c:if>
											</c:forEach>
													id="13" /> <label for="13">13</label></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="14"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 14}">
													disabled
												</c:if>
											</c:forEach>
													id="14" /> <label for="14">14</label></li>
												<li class="seat"></li>
												<li class="seat"></li>
												<li class="seat"></li>
											</ol>
											<ol class="seats" type="A">
												<li class="seat"><input type="checkbox" name="checkbox"
													value="15"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 15}">
													disabled
												</c:if>
											</c:forEach>
													id="15" /> <label for="15">15</label></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="16"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 16}">
													disabled
												</c:if>
											</c:forEach>
													id="16" /> <label for="16">16</label></li>
												<li class="seat"></li>
												<li class="seat"></li>
												<li class="seat"></li>
											</ol>
											<ol class="seats" type="A">
												<li class="seat"><input type="checkbox" name="checkbox"
													value="17"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 17}">
													disabled
												</c:if>
											</c:forEach>
													id="17" /> <label for="17">17</label></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="18"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 18}">
													disabled
												</c:if>
											</c:forEach>
													id="18" /> <label for="18">18</label></li>
												<li class="seat"></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="19"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 19}">
													disabled
												</c:if>
											</c:forEach>
													id="19" /> <label for="19">19</label></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="20"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 20}">
													disabled
												</c:if>
											</c:forEach>
													id="20" /> <label for="20">20</label></li>
											</ol>
											<ol class="seats" type="A">
												<li class="seat"><input type="checkbox" name="checkbox"
													value="21"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 21}">
													disabled
												</c:if>
											</c:forEach>
													id="21" /> <label for="21">21</label></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="22"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 22}">
													disabled
												</c:if>
											</c:forEach>
													id="22" /> <label for="22">22</label></li>
												<li class="seat"></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="23"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 23}">
													disabled
												</c:if>
											</c:forEach>
													id="23" /> <label for="23">23</label></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="24"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 24}">
													disabled
												</c:if>
											</c:forEach>
													id="24" /> <label for="24">24</label></li>
											</ol>
											<ol class="seats" type="A">
												<li class="seat"><input type="checkbox" name="checkbox"
													value="25"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 25}">
													disabled
												</c:if>
											</c:forEach>
													id="25" /> <label for="25">25</label></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="26"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 26}">
													disabled
												</c:if>
											</c:forEach>
													id="26" /> <label for="26">26</label></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="27"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 27}">
													disabled
												</c:if>
											</c:forEach>
													id="27" /> <label for="27">27</label></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="28"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 28}">
													disabled
												</c:if>
											</c:forEach>
													id="28" /> <label for="28">28</label></li>
												<li class="seat"><input type="checkbox" name="checkbox"
													value="29"
													<c:forEach items="${bookedseats}" var="seats">
												<c:if test="${seats == 29}">
													disabled
												</c:if>
											</c:forEach>
													id="29" /> <label for="29">29</label></li>
											</ol>

										</div>
									</c:if>


								</div>
								<div align="center"
									style="margin-top: 10px; size: 20px; margin-left: 20%; margin-right: 20%;">
									<c:if test="${customername == null}">
										<h3> Bạn cần đăng nhập để đặt vé</h3>
										<button type="button" href="#" onclick="document.getElementById('id01').style.display='block'">Đăng nhập</button>
									</c:if>
									<c:if test="${customername != null}">
										<h3 id="finishbookseat1" style="display: block;">Bạn chưa chọn ghế</h3>
										<button id="finishbookseat" style="display: none;" type="submit" name="bookseat" value="Hoàn tất chọn ghế">
											<h3>Đặt vé</h3>
										</button>
									</c:if>
								</div>
								</form>
							</div>



							<!-- <div style="padding: 30px 0px;" class="hidden-md hidden-lg">
								<div>
									<a href="http://thanhbuoibus.com.vn/Booking/#"
										class="btn btn-default green btn-step" data-step="4"
										style="margin-left: 10px;" id="Bt_DatGhe2">Hoàn tất chọn
										ghế <i class="fa fa-angle-right"></i>
									</a> <a href="http://thanhbuoibus.com.vn/Booking/#"
										class="btn btn-default green btn-step" data-step="1"
										data-validate="0" style="margin-left: 10px;">Trở lại</a> <a
										href="http://thanhbuoibus.com.vn/Booking/"
										class="btn btn-default green" style="margin-left: 10px;">Hủy</a>
								</div>
							</div> -->

						</div>
						<div style="width: 30%; float: right; margin: 5px;">
							<div class="well">
								<h2 class="header-1">Thông tin</h2>
								<div class="form-horizontal" id="frm_Info">
									<div class="form-group">
										<label class="control-label col-sm-4"><h3>Họ và tên: </h3></label>
										<div class="col-sm-8">
											<p style="margin-left: 30px;" class="form-control-static red" id="Lb_HoTen">
												<c:if test="${customername == null }">Chưa đăng nhập</c:if>
												<c:if test="${customername != null }">
													<c:out value="${customername}"></c:out>
												</c:if>
											</p>
										</div>
									</div>

									<div class="form-group">
										<label class="control-label col-sm-4"><h3>Điểm lên xe:</h3></label>
										<div class="col-sm-8">
											<p style="margin-left: 30px;" class="form-control-static"
												id="Lb_DiemLen">
												<c:if test="${startplace == 1}">TP.Hồ Chí Minh</c:if>
												<c:if test="${startplace == 2}">Lâm Đồng</c:if>
											</p>
										</div>
									</div>
									<div class="form-group">
										<label class="control-label col-sm-4"><h3>Điểm đến:</h3></label>
										<div class="col-sm-8">
											<p style="margin-left: 30px;" class="form-control-static red"
												id="Lb_DiemDen">
												<c:if test="${finishplace == 1}">TP.Hồ Chí Minh</c:if>
												<c:if test="${finishplace == 2}">Lâm Đồng</c:if>
											</p>
										</div>
									</div>
									<div class="form-group">
										<label class="control-label col-sm-4"><h3>Thời gian:</h3></label>
										<div class="col-sm-8">
											<p style="margin-left: 30px;" class="form-control-static"
												id="Lb_ThoiGian">
												<c:out value="${datestart}"></c:out>
											</p>
										</div>
									</div>
									<!-- <div class="form-group">
										<label class="control-label col-sm-4"><h3>Số ghế: </h3></label>
										<div class="col-sm-8">
											<p style="margin-left: 30px;" class="form-control-static"
												id="Lb_SoGhe"></p>
										</div>
									</div> -->

								</div>
							</div>

						</div>
					</div>
				</div>





				<!-- <div style="padding-top: 30px; width: 100%; float: left;">
					<button style="width: 10%" type="button" onclick="next3();">NEXT</button>
					<button style="width: 10%" type="button" onclick="back1();">BACK</button>
				</div> -->

			</div>
			<%
				}
			%>
			<script>
				function next2() {
					document.getElementById("bookStart").style.display = "none";
					document.getElementById("bookSeat").style.display = "block";
				}
				function back1() {
					document.getElementById("bookStart").style.display = "block";
					document.getElementById("bookSeat").style.display = "none";
				}
				function next3() {

				}
				function backHome() {
					/* session.removeAttribute("timeList");
					session.removeAttribute("bookedseats"); */
				}
				function getTypeBus() {

				}
			</script>
			<!-- The content of your page would go here. -->
		</div>
		<footer class="footer-distributed">

			<div class="footer-left">

				<h3>
					Bus<span>logo</span>
				</h3>

				<p class="footer-links">
					<a href="#">Home</a> · <a href="#">Blog</a> · <a href="#">Pricing</a>
					· <a href="#">About</a> · <a href="#">Faq</a> · <a href="#">Contact</a>
				</p>

				<p class="footer-company-name">Company Name &copy; 2015</p>
			</div>

			<div class="footer-center">

				<div>
					<i class="fa fa-map-marker"></i>
					<p>
						<span>21 Revolution Street</span> Paris, France
					</p>
				</div>

				<div>
					<i class="fa fa-phone"></i>
					<p>+1 555 123456</p>
				</div>

				<div>
					<i class="fa fa-envelope"></i>
					<p>
						<a href="mailto:support@company.com">support@company.com</a>
					</p>
				</div>

			</div>

			<div class="footer-right">

				<p class="footer-company-about">
					<span>About the company</span> Lorem ipsum dolor sit amet,
					consectateur adispicing elit. Fusce euismod convallis velit, eu
					auctor lacus vehicula sit amet.
				</p>

				<div class="footer-icons">

					<a href="#" style="background-color: #3B5998;"><i
						class="fa fa-facebook"></i></a> <a href="#"
						style="background-color: #55ACEE;"><i class="fa fa-twitter"></i></a>
					<a href="#" style="background-color: #007bb5;"><i
						class="fa fa-linkedin"></i></a> <a href="#"
						style="background-color: #dd4b39;"><i class="fa fa-github"></i></a>

				</div>

			</div>

		</footer>
	</div>
	<script src="js/SlideShow/jquery-1.11.3.min.js.tải xuống"
		type="text/javascript"></script>
	<script src="js/SlideShow/bootstrap.js.tải xuống"
		type="text/javascript"></script>
	<script src="js/setSelectOption.js" type="text/javascript"></script>
</body>
</html>