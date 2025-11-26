<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, main_project.Dbconnection" %>
<%
    String doctorEmail = (String) session.getAttribute("doctor");
    String doctorName = "";
    ResultSet records = null;

    if (doctorEmail == null) {
        response.sendRedirect("doctorLogin.jsp");
        return;
    }

    try {
        Connection con = Dbconnection.connect();

        // Get doctor name
        PreparedStatement pst = con.prepareStatement("SELECT name FROM doctor WHERE email=?");
        pst.setString(1, doctorEmail);
        ResultSet rs = pst.executeQuery();
        if (rs.next()) {
            doctorName = rs.getString("name");
        }
        rs.close();
        pst.close();

        // Get patient records
        String sql = "SELECT * FROM records WHERE doctorContactid = (SELECT id FROM doctor WHERE email = ?) ORDER BY date DESC";
        pst = con.prepareStatement(sql);
        pst.setString(1, doctorEmail);
        records = pst.executeQuery();

    } catch (Exception e) {
        out.println("Error fetching records: " + e.getMessage());
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Patient History | DigiHealthCard</title>
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

    .history-section {
      background: var(--white);
      padding: 1.5rem;
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      margin-bottom: 2rem;
    }

    .history-section h3 {
      font-size: 1.25rem;
      color: var(--primary-dark);
      margin-bottom: 1.25rem;
      font-weight: 600;
      display: flex;
      align-items: center;
      gap: 0.75rem;
    }

    .history-section h3 i {
      color: var(--primary);
    }

    .records-table {
      width: 100%;
      border-collapse: collapse;
    }

    .records-table th, 
    .records-table td {
      padding: 0.85rem 1rem;
      text-align: left;
      border-bottom: 1px solid var(--border);
    }

    .records-table th {
       background-color: var(--primary);
      font-weight: 600;
      color: white;
    }

    .records-table tr:hover {
      background-color: #f8fafc;
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

    .action-btn {
      display: inline-flex;
      align-items: center;
      padding: 0.5rem 1rem;
      border-radius: 6px;
      font-size: 0.85rem;
      font-weight: 500;
      text-decoration: none;
      transition: all 0.2s ease;
      cursor: pointer;
      border: none;
    }

    .action-btn i {
      margin-right: 0.5rem;
      font-size: 0.85rem;
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

    .action-btn i {
      margin-right: 0.5rem;
      font-size: 0.95rem;
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

    .no-records {
      text-align: center;
      padding: 2rem;
      color: var(--text-light);
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
      .records-table {
        display: block;
        overflow-x: auto;
      }
    }
  </style>
</head>
<body>

<div class="sidebar">
  <div class="logo-box">
    <div class="logo-main">DigiHealthCard</div>
    <div class="logo-sub">DOCTOR PORTAL</div>
  </div>
  <a href="doctorDashboard.jsp"><i class="fas fa-tachometer-alt"></i> <span>Dashboard</span></a>
  <a href="addPatientRecord.jsp"><i class="fas fa-user-plus"></i> <span>Add Records</span></a>
  <a href="viewPatientHistory.jsp" class="active"><i class="fas fa-file-medical-alt"></i> <span>View History</span></a>
  <a href="doctorSettings.jsp"><i class="fas fa-cog"></i> <span>Settings</span></a>
</div>

<div class="main-content">
  <div class="topbar">
    <h2>Patient Medical History</h2>
    <div class="user-profile">
      <img src="https://ui-avatars.com/api/?name=<%= doctorName %>&background=2563eb&color=fff" alt="Doctor">
      <form action="logout" method="post">
        <button type="submit" class="action-btn btn-danger">
          <i class="fas fa-sign-out-alt"></i> Logout
        </button>
      </form>
    </div>
  </div>

  <div class="history-section">
    <h3><i class="fas fa-history"></i> Patient Records</h3>

    <%
        boolean hasRecords = false;
        if (records != null) {
            while (records.next()) {
                if (!hasRecords) {
                    hasRecords = true;
    %>
                    <table class="records-table">
                      <thead>
                        <tr>
                          <th>Doctor Contact ID</th>
                          <th>Patient Contact ID</th>
                          <th>Record Type</th>
                          <th>Description</th>
                          <th>Date</th>
                          <th>Actions</th>
                        </tr>
                      </thead>
                      <tbody>
    <%
                }
    %>
                        <tr>
                          <td><%= records.getInt("doctorContactid") %></td>
                          <td><%= records.getInt("patientContactid") %></td>
                          <td>
                            <span class="status-badge status-active">
                              <%= records.getString("recordType") %>
                            </span>
                          </td>
                          <td><%= records.getString("description") %></td>
                          <td><%= records.getDate("date") %></td>
                          <td>
                            <button class="action-btn btn-primary">
                              <i class="fas fa-eye"></i> View
                            </button>
                          </td>
                        </tr>
    <%
            }
        }
        if (hasRecords) {
    %>
                      </tbody>
                    </table>
    <%
        } else {
    %>
            <div class="no-records">
              <i class="fas fa-file-medical" style="font-size: 2rem; margin-bottom: 1rem;"></i>
              <h4>No patient records found</h4>
              <p>You haven't added any medical records yet</p>
            </div>
    <%
        }
    %>

  </div>
</div>

</body>
</html>
