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
import edu.fa.dao.ScheduleDAO;
import edu.fa.dao.ScheduleDAOImpl;
import edu.fa.model.Booking;
import edu.fa.model.BookingWeb;
import edu.fa.model.Schedule;

public class BookingManagementController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public BookingManagementController() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("utf-8");

		if ("getTicketBookedAvailableByStartDate".equalsIgnoreCase(request.getParameter("param"))) {

			HttpSession session = request.getSession();
			session.setAttribute("flagCalcelBooking", "TicketsBooked");

			if (session.getAttribute("employeeid") == null) {
				session.setAttribute("error", "You must Login before go to SELLER MANAGEMENT!");
				response.sendRedirect("Login.jsp");
			} else {
				int pageid = 1;
				if (request.getParameter("page") != null)
					pageid = Integer.parseInt(request.getParameter("page"));

				LocalDate date;
				if (request.getParameter("dateStart") == null) {
					if (session.getAttribute("dateStart") == null)
						date = LocalDate.now();
					else
						date = (LocalDate) session.getAttribute("dateStart");
				} else
					date = LocalDate.parse(request.getParameter("dateStart"));

				session.setAttribute("dateStart", date);
				request.setAttribute("pageActive", pageid);

				BookingDAO bookingDAO = new BookingDAOImpl();
				List<BookingWeb> ticketsBooked = bookingDAO.getTicketBookedAvailableByStartDate(date, pageid);

				if (ticketsBooked.size() == 0) {
					request.setAttribute("ticketsBooked", "-1");
					request.setAttribute("pageNumber", 0);
				}
				else {
					request.setAttribute("ticketsBooked", ticketsBooked);
					request.setAttribute("pageNumber", ticketsBooked.get(0).getPageNumber());
				}
				
				if(session.getAttribute("checkCancelBooking") != null)
				{
					request.setAttribute("checkCancelBooking", session.getAttribute("checkCancelBooking"));
					session.removeAttribute("checkCancelBooking");
				}

				RequestDispatcher dispatcher = request.getRequestDispatcher("/TicketsBooked.jsp");

				dispatcher.forward(request, response);
			}
		} else {

			if ("loadSchedules".equalsIgnoreCase(request.getParameter("param"))) {

				ScheduleDAO scheduleDAO = new ScheduleDAOImpl();

				List<Schedule> scheduleList = scheduleDAO.getSchedule();

				request.setAttribute("scheduleList", scheduleList);

				response.sendRedirect("AvailableSeats.jsp");

			} else {
				if ("cancelBooking".equalsIgnoreCase(request.getParameter("param"))) {

					HttpSession session = request.getSession();

					String booking_ID = String.valueOf(request.getParameter("bookingID"));

					BookingWeb bookingWeb = new BookingWeb(Integer.parseInt(booking_ID));

					BookingDAO bookingDAO = new BookingDAOImpl();

					int check = bookingDAO.cancelBooking(bookingWeb);

					if (check == 0)
						session.setAttribute("checkCancelBooking", "0");
					else
						session.setAttribute("checkCancelBooking", "1");

					RequestDispatcher dispatcher;

					if ("TicketsBooked".equals(session.getAttribute("flagCalcelBooking")))
						dispatcher = request.getRequestDispatcher("/TicketsBooked.jsp");
					else {
						if ("AvailableSeats".equals(session.getAttribute("flagCalcelBooking"))) {
							dispatcher = request.getRequestDispatcher(
									"BookingTicketsController?param=getBookedSeatsByPlaceTimeDate&button=abc&schedule_id="
											+ request.getSession().getAttribute("schedule_id") + "&datestart="
											+ request.getSession().getAttribute("datestart"));
						} else {
							dispatcher = request
									.getRequestDispatcher("/BookingManagementController?param=searchBooking");
						}
					}

					dispatcher.forward(request, response);
				} else {
					if ("searchBooking".equalsIgnoreCase(request.getParameter("param"))) {

						HttpSession session = request.getSession();
						session.setAttribute("flagCalcelBooking", "SearchAndFilter");

						if (session.getAttribute("employeeid") == null) {
							session.setAttribute("error", "You must Login before go to SELLER MANAGEMENT!");
							response.sendRedirect("Login.jsp");
						} else {

							String search = request.getParameter("searchBT");

							if (search != null) {
								search = search.trim();
								session.setAttribute("searchBT", search);
							}
							else
								search = (String) session.getAttribute("searchBT");
							
							if (session.getAttribute("searchBT") == null || search == null || "".equals(search)) {
								request.setAttribute("errorNullSearch", "Input cannot null.");
							} else {
								int pageid = 1;
								if (request.getParameter("page") != null)
									pageid = Integer.parseInt(request.getParameter("page"));

								BookingDAO bookingDAO = new BookingDAOImpl();
								List<BookingWeb> searchBookingList = bookingDAO
										.searchBooking((String) session.getAttribute("searchBT"), pageid);

								if (searchBookingList.size() == 0) {
									request.setAttribute("searchBookingList", "-1");
									request.setAttribute("pageNumber", 0);
								}
								else {
									request.setAttribute("pageNumber", searchBookingList.get(0).getPageNumber());
									request.setAttribute("searchBookingList", searchBookingList);
								}

								request.setAttribute("pageActive", pageid);
							}

							RequestDispatcher dispatcher = request.getRequestDispatcher("/SearchAndFilter.jsp");
							dispatcher.forward(request, response);
						}
					} else {
						if ("chooseSeat".equalsIgnoreCase(request.getParameter("param"))) {

							String scheduleID = (String) request.getSession().getAttribute("schedule_id");
							String dateStart = (String) request.getSession().getAttribute("datestart");
							String seat = request.getParameter("seat");

							Booking booking = new Booking(Integer.parseInt(scheduleID), dateStart,
									Integer.parseInt(seat));

							BookingDAO bookingDAO = new BookingDAOImpl();

							booking = bookingDAO.getBookingByDateStartScheduleSeat(booking);

							if (booking.getBooking_ID() == 0) {
								request.getSession().setAttribute("SeatEmpty", seat);
							} else {
								request.getSession().setAttribute("bookinginfo", booking);
							}

							response.sendRedirect(
									"BookingTicketsController?param=getBookedSeatsByPlaceTimeDate&button=abc&schedule_id="
											+ request.getSession().getAttribute("schedule_id") + "&datestart="
											+ request.getSession().getAttribute("datestart"));
						}
					}
				}
			}
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);

	}
}
