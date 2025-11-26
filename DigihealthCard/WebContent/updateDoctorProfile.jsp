<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, main_project.Dbconnection" %>
<%
    String doctorEmail = (String) session.getAttribute("doctor");

    if (doctorEmail == null) {
        response.sendRedirect("doctorLogin.jsp");
        return;
    }

    String name = request.getParameter("name");
    String specialization = request.getParameter("specialization");
    String contact = request.getParameter("contact");

    String message = "";
    String messageType = "";

    try {
        Connection con = Dbconnection.connect();
        PreparedStatement pst = con.prepareStatement(
            "UPDATE doctor SET name=?, specialization=?, contact=? WHERE email=?"
        );
        pst.setString(1, name);
        pst.setString(2, specialization);
        pst.setString(3, contact);
        pst.setString(4, doctorEmail);

        int updated = pst.executeUpdate();
        con.close();

        if (updated > 0) {
            message = "Profile updated successfully!";
            messageType = "success";
        } else {
            message = "No changes made. Please try again.";
            messageType = "error";
        }

    } catch (Exception e) {
        message = "Error updating profile: " + e.getMessage();
        messageType = "error";
    }

    // Redirect back to dashboard with a message
    session.setAttribute("profileMessage", message);
    session.setAttribute("profileMessageType", messageType);
    response.sendRedirect("doctorDashboard.jsp");
%>
