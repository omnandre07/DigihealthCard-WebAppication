<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="main_project.Dbconnection" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Add Doctor | DigiHealthCard</title>
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

    .form-section {
      background: var(--white);
      padding: 2rem;
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      max-width: 600px;
      margin: 0 auto;
    }

    .form-section h3 {
      font-size: 1.25rem;
      color: var(--primary-dark);
      margin-bottom: 1.5rem;
      font-weight: 600;
      text-align: center;
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

    .btn-submit {
      background-color: var(--primary);
      color: var(--white);
      padding: 0.85rem;
      border: none;
      border-radius: 8px;
      font-size: 1rem;
      font-weight: 500;
      width: 100%;
      cursor: pointer;
      transition: all 0.2s ease;
      margin-top: 0.5rem;
    }

    .btn-submit:hover {
      background-color: var(--primary-dark);
    }

    .alert {
      padding: 0.85rem 1rem;
      border-radius: 8px;
      margin-top: 1.5rem;
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
      .form-section {
        padding: 1.5rem;
      }
    }
  </style>
</head>
<body>

<%
  String message = "";
  if ("POST".equalsIgnoreCase(request.getMethod())) {
    String name = request.getParameter("name");
    String specialization = request.getParameter("specialization");
    String contactStr = request.getParameter("contact");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    try {
      int contact = Integer.parseInt(contactStr);
      Connection con = Dbconnection.connect();
      PreparedStatement ps = con.prepareStatement("INSERT INTO doctor (name, specialization, contact, email, password) VALUES (?, ?, ?, ?, ?)");
      ps.setString(1, name);
      ps.setString(2, specialization);
      ps.setInt(3, contact);
      ps.setString(4, email);
      ps.setString(5, password);
      int rows = ps.executeUpdate();
      if (rows > 0) {
        message = "Doctor added successfully!";
      } else {
        message = "Failed to add doctor.";
      }
      ps.close();
      con.close();
    } catch (NumberFormatException nfe) {
      message = "Error: Contact number must be numeric.";
    } catch (Exception e) {
      message = "Error: " + e.getMessage();
    }
  }
%>

<div class="sidebar">
  <div class="logo-box">
    <div class="logo-main">DigiHealthCard</div>
    <div class="logo-sub">ADMIN PORTAL</div>
  </div>
  <a href="adminDashboard.jsp"><i class="fas fa-chart-line"></i> <span>Dashboard</span></a>
  <a href="doctorList.jsp"><i class="fas fa-user-md"></i> <span>Doctor List</span></a>
  <a href="#" class="active"><i class="fas fa-user-plus"></i> <span>Add Doctor</span></a>
  <a href="patientList.jsp"><i class="fas fa-users"></i> <span>Patient List</span></a>
  <a href="records.jsp"><i class="fas fa-file-medical-alt"></i> <span>Health Records</span></a>
  <a href="setting.jsp"><i class="fas fa-cog"></i> <span>Settings</span></a>
</div>

<div class="main-content">
  <div class="topbar">
    <h2>Add New Doctor</h2>
    <div class="user-profile">
      <img src="https://ui-avatars.com/api/?name=Admin&background=2563eb&color=fff" alt="Admin">
      <span>Administrator</span>
    </div>
  </div>

  <div class="form-section">
    <h3>Doctor Registration Form</h3>
    <form method="post">
      <div class="form-group">
        <label for="name">Full Name</label>
        <input type="text" id="name" name="name" required placeholder="Enter doctor's full name">
      </div>

      <div class="form-group">
        <label for="specialization">Specialization</label>
        <input type="text" id="specialization" name="specialization" required placeholder="Enter specialization">
      </div>

      <div class="form-group">
        <label for="contact">Contact Number</label>
        <input type="text" id="contact" name="contact" required placeholder="Enter contact number">
      </div>

      <div class="form-group">
        <label for="email">Email Address</label>
        <input type="email" id="email" name="email" required placeholder="Enter email address">
      </div>

      <div class="form-group">
        <label for="password">Password</label>
        <input type="password" id="password" name="password" required placeholder="Create password">
      </div>

      <button type="submit" class="btn-submit">
        <i class="fas fa-user-plus"></i> Register Doctor
      </button>
    </form>

    <% if (!message.isEmpty()) { %>
      <div class="alert <%= message.startsWith("Error") || message.startsWith("Failed") ? "alert-error" : "alert-success" %>">
        <%= message %>
      </div>
    <% } %>
  </div>
</div>

</body>
</html>
>
</div>

</body>
</html>
