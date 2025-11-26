<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="main_project.Dbconnection" %>
<%
  String id = request.getParameter("id");
  String name = request.getParameter("name");
  String specialization = request.getParameter("specialization");
  String email = request.getParameter("email");
  String contact = request.getParameter("contact");

  try {
    Connection con = Dbconnection.connect();
    PreparedStatement ps = con.prepareStatement(
      "UPDATE doctor SET name=?, specialization=?, email=?, contact=? WHERE id=?"
    );
    ps.setString(1, name);
    ps.setString(2, specialization);
    ps.setString(3, email);
    ps.setString(4, contact);
    ps.setInt(5, Integer.parseInt(id));

    int i = ps.executeUpdate();
    if (i > 0) {
      response.sendRedirect("doctorList.jsp");
    } else {
      out.println("<script>alert('Failed to update doctor details.'); window.history.back();</script>");
    }
  } catch (Exception e) {
    out.println("Error: " + e);
  }
%>
