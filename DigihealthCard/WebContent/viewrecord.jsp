<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="main_project.Dbconnection" %>
<%@ page import="java.sql.*" %>

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

        .sidebar a:hover, 
        .sidebar a.active {
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

        .no-records {
            text-align: center;
            padding: 2rem;
            color: var(--text-light);
        }

        .no-records i {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: var(--text-light);
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
            margin-top: 1.5rem;
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

        @media (max-width: 992px) {
            .sidebar {
                width: 80px;
                overflow: hidden;
            }
            .sidebar .logo-box, 
            .sidebar a span {
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
            table {
                display: block;
                overflow-x: auto;
            }
        }
    </style>
</head>

<%
    String patientEmail = (String) session.getAttribute("patient");
    ResultSet rs = null;
    String Name = "";
    int patientId = -1;

    try {
        Connection con = Dbconnection.connect();

        PreparedStatement getId = con.prepareStatement("SELECT id, name FROM patient WHERE email = ?");
        getId.setString(1, patientEmail);
        ResultSet idResult = getId.executeQuery();
        if (idResult.next()) {
            patientId = idResult.getInt("id");
            Name = idResult.getString("name");
        }

        if (patientId != -1) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM records WHERE patientContactid = ? ORDER BY date DESC");
            ps.setInt(1, patientId);
            rs = ps.executeQuery();
        }
    } catch (Exception e) {
        out.println("Error: " + e);
    }
%>

<body>
    <div class="sidebar">
        <div class="logo-box">
            <div class="logo-main">DigiHealthCard</div>
            <div class="logo-sub">PATIENT PORTAL</div>
        </div>
        <a href="patientDashboard.jsp"><i class="fas fa-user"></i> <span>My Profile</span></a>
        <a href="viewrecord.jsp" class="active"><i class="fas fa-file-medical-alt"></i> <span>Health Records</span></a>
        <a href="patientSettings.jsp"><i class="fas fa-cog"></i> <span>Settings</span></a>
    </div>

    <div class="main-content">
        <div class="topbar">
            <h2>My Health Records</h2>
            <div class="user-profile">
                <img src="https://ui-avatars.com/api/?name=<%= Name %>&background=2563eb&color=fff" alt="Patient">
                <form action="index.jsp" method="post">
                    <button type="submit" class="action-btn btn-danger">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </button>
                </form>
            </div>
        </div>

        <div class="table-section">
            <h3><i class="fas fa-file-medical-alt"></i> Medical History</h3>
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
                        if (rs != null && rs.next()) {
                            do {
                    %>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><%= rs.getString("patientContactid") %></td>
                            <td><%= rs.getString("doctorContactid") %></td>
                            <td><%= rs.getString("recordType") %></td>
                            <td><%= rs.getString("description") %></td>
                            <td><%= rs.getDate("date") %></td>
                        </tr>
                    <%
                            } while (rs.next());
                        } else {
                    %>
                        <tr>
                            <td colspan="6" class="no-records">
                                <i class="fas fa-info-circle"></i>
                                <p>No health records found</p>
                            </td>
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
