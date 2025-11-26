<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
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
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 1.5rem;
      margin-bottom: 2rem;
    }

    .settings-card {
      background: var(--white);
      padding: 1.5rem;
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
      transition: all 0.3s ease;
      border-left: 4px solid var(--primary);
    }

    .settings-card h3 {
      font-size: 1.25rem;
      color: var(--primary-dark);
      margin-bottom: 1.25rem;
      font-weight: 600;
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

    .btn {
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

    .btn i {
      margin-right: 0.5rem;
      font-size: 0.95rem;
    }

    .btn-primary {
      background-color: var(--primary);
      color: var(--white);
    }

    .btn-primary:hover {
      background-color: var(--primary-dark);
    }

    .btn-danger {
      background-color: var(--danger);
      color: var(--white);
    }

    .btn-danger:hover {
      background-color: #dc2626;
    }

    .about-list {
      list-style: none;
      padding: 0;
    }

    .about-list li {
      padding: 0.5rem 0;
      border-bottom: 1px solid var(--border);
    }

    .about-list li:last-child {
      border-bottom: none;
    }

    .about-list strong {
      color: var(--primary-dark);
      min-width: 120px;
      display: inline-block;
    }

    .backup-steps {
      list-style: none;
      padding: 0;
    }

    .backup-steps li {
      padding: 0.5rem 0;
      position: relative;
      padding-left: 1.75rem;
    }

    .backup-steps li::before {
      content: "•";
      color: var(--primary);
      font-weight: bold;
      font-size: 1.25rem;
      position: absolute;
      left: 0;
      top: 0;
    }

    .backup-steps strong {
      color: var(--primary-dark);
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
        grid-template-columns: 1fr;
      }
    }
  </style>
</head>
<body>

<div class="sidebar">
  <div class="logo-box">
    <div class="logo-main">DigiHealthCard</div>
    <div class="logo-sub">ADMIN PORTAL</div>
  </div>
  <a href="adminDashboard.jsp"><i class="fas fa-chart-line"></i> <span>Dashboard</span></a>
  <a href="doctorList.jsp"><i class="fas fa-user-md"></i> <span>Doctor List</span></a>
  <a href="addDoctor.jsp"><i class="fas fa-user-plus"></i> <span>Add Doctor</span></a>
  <a href="patientList.jsp"><i class="fas fa-users"></i> <span>Patient List</span></a>
  <a href="records.jsp"><i class="fas fa-file-medical-alt"></i> <span>Health Records</span></a>
  <a href="setting.jsp" class="active"><i class="fas fa-cog"></i> <span>Settings</span></a>
</div>

<div class="main-content">
  <div class="topbar">
    <h2>System Settings</h2>
    <div class="user-profile">
      <img src="https://ui-avatars.com/api/?name=Admin&background=2563eb&color=fff" alt="Admin">
      <span>Administrator</span>
    </div>
  </div>

  <div class="settings-section">
    <div class="settings-card">
      <h3>Change Admin Password</h3>
      <form action="changeAdminPassword.jsp" method="post">
        <div class="form-group">
          <label for="currentPassword">Current Password</label>
          <input type="password" id="currentPassword" name="currentPassword" required>
        </div>
        <div class="form-group">
          <label for="newPassword">New Password</label>
          <input type="password" id="newPassword" name="newPassword" required>
        </div>
        <div class="form-group">
          <label for="confirmPassword">Confirm Password</label>
          <input type="password" id="confirmPassword" name="confirmPassword" required>
        </div>
        <button type="submit" class="btn btn-primary">
          <i class="fas fa-key"></i> Update Password
        </button>
      </form>
    </div>

    <div class="settings-card">
      <h3>Database Backup</h3>
      <ul class="backup-steps">
        <li>Go to phpMyAdmin</li>
        <li>Select database: <strong>healthcarddb</strong></li>
        <li>Click on <strong>Export</strong> tab</li>
        <li>Select <strong>Quick</strong> export method</li>
        <li>Choose format as <strong>SQL</strong></li>
        <li>Click <strong>Go</strong> to download</li>
      </ul>
    </div>

    <div class="settings-card">
      <h3>About DigiHealthCard</h3>
      <ul class="about-list">
        <li><strong>Version:</strong> 1.0.0</li>
        <li><strong>Developer:</strong> Om Nandre</li>
        <li><strong>Purpose:</strong> Academic Project</li>
        <li><strong>Last Updated:</strong> June 2023</li>
      </ul>
    </div>
  </div>

  <div class="settings-card">
    <button onclick="window.location.href='index.jsp'" class="btn btn-danger">
      <i class="fas fa-sign-out-alt"></i> Logout System
    </button>
  </div>
</div>

</body>
</html>