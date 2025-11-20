<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.eepy.eepy.model.Room, com.eepy.eepy.model.RoomType, com.eepy.eepy.dao.RoomDAO" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.eepy.eepy.DBConnection" %>
<%@ page import="java.util.List" %>
<%@ page import="com.eepy.eepy.model.Booking" %>
<%@ page import="com.eepy.eepy.dao.BookingDAO" %>

<%
    int userID = (int) session.getAttribute("userID");

    Connection conn = DBConnection.getConnection();
    BookingDAO bookingDAO = new BookingDAO(conn);

    String search = request.getParameter("search");
    int entries = request.getParameter("entries") != null ? Integer.parseInt(request.getParameter("entries")) : 10;
    int pageR = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

    List<Booking> bookings = bookingDAO.getBookingByUserId(userID);
    int start = (pageR - 1) * entries;
%>

<!-- Tailwind -->
<script src="https://cdn.tailwindcss.com"></script>

<div class="bg-[#d8ecf7] p-6 rounded-2xl">
    <!-- Header + Search + Entries -->
    <div class="flex justify-between items-center mb-4">
        <h2 class="text-[#78b3ce] font-bold text-xl">Rooms List</h2>
        <form method="get" class="flex items-center gap-3">
            <input type="text" name="search" value="<%= search != null ? search : "" %>" placeholder="🔍 Search..."
                   class="w-64 px-4 py-2 border border-[#d8ecf7] rounded-xl focus:ring-2 focus:ring-[#78b3ce] outline-none bg-white">
            <select name="entries"
                    class="px-3 py-2 border border-[#d8ecf7] rounded-xl bg-white text-gray-700 focus:ring-2 focus:ring-[#78b3ce]">
                <option value="10" <%= entries==10?"selected":"" %>>10 Entries</option>
                <option value="20" <%= entries==20?"selected":"" %>>20 Entries</option>
                <option value="50" <%= entries==50?"selected":"" %>>50 Entries</option>
            </select>
            <button type="submit" class="px-4 py-2 bg-[#78b3ce] text-white rounded-xl hover:bg-[#4c98bb]">Go</button>

        </form>
    </div>

    <!-- Table -->
    <div class="overflow-hidden rounded-xl border">
        <table class="min-w-full border-collapse">
            <thead>
            <tr class="bg-[#78b3ce] text-white text-left">
                <th class="py-3 px-4 text-sm font-semibold">No</th>
                <th class="py-3 px-4 text-sm font-semibold">Guest Name</th>
                <th class="py-3 px-4 text-sm font-semibold">Check In</th>
                <th class="py-3 px-4 text-sm font-semibold">Check Out</th>
                <th class="py-3 px-4 text-sm font-semibold">Price</th>
                <th class="py-3 px-4 text-sm font-semibold">Method</th>
            </tr>
            </thead>
            <tbody class="bg-[#F8F5FF] text-gray-800">
            <%
                for(int i = start; i < bookings.size(); i++){
                    Booking b = bookings.get(i);
            %>
            <tr>
                <td class="py-3 px-4 text-sm"><%= start + i + 1 %></td>
                <td class="py-3 px-4 text-sm"><%= b.getName() %></td>
                <td class="py-3 px-4 text-sm"><%= b.getCheckin() %></td>
                <td class="py-3 px-4 text-sm"><%= b.getCheckout() %></td>
                <td class="py-3 px-4 text-sm">Rp <%= b.getPrice() %></td>
                <td class="py-3 px-4 text-sm"><%= b.getPaymentMethod() %></td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>
