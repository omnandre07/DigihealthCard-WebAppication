<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="main_project.Dbconnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Edit Doctor | DigiHealthCard</title>
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
    }

    .topbar {
      background: var(--white);
      padding: 1.25rem 2rem;
      border-radius: 12px;
      margin-bottom: 2rem;
      display: flex;
      justify-content: space-between;
      align-items: center;
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    }

    .topbar h2 {
      font-size: 1.5rem;
      color: var(--primary-dark);
    }

    .form-section {
      background: var(--white);
      padding: 2rem;
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      max-width: 600px;
      margin: auto;
    }

    .form-section h3 {
      margin-bottom: 1.5rem;
      color: var(--primary-dark);
    }

    .form-group {
      margin-bottom: 1rem;
    }

    label {
      display: block;
      margin-bottom: 0.5rem;
      font-weight: 500;
      color: var(--text);
    }

    input[type="text"],
    input[type="email"],
    input[type="tel"] {
      width: 100%;
      padding: 0.75rem;
      border: 1px solid var(--border);
      border-radius: 6px;
      font-size: 1rem;
    }

    .form-actions {
      margin-top: 1.5rem;
      display: flex;
      justify-content: flex-end;
      gap: 1rem;
    }

    .btn {
      padding: 0.75rem 1.5rem;
      border: none;
      font-size: 1rem;
      font-weight: 500;
      border-radius: 6px;
      cursor: pointer;
      text-decoration: none;
    }

    .btn-save {
      background-color: var(--success);
      color: white;
    }

    .btn-cancel {
      background-color: var(--danger);
      color: white;
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
  </style>
</head>
<body>

<%
  String id = request.getParameter("id");
  String name = "", specialization = "", email = "", contact = "";
  try {
    Connection con = Dbconnection.connect();
    PreparedStatement ps = con.prepareStatement("SELECT * FROM doctor WHERE id = ?");
    ps.setInt(1, Integer.parseInt(id));
    ResultSet rs = ps.executeQuery();
    if (rs.next()) {
      name = rs.getString("name");
      specialization = rs.getString("specialization");
      email = rs.getString("email");
      contact = rs.getString("contact");
    }
  } catch (Exception e) {
    out.println("Error: " + e);
  }
%>

<div class="sidebar">
  <div class="logo-box">
    <div class="logo-main">DigiHealthCard</div>
    <div class="logo-sub">ADMIN PORTAL</div>
  </div>
  <a href="adminDashboard.jsp"><i class="fas fa-chart-line"></i> <span>Dashboard</span></a>
  <a href="doctorList.jsp" class="active"><i class="fas fa-user-md"></i> <span>Doctor List</span></a>
  <a href="addDoctor.jsp"><i class="fas fa-user-plus"></i> <span>Add Doctor</span></a>
  <a href="patientList.jsp"><i class="fas fa-users"></i> <span>Patient List</span></a>
  <a href="records.jsp"><i class="fas fa-file-medical-alt"></i> <span>Health Records</span></a>
  <a href="setting.jsp"><i class="fas fa-cog"></i> <span>Settings</span></a>
</div>

<div class="main-content">
  <div class="topbar">
    <h2>Edit Doctor</h2>
    <div class="user-profile">
      <img src="https://ui-avatars.com/api/?name=Admin&background=2563eb&color=fff" alt="Admin">
      <span>Administrator</span>
    </div>
  </div>

  <div class="form-section">
    <h3>Edit Doctor Details</h3>
    <form action="updateDoctor.jsp" method="post">
      <input type="hidden" name="id" value="<%= id %>">
      <div class="form-group">
        <label for="name">Name</label>
        <input type="text" name="name" id="name" value="<%= name %>" required>
      </div>
      <div class="form-group">
        <label for="specialization">Specialization</label>
        <input type="text" name="specialization" id="specialization" value="<%= specialization %>" required>
      </div>
      <div class="form-group">
        <label for="email">Email</label>
        <input type="email" name="email" id="email" value="<%= email %>" required>
      </div>
      <div class="form-group">
        <label for="contact">Contact</label>
        <input type="tel" name="contact" id="contact" value="<%= contact %>" required>
      </div>

      <div class="form-actions">
        <button type="submit" class="btn btn-save"><i class="fas fa-save"></i> Save</button>
        <a href="doctorList.jsp" class="btn btn-cancel"><i class="fas fa-times"></i> Cancel</a>
      </div>
    </form>
  </div>
</div>

</body>
</html>
