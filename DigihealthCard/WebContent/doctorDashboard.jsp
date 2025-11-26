<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, main_project.Dbconnection, java.util.*" %>
<%
    String doctorEmail = (String) session.getAttribute("doctor");
    String name = "", specialization = "", contact = "";
    int doctorId = 0;
    int totalPatients = 0, totalRecords = 0;

    if (doctorEmail != null) {
        try {
            Connection con = Dbconnection.connect();

            PreparedStatement pst = con.prepareStatement("SELECT * FROM doctor WHERE email=?");
            pst.setString(1, doctorEmail);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                doctorId = rs.getInt("id");
                name = rs.getString("name");
                specialization = rs.getString("specialization");
                contact = rs.getString("contact");
            }

            pst = con.prepareStatement("SELECT COUNT(*) AS totalPatients FROM records WHERE doctorContactid=?");
            pst.setInt(1, doctorId);
            rs = pst.executeQuery();
            if (rs.next()) totalPatients = rs.getInt("totalPatients");

            pst = con.prepareStatement("SELECT COUNT(*) AS totalRecords FROM records WHERE doctorContactid=?");
            pst.setInt(1, doctorId);
            rs = pst.executeQuery();
            if (rs.next()) totalRecords = rs.getInt("totalRecords");

            con.close();
        } catch (Exception e) {
            out.println("Error fetching profile: " + e.getMessage());
        }
    } else {
        response.sendRedirect("doctorLogin.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Doctor Dashboard | DigiHealthCard</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
      padding: 1.5rem;
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      margin-bottom: 2rem;
    }

    .form-section h3 {
      font-size: 1.25rem;
      color: var(--primary-dark);
      margin-bottom: 1.25rem;
      font-weight: 600;
      display: flex;
      align-items: center;
      gap: 0.75rem;
    }

    .form-section h3 i {
      color: var(--primary);
    }

    .form-group {
      margin-bottom: 1.5rem;
    }

    .form-group label {
      display: block;
      font-weight: 500;
      margin-bottom: 0.5rem;
      color: var(--primary-dark);
    }

    .form-group input, 
    .form-group select,
    .form-group textarea {
      width: 100%;
      padding: 0.875rem 1rem;
      border: 1px solid var(--border);
      border-radius: 8px;
      font-size: 0.95rem;
      transition: all 0.2s ease;
    }

    .form-group textarea {
      min-height: 120px;
      resize: vertical;
    }

    .form-group input:focus,
    .form-group select:focus,
    .form-group textarea:focus {
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

    .alert {
      padding: 1rem;
      border-radius: 8px;
      margin-bottom: 1.5rem;
      font-size: 0.95rem;
      display: flex;
      align-items: center;
      gap: 0.75rem;
    }

    .alert-success {
      background-color: #f0fdf4;
      color: var(--success);
      border: 1px solid #bbf7d0;
    }

    .alert-error {
      background-color: #fef2f2;
      color: var(--danger);
      border: 1px solid #fecaca;
    }

    .alert i {
      font-size: 1.25rem;
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

    .profile-section, .chart-section {
        background: #fff;
        padding: 1.5rem;
        border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        margin-bottom: 1.5rem;
    }
    .profile-section h3, .chart-section h3 {
        margin-bottom: 1rem;
        color: #1e40af;
        font-weight: 600;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }
    .profile-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 1rem;
    }
    .profile-table td.label {
        font-weight: 500;
        color: #1e293b;
        width: 35%;
        padding: 0.5rem 0;
    }
    .profile-table td {
        padding: 0.5rem 0;
        border-bottom: 1px solid #e2e8f0;
    }
   
</style>
</head>
<body>

<div class="sidebar">
    <div class="logo-box">
        <div class="logo-main">DigiHealthCard</div>
        <div class="logo-sub">DOCTOR PORTAL</div>
    </div>
   
  <a href="#" class="active"><i class="fas fa-tachometer-alt"></i> <span>Dashboard</span></a>
  <a href="addPatientRecord.jsp" ><i class="fas fa-user-plus"></i> <span>Add Records</span></a>
  <a href="viewPatientHistory.jsp"><i class="fas fa-file-medical-alt"></i> <span>View History</span></a>
  <a href="doctorSettings.jsp"><i class="fas fa-cog"></i> <span>Settings</span></a>
</div>
    

<div class="main-content">
    <div class="topbar">
        <h2>Welcome, Dr. <%= name %></h2>
        <div class="user-profile">
            <img src="https://ui-avatars.com/api/?name=<%= name %>&background=2563eb&color=fff" alt="Doctor" style="width:40px;height:40px;border-radius:50%;">
            <form action="index.jsp" method="post" style="display:inline;">
                <button type="submit" class="action-btn btn-danger"><i class="fas fa-sign-out-alt"></i> Logout</button>
            </form>
        </div>
    </div>

    <div class="profile-section">
        <h3><i class="fas fa-id-card"></i> Doctor Information</h3>
        <table class="profile-table">
            <tr><td class="label">Full Name:</td><td>Dr. <%= name %></td></tr>
            <tr><td class="label">Specialization:</td><td><%= specialization %></td></tr>
            <tr><td class="label">Email Address:</td><td><%= doctorEmail %></td></tr>
            <tr><td class="label">Contact Number:</td><td><%= contact %></td></tr>
        </table>
        <button class="action-btn btn-primary" onclick="location.href='editDoctorProfile.jsp'">
            <i class="fas fa-user-edit"></i> Edit Profile
        </button>
    </div>

    <div class="chart-section">
        <h3><i class="fas fa-chart-bar"></i> My Statistics</h3>
        <canvas id="doctorStatsChart" height="100"></canvas>
    </div>
</div>

<script>
const ctx = document.getElementById('doctorStatsChart').getContext('2d');
new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ['Patients Treated', 'Total Records'],
        datasets: [{
            label: 'Count',
            data: [<%= totalPatients %>, <%= totalRecords %>],
            backgroundColor: ['#2563eb', '#10b981'],
            borderRadius: 8,
            borderSkipped: false
        }]
    },
    options: {
        responsive: true,
        plugins: {
            legend: { display: false },
            tooltip: {
                backgroundColor: '#1e293b',
                titleColor: '#fff',
                bodyColor: '#fff',
                padding: 10,
                cornerRadius: 6
            }
        },
        scales: {
            y: {
                beginAtZero: true,
                ticks: { stepSize: 1 }
            }
        }
    }
});
</script>

</body>
</html>
