<%@ page import="java.sql.*" %>
<%@ page import="main_project.Dbconnection" %>
<%
  try {
    String id = request.getParameter("id");
    Connection con = Dbconnection.connect();
    PreparedStatement ps = con.prepareStatement("DELETE FROM doctor WHERE id = ?");
    ps.setString(1, id);
    ps.executeUpdate();
    con.close();
  } catch (Exception e) {
    out.println("Error deleting doctor: " + e.getMessage());
  }
  response.sendRedirect("doctorList.jsp");
%>
