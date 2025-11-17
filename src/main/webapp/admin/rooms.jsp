<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.eepy.eepy.model.Room, com.eepy.eepy.model.RoomType, com.eepy.eepy.dao.RoomDAO" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.eepy.eepy.DBConnection" %>
<%@ page import="java.util.List" %>

<%
    Connection conn = DBConnection.getConnection();
    RoomDAO roomDAO = new RoomDAO(conn);

    String search = request.getParameter("search");
    int entries = request.getParameter("entries") != null ? Integer.parseInt(request.getParameter("entries")) : 10;
    int pageR = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

    List<Room> filtered = roomDAO.searchRooms(search, pageR, entries);
    int totalRooms = roomDAO.countRooms(search);
    int start = (pageR - 1) * entries;
    List<RoomType> types = roomDAO.getAllRoomTypes();

    String roomAdded = request.getParameter("add");
    String roomUpdate = request.getParameter("update");
    String roomDelete = request.getParameter("delete");
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

            <button type="button" onclick="openRoomAddModal()" class="bg-[#f96e2a] text-white px-4 py-2 rounded-xl hover:bg-[#d14b08] transition">
                + Add Room
            </button>
        </form>
    </div>

    <!-- Table -->
    <div class="overflow-hidden rounded-xl border">
        <table class="min-w-full border-collapse">
            <thead>
            <tr class="bg-[#78b3ce] text-white text-left">
                <th class="py-3 px-4 text-sm font-semibold">No</th>
                <th class="py-3 px-4 text-sm font-semibold">Room Type</th>
                <th class="py-3 px-4 text-sm font-semibold">Number</th>
                <th class="py-3 px-4 text-sm font-semibold">Status</th>
                <th class="py-3 px-4 text-sm font-semibold">Action</th>
            </tr>
            </thead>
            <tbody class="bg-[#F8F5FF] text-gray-800">
            <%
                for(int i=0; i<filtered.size(); i++){
                    Room r = filtered.get(i);
            %>
            <tr>
                <td class="py-3 px-4 text-sm"><%= start + i + 1 %></td>
                <td class="py-3 px-4 text-sm"><%= r.getRoomType()!=null ? r.getRoomType().getName() : "-" %></td>
                <td class="py-3 px-4 text-sm"><%= r.getNumber() %></td>
                <td class="py-3 px-4 text-sm"><%= r.getStatus() %></td>
                <td class="py-3 px-4 text-sm flex gap-3">
                    <button class="text-[#631ACB] font-semibold hover:underline cursor-pointer"
                            onclick="openRoomEditModal(<%= r.getId() %>, '<%= r.getNumber() %>', '<%= r.getStatus() %>', '<%= r.getRoomTypeId() %>')">
                        Edit
                    </button>
                    <form method="post" action="${pageContext.request.contextPath}/admin/rooms/delete" style="display:inline;">
                        <input type="hidden" name="id" value="<%= r.getId() %>">
                        <button type="submit" class="text-red-500 font-semibold hover:underline cursor-pointer">Delete</button>
                    </form>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <!-- Pagination & Info -->
    <div class="flex justify-between items-center mt-6">
        <div class="text-sm text-gray-600">
            Showing <%= start + 1 %> to <%= start + filtered.size() %> of <%= totalRooms %> entries
        </div>
        <div class="flex items-center gap-2">
            <%
                int totalPages = (int)Math.ceil((double)totalRooms / entries);
                for(int p=1; p<=totalPages; p++){
            %>
            <a href="?search=<%= search!=null?search:""%>&entries=<%=entries%>&page=<%=p%>"
               class="px-2 py-1 border rounded <%= p==pageR?"bg-blue-300":"" %>">
                <%= p %>
            </a>
            <% } %>
        </div>
    </div>
</div>

<!-- Add Room Modal -->
<div id="roomAddModal" class="hidden fixed inset-0 flex items-center justify-center bg-black bg-opacity-40 z-50">
    <div class="bg-white rounded-2xl shadow-lg p-6 w-[400px]">
        <h2 class="text-lg font-bold text-[#3C1361] mb-4">Add Room</h2>
        <form id="addRoomForm" method="post" action="${pageContext.request.contextPath}/admin/rooms/add" class="space-y-3">
            <div>
                <label class="block text-sm font-medium text-gray-700">Room Number</label>
                <input type="text" name="number" class="w-full border rounded-xl px-3 py-2 text-black">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700">Room Type</label>
                <select name="room_type_id" class="w-full border rounded-xl px-3 py-2 text-black">
                    <%
                        for(RoomType t : types){
                    %>
                    <option value="<%= t.getId() %>"><%= t.getName() %></option>
                    <%
                        }
                    %>
                </select>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700">Status</label>
                <select name="status" class="w-full border rounded-xl px-3 py-2 text-black">
                    <option value="Available">Available</option>
                    <option value="Unavailable">Unavailable</option>
                    <option value="Maintenance">Maintenance</option>
                </select>
            </div>
            <div class="flex justify-end gap-3 mt-4">
                <button type="button" onclick="closeRoomAddModal()" class="px-4 py-2 bg-gray-300 rounded-xl">Cancel</button>
                <button type="submit" class="px-4 py-2 bg-[#78b3ce] text-white rounded-xl">Add</button>
            </div>
        </form>
    </div>
</div>

<!-- Update Room Modal -->
<div id="roomEditModal" class="hidden fixed inset-0 flex items-center justify-center bg-black bg-opacity-40 z-50">
    <div class="bg-white rounded-2xl shadow-lg p-6 w-[400px]">
        <h2 class="text-lg font-bold text-[#3C1361] mb-4">Edit Room</h2>
        <form id="editRoomForm" method="post" action="${pageContext.request.contextPath}/admin/rooms/update" class="space-y-3">
            <input type="hidden" name="id" id="editRoomId">
            <div>
                <label class="block text-sm font-medium text-gray-700">Room Number</label>
                <input type="text" name="number" id="editRoomNumber"
                       class="w-full border border-[#d8ecf7] rounded-xl px-3 py-2 focus:ring-2 focus:ring-[#78b3ce] outline-none text-black">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700">Room Type</label>
                <select name="room_type_id" id="editRoomType" class="w-full border rounded-xl px-3 py-2 text-black">
                    <%
                        for(RoomType t : types){
                    %>
                    <option value="<%= t.getId() %>"><%= t.getName() %></option>
                    <%
                        }
                    %>
                </select>
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700">Status</label>
                <select name="status" id="editRoomStatus" class="w-full border border-[#d8ecf7] rounded-xl px-3 py-2 focus:ring-2 focus:ring-[#78b3ce] outline-none text-black">
                    <option value="Available">Available</option>
                    <option value="Unavailable">Unavailable</option>
                    <option value="Maintenance">Maintenance</option>
                </select>
            </div>
            <div class="flex justify-end gap-3 mt-4">
                <button type="button" onclick="closeRoomEditModal()"
                        class="px-4 py-2 bg-gray-300 rounded-xl hover:bg-gray-400">Cancel</button>
                <button type="submit" class="px-4 py-2 bg-[#78b3ce] text-white rounded-xl hover:bg-[#4c98bb]">Save</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openRoomAddModal() { document.getElementById('roomAddModal').classList.remove('hidden'); }
    function closeRoomAddModal() { document.getElementById('roomAddModal').classList.add('hidden'); }
    function openRoomEditModal(id, number, status, roomTypeId) {
        document.getElementById('editRoomId').value = id;
        document.getElementById('editRoomNumber').value = number;
        document.getElementById('editRoomStatus').value = status;
        document.getElementById('editRoomType').value = roomTypeId;
        document.getElementById('roomEditModal').classList.remove('hidden');
    }
    function closeRoomEditModal() { document.getElementById('roomEditModal').classList.add('hidden'); }

    <% if ("true".equals(roomAdded) || "true".equals(roomUpdate) || "true".equals(roomDelete)) { %>
    // Modal close
    if (document.getElementById("roomAddModal")) {
        document.getElementById("roomAddModal").classList.add("hidden");
    }

    // Optional: notifikasi, misal alert
    alert("Room berhasil ditambahkan!");

    // Let everything reload normally
    <% } %>
</script>

