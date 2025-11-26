<%@ page import="java.sql.*" %>
<%@ page import="main_project.Dbconnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String currentPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");
    String confirmPassword = request.getParameter("confirmPassword");
    String message = "";

    if (currentPassword != null && newPassword != null && confirmPassword != null) {
        if (!newPassword.equals(confirmPassword)) {
            message = "New password and confirm password do not match.";
        } else {
            try {
                Connection con = Dbconnection.connect();
                PreparedStatement ps = con.prepareStatement("SELECT * FROM admin WHERE id = 1");
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    String dbPassword = rs.getString("password");
                    if (dbPassword.equals(currentPassword)) {
                        PreparedStatement updatePs = con.prepareStatement("UPDATE admin SET password = ? WHERE id = 1");
                        updatePs.setString(1, newPassword);
                        int i = updatePs.executeUpdate();
                        if (i > 0) {
                            message = "Password updated successfully.";
                        } else {
                            message = "Failed to update password.";
                        }
                        updatePs.close();
                    } else {
                        message = "Incorrect current password.";
                    }
                } else {
                    message = "Admin user not found.";
                }
                rs.close();
                ps.close();
                con.close();
            } catch (Exception e) {
                message = "Error: " + e.getMessage();
            }
        }
    } else {
        message = "Invalid input.";
    }
%>

<script>
    alert("<%= message %>");
    window.location.href = "setting.jsp";
</script>
