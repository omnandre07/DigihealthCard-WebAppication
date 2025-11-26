<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="main_project.Dbconnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Health Records | DigiHealthCard</title>
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

    .dashboard-cards {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
      gap: 1.5rem;
      margin-bottom: 2rem;
    }

    .card {
      background: var(--white);
      padding: 1.5rem;
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      transition: all 0.3s ease;
      border-left: 4px solid var(--primary);
    }

    .card:hover {
      transform: translateY(-5px);
      box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }

    .card h4 {
      font-size: 0.95rem;
      color: var(--text-light);
      font-weight: 500;
      margin-bottom: 0.5rem;
    }

    .card p {
      font-size: 1.75rem;
      font-weight: 700;
      color: var(--primary-dark);
      margin: 0;
    }

    .card i {
      font-size: 2rem;
      color: var(--primary);
      margin-bottom: 1rem;
    }

    .table-section {
      background: var(--white);
      padding: 1.5rem;
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      margin-bottom: 2rem;
    }

    .table-section h3 {
      font-size: 1.25rem;
      color: var(--primary-dark);
      margin-bottom: 1.25rem;
      font-weight: 600;
    }

    table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0;
    }

    table thead th {
      background-color: var(--primary);
      color: var(--white);
      padding: 0.85rem 1rem;
      font-weight: 500;
      text-align: left;
      position: sticky;
      top: 0;
    }

    table tbody tr {
      transition: all 0.2s ease;
    }

    table tbody tr:hover {
      background-color: rgba(147, 197, 253, 0.1);
    }

    table td {
      padding: 0.85rem 1rem;
      border-bottom: 1px solid var(--border);
      color: var(--text);
    }

    .status-badge {
      display: inline-block;
      padding: 0.25rem 0.75rem;
      border-radius: 50px;
      font-size: 0.75rem;
      font-weight: 500;
    }

    .status-active {
      background-color: rgba(16, 185, 129, 0.1);
      color: var(--success);
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
    }
  </style>
</head>
<body>

<%
  ResultSet rs = null;
  try {
    Connection con = Dbconnection.connect();
    PreparedStatement ps = con.prepareStatement("SELECT * FROM records ORDER BY date DESC");
    rs = ps.executeQuery();
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
  <a href="doctorList.jsp"><i class="fas fa-user-md"></i> <span>Doctor List</span></a>
  <a href="addDoctor.jsp"><i class="fas fa-user-plus"></i> <span>Add Doctor</span></a>
  <a href="patientList.jsp"><i class="fas fa-users"></i> <span>Patient List</span></a>
  <a href="#" class="active"><i class="fas fa-file-medical-alt"></i> <span>Health Records</span></a>
  <a href="setting.jsp"><i class="fas fa-cog"></i> <span>Settings</span></a>
</div>

<div class="main-content">
  <div class="topbar">
    <h2>Health Records</h2>
    <div class="user-profile">
      <img src="https://ui-avatars.com/api/?name=Admin&background=2563eb&color=fff" alt="Admin">
      <span>Administrator</span>
    </div>
  </div>

  <div class="table-section">
    <h3>All Health Records</h3>
    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Patient Contact</th>
          <th>Doctor Contact</th>
          <th>Record Type</th>
          <th>Description</th>
          <th>Date</th>
        </tr>
      </thead>
      <tbody>
        <%
          while (rs != null && rs.next()) {
        %>
        <tr>
          <td><%= rs.getInt("id") %></td>
          <td><%= rs.getString("patientContactid") %></td>
          <td><%= rs.getString("doctorContactid") %></td>
          <td><span class="status-badge status-active"><%= rs.getString("recordType") %></span></td>
          <td><%= rs.getString("description") %></td>
          <td><%= rs.getDate("date") %></td>
        </tr>
        <%
          }
        %>
      </tbody>
    </table>
  </div>
</div>

</body>
</html>
