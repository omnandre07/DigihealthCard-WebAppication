<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, main_project.Dbconnection" %>
<%
    String doctorEmail = (String) session.getAttribute("doctor");
    String currentPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");
    String confirmPassword = request.getParameter("confirmPassword");
    String message = "";

    if (doctorEmail != null && currentPassword != null && newPassword != null && confirmPassword != null) {
        if (!newPassword.equals(confirmPassword)) {
            message = "New passwords do not match.";
        } else {
            try {
                Connection con = Dbconnection.connect();
                PreparedStatement pst = con.prepareStatement("SELECT password FROM doctor WHERE email=?");
                pst.setString(1, doctorEmail);
                ResultSet rs = pst.executeQuery();
                if (rs.next() && rs.getString("password").equals(currentPassword)) {
                    PreparedStatement updatePst = con.prepareStatement("UPDATE doctor SET password=? WHERE email=?");
                    updatePst.setString(1, newPassword);
                    updatePst.setString(2, doctorEmail);
                    int rows = updatePst.executeUpdate();
                    if (rows > 0) {
                        message = "Password updated successfully!";
                    } else {
                        message = "Failed to update password.";
                    }
                } else {
                    message = "Current password is incorrect.";
                }
                con.close();
            } catch (Exception e) {
                message = "Error updating password: " + e.getMessage();
            }
        }
    } else {
        message = "Invalid request.";
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Password</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
    :root {
        --primary: #2563eb;
        --primary-dark: #1e40af;
        --primary-light: #93c5fd;
        --secondary: #f8fafc;
        --text: #1e293b;
        --text-light: #64748b;
        --border: #e2e8f0;
        --white: #ffffff;
        --success: #10b981;
        --danger: #ef4444;
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: 'Poppins', sans-serif;
        background-color: #f1f5f9;
        color: var(--text);
    }

    /* Sidebar */
    .sidebar {
        width: 280px;
        background: linear-gradient(180deg, var(--primary), var(--primary-dark));
        position: fixed;
        height: 100vh;
        padding: 2rem 0;
        box-shadow: 4px 0 10px rgba(0, 0, 0, 0.1);
    }

    .sidebar .logo-box {
        text-align: center;
        padding: 0 1.5rem 1.5rem;
        margin-bottom: 1rem;
        border-bottom: 1px solid rgba(255, 255, 255, 0.2);
    }

    .logo-main {
        font-size: 1.5rem;
        font-weight: 700;
        color: var(--white);
    }

    .logo-sub {
        font-size: 0.75rem;
        color: var(--primary-light);
        margin-top: 0.25rem;
    }

    .sidebar a {
        display: flex;
        align-items: center;
        padding: 0.85rem 1.5rem;
        color: rgba(255, 255, 255, 0.9);
        text-decoration: none;
        font-size: 0.95rem;
        font-weight: 500;
        margin: 0.25rem 1rem;
        border-radius: 8px;
        transition: all 0.3s ease;
    }

    .sidebar a i {
        margin-right: 0.75rem;
        font-size: 1.1rem;
    }

    .sidebar a:hover, .sidebar a.active {
        background-color: rgba(255, 255, 255, 0.15);
        color: var(--white);
        transform: translateX(5px);
    }

    /* Main Content */
    .main-content {
        margin-left: 280px;
        padding: 2rem;
    }

    .topbar {
        background: var(--white);
        padding: 1.25rem 2rem;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        margin-bottom: 1.5rem;
    }

    .topbar h2 {
        font-size: 1.5rem;
        color: var(--primary-dark);
    }

    /* Message Box */
    .message-box {
        background: var(--white);
        padding: 1.5rem;
        border-radius: 12px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        font-size: 1rem;
        line-height: 1.6;
    }

    .message-box.success {
        border-left: 6px solid var(--success);
        color: var(--success);
        font-weight: 500;
    }

    .message-box.error {
        border-left: 6px solid var(--danger);
        color: var(--danger);
        font-weight: 500;
    }

    /* Back Button */
    .back-btn {
        display: inline-flex;
        align-items: center;
        padding: 0.75rem 1.25rem;
        border-radius: 8px;
        font-size: 0.95rem;
        font-weight: 500;
        text-decoration: none;+
        background-color: var(--primary);
        color: var(--white);
        margin-top: 1rem;
        transition: all 0.2s ease;
    }

    .back-btn i {
        margin-right: 0.5rem;
    }

    .back-btn:hover {
        background-color: var(--primary-dark);
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(37, 99, 235, 0.2);
    }
</style>
</head>
<body>

<div class="sidebar">
    <div class="logo-box">
        <div class="logo-main">DigiHealthCard</div>
        <div class="logo-sub">DOCTOR PORTAL</div>
    </div>
   <a href="doctorDashboard.jsp"><i class="fas fa-tachometer-alt"></i>Dashboard</a>
   <a href="addPatientRecord.jsp"><i class="fas fa-user-plus"></i> <span>Add Records</span></a>
   <a href="viewPatientHistory.jsp"><i class="fas fa-file-medical-alt"></i> <span>View History</span></a>
   <a href="doctorSettings.jsp" class="active"><i class="fas fa-cog"></i>Settings</a>
</div>

<div class="main-content">
    <div class="topbar">
        <h2>Update Password</h2>
    </div>

    <div class="message-box <%= message.contains("successfully") ? "success" : "error" %>">
        <%= message %>
        <br>
        <a href="doctorSettings.jsp" class="back-btn"><i class="fas fa-arrow-left"></i> Back to Settings</a>
    </div>
</div>

</body>
</html>
