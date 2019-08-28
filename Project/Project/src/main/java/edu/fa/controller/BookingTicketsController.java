package edu.fa.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import edu.fa.dao.BookingDAO;
import edu.fa.dao.BookingDAOImpl;
import edu.fa.dao.PlaceDAO;
import edu.fa.dao.PlaceDAOImpl;
import edu.fa.dao.TimeDAO;
import edu.fa.dao.TimeDAOImpl;
import edu.fa.model.Booking;
import edu.fa.model.BookingWeb;
import edu.fa.model.Place;
import edu.fa.model.Time;

public class BookingTicketsController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public BookingTicketsController() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("utf-8");

		if ("loadPlaces".equalsIgnoreCase(request.getParameter("param"))) {

			HttpSession session = request.getSession();

			PlaceDAO placeDAO = new PlaceDAOImpl();

			List<Place> placeList = placeDAO.getPlaces();

			request.setAttribute("placeList", placeList);

			session.removeAttribute("typeBus");
			session.removeAttribute("timeList");
			session.removeAttribute("bookedseats");

			response.sendRedirect("HomePage.jsp");

		} else {

			if ("loadBookedCustomer".equalsIgnoreCase(request.getParameter("param"))) {

				HttpSession session = request.getSession();

				if (session.getAttribute("customerid") == null) {
					session.setAttribute("error", "You must Login or Register before go to MY BOOKING!");
					response.sendRedirect("HomePage.jsp");
				} else {

					int pageid = 1;
					if (request.getParameter("page") != null)
						pageid = Integer.parseInt(request.getParameter("page"));

					BookingDAO bookingDAO = new BookingDAOImpl();

					List<BookingWeb> bookedList = bookingDAO
							.getBookedByCusIDPage((int) session.getAttribute("customerid"), pageid);

					if (bookedList.size() == 0) {
						request.setAttribute("BookedList", "-1");
						request.setAttribute("pageNumber", 0);
					}
					else {
						request.setAttribute("BookedList", bookedList);
						request.setAttribute("pageNumber", bookedList.get(0).getPageNumber());
					}

					request.setAttribute("pageActive", pageid);
					
					if(session.getAttribute("checkCancelBooking") != null)
					{
						request.setAttribute("checkCancelBooking", session.getAttribute("checkCancelBooking"));
						session.removeAttribute("checkCancelBooking");
					}

					RequestDispatcher dispatcher = request.getRequestDispatcher("/MyBooking.jsp");

					dispatcher.forward(request, response);
				}
			} else {
				if ("getBookedSeatsByPlaceTimeDate".equalsIgnoreCase(request.getParameter("param"))) {

					if (request.getParameter("button") == null) {

						HttpSession session = request.getSession();

						if (request.getParameter("schedule_id") == null) {
							response.sendRedirect("BookingTicketsController?param=loadPlaces");
						} else {

							String typeBus = request.getParameter("typeBus");
							String schedule_ID = request.getParameter("schedule_id");
							String dateStart = request.getParameter("datestart");

							Time time = new Time(Integer.valueOf(schedule_ID), LocalDate.parse(dateStart));

							TimeDAO timeDAO = new TimeDAOImpl();

							Booking booking = timeDAO.getBusTypeBookedSeatsByPlaceTimeDate(time);

							session.setAttribute("typeBus", typeBus);
							session.setAttribute("schedule_id", schedule_ID);
							session.setAttribute("bookedseats", booking.getSeatList());

							RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/HomePage.jsp");

							dispatcher.forward(request, response);
						}
					} else {

						String schedule_ID = request.getParameter("schedule_id");
						String dateStart = request.getParameter("datestart");

						request.getSession().setAttribute("schedule_id", schedule_ID);
						request.getSession().setAttribute("datestart", dateStart);

						Time time = new Time(Integer.valueOf(schedule_ID), LocalDate.parse(dateStart));

						TimeDAO timeDAO = new TimeDAOImpl();

						Booking booking = timeDAO.getBusTypeBookedSeatsByPlaceTimeDate(time);

						request.setAttribute("busType", booking.getBusType());
						request.setAttribute("seatList", booking.getSeatList());

						RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/AvailableSeats.jsp");

						dispatcher.forward(request, response);
					}

				}
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("utf-8");

		if ("getTimeByPlaceDateAmount".equalsIgnoreCase(request.getParameter("param"))) {

			HttpSession session = request.getSession();

			int startPlace = Integer.parseInt(request.getParameter("startplace"));
			int finishPlace = Integer.parseInt(request.getParameter("finishplace"));

			if (startPlace == finishPlace) {
				session.setAttribute("wrongPlace", "You choosed wrong Place");
				response.sendRedirect("HomePage.jsp");
			} else {

				LocalDate dateStart = LocalDate.parse(request.getParameter("datestart"));
				int amount = Integer.parseInt(request.getParameter("amount"));

				Time time = new Time(amount, startPlace, finishPlace, dateStart);

				TimeDAO timeDAO = new TimeDAOImpl();

				List<Time> timeList = timeDAO.getTimeByPlaceDateAmount(time);

				session.setAttribute("startplace", startPlace);
				session.setAttribute("finishplace", finishPlace);
				session.setAttribute("datestart", dateStart);

				session.setAttribute("timeList", timeList);
				if (timeList.size() != 0)
					session.setAttribute("schedule_id", timeList.get(0).getSchedule_ID());

				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/HomePage.jsp");

				dispatcher.forward(request, response);
			}
		} else {

			if ("getBookedSeatsByPlaceTimeDate".equalsIgnoreCase(request.getParameter("param"))) {

				if (request.getParameter("button") == null) {

					HttpSession session = request.getSession();

					if (request.getParameter("schedule_id") == null) {
						response.sendRedirect("BookingTicketsController?param=loadPlaces");
					} else {

						String typeBus = request.getParameter("typeBus");
						String schedule_ID = request.getParameter("schedule_id");
						String dateStart = request.getParameter("datestart");

						Time time = new Time(Integer.valueOf(schedule_ID), LocalDate.parse(dateStart));

						TimeDAO timeDAO = new TimeDAOImpl();

						Booking booking = timeDAO.getBusTypeBookedSeatsByPlaceTimeDate(time);

						session.setAttribute("typeBus", typeBus);
						session.setAttribute("schedule_id", schedule_ID);
						session.setAttribute("bookedseats", booking.getSeatList());

						RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/HomePage.jsp");

						dispatcher.forward(request, response);
					}
				} else {

					String schedule_ID = request.getParameter("schedule_id");
					String dateStart = request.getParameter("datestart");

					request.getSession().setAttribute("schedule_id", schedule_ID);
					request.getSession().setAttribute("datestart", dateStart);

					Time time = new Time(Integer.valueOf(schedule_ID), LocalDate.parse(dateStart));

					TimeDAO timeDAO = new TimeDAOImpl();

					Booking booking = timeDAO.getBusTypeBookedSeatsByPlaceTimeDate(time);

					request.setAttribute("busType", booking.getBusType());
					request.setAttribute("seatList", booking.getSeatList());

					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/AvailableSeats.jsp");

					dispatcher.forward(request, response);
				}

			} else {
				if ("cancelBooking".equalsIgnoreCase(request.getParameter("param"))) {

					String booking_ID = String.valueOf(request.getParameter("bookingID"));

					BookingWeb bookingWeb = new BookingWeb(Integer.parseInt(booking_ID));

					BookingDAO bookingDAO = new BookingDAOImpl();

					int check = bookingDAO.cancelBooking(bookingWeb);
					
					if (check == 0)
						request.getSession().setAttribute("checkCancelBooking", "0");
					else
						request.getSession().setAttribute("checkCancelBooking", "1");

					RequestDispatcher dispatcher = request.getRequestDispatcher("/MyBooking.jsp");

					dispatcher.forward(request, response);
				} else {
					if ("bookingSeats".equalsIgnoreCase(request.getParameter("param"))) {

						HttpSession session = request.getSession();

						int schedule = Integer.parseInt((String) session.getAttribute("schedule_id"));

						int cusid = (int) session.getAttribute("customerid");

						LocalDate dateStart = (LocalDate) session.getAttribute("datestart");

						String decription = request.getParameter("decription");

						Booking booking = new Booking(schedule, cusid, String.valueOf(dateStart), decription);

						String[] checkboxNamesList = request.getParameterValues("checkbox");

						if (checkboxNamesList != null) {

							for (int i = 0; i < checkboxNamesList.length; i++) {

								String myCheckBoxValue = checkboxNamesList[i];

								// if null, it means checkbox is not in request, so unchecked
								booking.getSeatList().add(Integer.valueOf(myCheckBoxValue));
							}

							BookingDAO bookingDAO = new BookingDAOImpl();

							bookingDAO.insertBooking(booking);

							session.removeAttribute("typeBus");
							session.removeAttribute("timeList");
							session.removeAttribute("bookedseats");
							
							session.setAttribute("bookedsuccess", "User was booked tickets successfully");
						} else {
							session.setAttribute("nullSeatList", "User was not choose any seat");
						}

						response.sendRedirect("HomePage.jsp");
					}
				}
			}
		}
	}
}
