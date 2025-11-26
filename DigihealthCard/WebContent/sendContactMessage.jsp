<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="java.sql.*, main_project.Dbconnection" %>
<%
  String name = request.getParameter("name");
  String email = request.getParameter("email");
  String message = request.getParameter("message");

  try {
    Connection con = Dbconnection.connect();
    PreparedStatement ps = con.prepareStatement(
      "INSERT INTO contact_messages(name, email, message) VALUES (?, ?, ?)");
    ps.setString(1, name);
    ps.setString(2, email);
    ps.setString(3, message);
    ps.executeUpdate();

    out.println("<script>alert('Message sent successfully!'); location.href='index.jsp#contact';</script>");
  } catch (Exception e) {
    out.println("<script>alert('Error: " + e.getMessage() + "'); location.href='index.jsp#contact';</script>");
  }
%>
