<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, main_project.Dbconnection" %>
<%
    String message = "";
    String userEmail = (String) session.getAttribute("patient");

    if (userEmail == null) {
        response.sendRedirect("patientLogin.jsp");
        return;
    }

    if (request.getMethod().equalsIgnoreCase("POST")) {
        String oldPass = request.getParameter("old_password");
        String newPass = request.getParameter("new_password");

        try {
            Connection con = Dbconnection.connect();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM patient WHERE email=? AND password=?");
            ps.setString(1, userEmail);
            ps.setString(2, oldPass);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                PreparedStatement update = con.prepareStatement("UPDATE patient SET password=? WHERE email=?");
                update.setString(1, newPass);
                update.setString(2, userEmail);
                int updated = update.executeUpdate();
                if (updated > 0) {
                    message = "Password changed successfully!";
                } else {
                    message = "Password update failed.";
                }
            } else {
                message = "Old password is incorrect.";
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Settings | DigiHealthCard</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
      --warning: #f59e0b;
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
      line-height: 1.6;
    }

    .sidebar {
      width: 280px;
      background: linear-gradient(180deg, var(--primary), var(--primary-dark));
      position: fixed;
      height: 100vh;
      padding: 2rem 0;
      box-shadow: 4px 0 10px rgba(0, 0, 0, 0.1);
      z-index: 100;
      transition: all 0.3s ease;
    }

    .sidebar .logo-box {
      text-align: center;
      padding: 0 1.5rem 1.5rem;
      margin-bottom: 1rem;
      border-bottom: 1px solid rgba(255, 255, 255, 0.2);
    }

    .sidebar .logo-main {
      font-size: 1.5rem;
      font-weight: 700;
      color: var(--white);
      letter-spacing: 0.5px;
    }

    .sidebar .logo-sub {
      font-size: 0.75rem;
      color: var(--primary-light);
      letter-spacing: 1px;
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
      transition: all 0.3s ease;
      margin: 0.25rem 1rem;
      border-radius: 8px;
    }

    .sidebar a i {
      margin-right: 0.75rem;
      font-size: 1.1rem;
      width: 24px;
      text-align: center;
    }

    .sidebar a:hover, .sidebar a.active {
      background-color: rgba(255, 255, 255, 0.15);
      color: var(--white);
      transform: translateX(5px);
    }


   .main-content {
      margin-left: 280px;
      padding: 2rem;
      transition: all 0.3s ease;
    }

    .topbar {
      background: var(--white);
      padding: 1.25rem 2rem;
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      margin-bottom: 1.5rem;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .topbar h2 {
      font-size: 1.5rem;
      color: var(--primary-dark);
      font-weight: 600;
    }

    .user-profile {
      display: flex;
      align-items: center;
      gap: 0.75rem;
    }

    .user-profile img {
      width: 40px;
      height: 40px;
      border-radius: 50%;
      object-fit: cover;
    }

    .settings-section {
      background: var(--white);
      padding: 1.5rem;
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      max-width: 600px;
      margin: 0 auto;
    }

    .settings-section h3 {
      font-size: 1.25rem;
      color: var(--primary-dark);
      margin-bottom: 1.25rem;
      font-weight: 600;
      display: flex;
      align-items: center;
      gap: 0.75rem;
    }

    .settings-section h3 i {
      color: var(--primary);
    }

    .form-group {
      margin-bottom: 1.25rem;
    }

    .form-group label {
      display: block;
      margin-bottom: 0.5rem;
      font-weight: 500;
      color: var(--text);
    }

    .form-group input {
      width: 100%;
      padding: 0.85rem 1rem;
      border: 1px solid var(--border);
      border-radius: 8px;
      font-size: 0.95rem;
      transition: all 0.2s ease;
    }

    .form-group input:focus {
      outline: none;
      border-color: var(--primary);
      box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
    }

    .action-btn {
      display: inline-flex;
      align-items: center;
      padding: 0.75rem 1.25rem;
      border-radius: 8px;
      font-size: 0.95rem;
      font-weight: 500;
      text-decoration: none;
      transition: all 0.2s ease;
      cursor: pointer;
      border: none;
    }

    .btn-primary {
      background-color: var(--primary);
      color: var(--white);
    }

    .btn-primary:hover {
      background-color: var(--primary-dark);
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(37, 99, 235, 0.2);
    }

    .btn-danger {
      background-color: var(--danger);
      color: var(--white);
    }

    .btn-danger:hover {
      background-color: #dc2626;
    }

    .alert {
      padding: 0.85rem 1rem;
      border-radius: 8px;
      margin-bottom: 1.5rem;
      font-size: 0.95rem;
      font-weight: 500;
      text-align: center;
    }

    .alert-success {
      background-color: rgba(16, 185, 129, 0.1);
      color: var(--success);
      border: 1px solid rgba(16, 185, 129, 0.2);
    }

    .alert-error {
      background-color: rgba(239, 68, 68, 0.1);
      color: var(--danger);
      border: 1px solid rgba(239, 68, 68, 0.2);
    }

    @media (max-width: 992px) {
      .sidebar {
        width: 80px;
        overflow: hidden;
      }
      .sidebar .logo-box, .sidebar a span {
        display: none;
      }
      .sidebar a {
        justify-content: center;
        margin: 0.25rem 0.5rem;
      }
      .sidebar a i {
        margin-right: 0;
      }
      .main-content {
        margin-left: 80px;
      }
    }
    

    @media (max-width: 768px) {
      .main-content {
        padding: 1rem;
      }
      .topbar {
        flex-direction: column;
        align-items: flex-start;
        gap: 1rem;
      }
      .settings-section {
        padding: 1.25rem;
      }
    }
  </style>
</head>
<body>

<div class="sidebar">
  <div class="logo-box">
    <div class="logo-main">DigiHealthCard</div>
    <div class="logo-sub">PATIENT PORTAL</div>
  </div>
  <a href="patientDashboard.jsp"><i class="fas fa-user"></i> <span>My Profile</span></a>
  <a href="viewrecord.jsp"><i class="fas fa-file-medical-alt"></i> <span>Health Records</span></a>
  <a href="patientSettings.jsp" class="active"><i class="fas fa-cog"></i> <span>Settings</span></a>
  
</div>

<div class="main-content">
  <div class="topbar">
    <h2>Account Settings</h2>
    <form action="index.jsp" method="post">
        <button type="submit" class="action-btn btn-danger">
          <i class="fas fa-sign-out-alt"></i> Logout
        </button>
      </form>
  </div>

  <div class="settings-section">
    <h3><i class="fas fa-key"></i> Change Password</h3>
    
    <% if (!message.isEmpty()) { %>
      <div class="alert <%= message.contains("success") ? "alert-success" : "alert-error" %>">
        <%= message %>
      </div>
    <% } %>
    
    <form method="post" action="patientSettings.jsp">
      <div class="form-group">
        <label for="old_password">Current Password</label>
        <input type="password" id="old_password" name="old_password" required>
      </div>
      
      <div class="form-group">
        <label for="new_password">New Password</label>
        <input type="password" id="new_password" name="new_password" required>
      </div>
      
      <button type="submit" class="action-btn btn-primary">
        <i class="fas fa-save"></i> Update Password
      </button>
    </form>
  </div>
</div>

</body>
</html>