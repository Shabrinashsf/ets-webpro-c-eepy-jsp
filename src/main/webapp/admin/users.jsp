<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, com.eepy.eepy.model.User, com.eepy.eepy.dao.UserDAO" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.eepy.eepy.DBConnection" %>

<%
    Connection conn = DBConnection.getConnection();
    UserDAO userDAO = new UserDAO(conn);

    String search = request.getParameter("search");
    int entries = request.getParameter("entries") != null ? Integer.parseInt(request.getParameter("entries")) : 10;
    int pageU = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

    List<User> filtered = userDAO.searchUsers(search, pageU, entries);
    int totalUsers = userDAO.countUsers(search);
    int start = (pageU - 1) * entries;
%>

<!-- Tailwind -->
<script src="https://cdn.tailwindcss.com"></script>

<div class="bg-[#d8ecf7] p-6 rounded-2xl">
    <!-- Header + Search + Entries -->
    <div class="flex justify-between items-center mb-4">
        <h2 class="text-[#78b3ce] font-bold text-xl">Users List</h2>
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
                <th class="py-3 px-4 text-sm font-semibold">Name</th>
                <th class="py-3 px-4 text-sm font-semibold">Email</th>
                <th class="py-3 px-4 text-sm font-semibold">Phone</th>
                <th class="py-3 px-4 text-sm font-semibold">Action</th>
            </tr>
            </thead>
            <tbody class="bg-[#F8F5FF] text-gray-800">
            <%
                for(int i=0; i<filtered.size(); i++){
                    User u = filtered.get(i);
            %>
            <tr>
                <td class="py-3 px-4 text-sm"><%= start + i + 1 %></td>
                <td class="py-3 px-4 text-sm"><%= u.getName() %></td>
                <td class="py-3 px-4 text-sm"><%= u.getEmail() %></td>
                <td class="py-3 px-4 text-sm"><%= u.getTelpNumber() != null ? u.getTelpNumber() : "-" %></td>
                <td class="py-3 px-4 text-sm flex gap-3">
                    <button class="text-[#631ACB] font-semibold hover:underline cursor-pointer"
                            onclick="openUserEditModal(<%= u.getId() %>, '<%= u.getName() %>', '<%= u.getEmail() %>', '<%= u.getTelpNumber()!=null?u.getTelpNumber():""%>')">
                        Edit
                    </button>
                    <button hx-post="/admin/users/delete?id=<%= u.getId() %>" hx-target="#users-table" hx-swap="innerHTML"
                            class="text-red-500 font-semibold hover:underline cursor-pointer">
                        Delete
                    </button>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <!-- Pagination & Info -->
    <div class="flex justify-between items-center mt-6">
        <div class="text-sm text-gray-600">
            Showing <%= start + 1 %> to <%= start + filtered.size() %> of <%= totalUsers %> entries
        </div>
        <div class="flex items-center gap-2">
            <%
                int totalPages = (int)Math.ceil((double)totalUsers / entries);
                for(int p=1; p<=totalPages; p++){
            %>
            <a href="?search=<%= search!=null?search:""%>&entries=<%=entries%>&page=<%=p%>"
               class="px-2 py-1 border rounded <%= p==pageU?"bg-blue-300":"" %>">
                <%= p %>
            </a>
            <% } %>
        </div>
    </div>
</div>

<!-- Modal (contoh sederhana) -->
<div id="userEditModal" class="hidden fixed inset-0 flex items-center justify-center bg-black bg-opacity-40 z-50">
    <div class="bg-white rounded-2xl shadow-lg p-6 w-[400px]">
        <h2 class="text-lg font-bold text-[#3C1361] mb-4">Edit User</h2>
        <form id="editUserForm" method="post" action="/admin/users/update" class="space-y-3">
            <input type="hidden" name="id" id="editUserId">
            <div>
                <label class="block text-sm font-medium text-gray-700">Name</label>
                <input type="text" name="name" id="editUserName"
                       class="w-full border border-[#d8ecf7] rounded-xl px-3 py-2 focus:ring-2 focus:ring-[#78b3ce] outline-none">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700">Email</label>
                <input type="email" name="email" id="editUserEmail"
                       class="w-full border border-[#d8ecf7] rounded-xl px-3 py-2 focus:ring-2 focus:ring-[#78b3ce] outline-none">
            </div>
            <div>
                <label class="block text-sm font-medium text-gray-700">Phone</label>
                <input type="text" name="telp_number" id="editUserPhone"
                       class="w-full border border-[#d8ecf7] rounded-xl px-3 py-2 focus:ring-2 focus:ring-[#78b3ce] outline-none">
            </div>
            <div class="flex justify-end gap-3 mt-4">
                <button type="button" onclick="closeUserEditModal()"
                        class="px-4 py-2 bg-gray-300 rounded-xl hover:bg-gray-400">Cancel</button>
                <button type="submit" class="px-4 py-2 bg-[#78b3ce] text-white rounded-xl hover:bg-[#4c98bb]">Save</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openUserEditModal(id, name, email, phone) {
        document.getElementById('editUserId').value = id;
        document.getElementById('editUserName').value = name;
        document.getElementById('editUserEmail').value = email;
        document.getElementById('editUserPhone').value = phone;
        document.getElementById('userEditModal').classList.remove('hidden');
    }

    function closeUserEditModal() {
        document.getElementById('userEditModal').classList.add('hidden');
    }
</script>
