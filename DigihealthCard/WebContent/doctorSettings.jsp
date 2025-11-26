<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, main_project.Dbconnection" %>
<%
    String doctorEmail = (String) session.getAttribute("doctor");
    String name = "", specialization = "", contact = "";
    int doctorId = 0;

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
<title>Doctor Settings | DigiHealthCard</title>
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
        --danger: #ef4444;
    }
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: 'Poppins', sans-serif; background-color: #f1f5f9; color: var(--text); }
    .sidebar {
        width: 280px;
        background: linear-gradient(180deg, var(--primary), var(--primary-dark));
        position: fixed;
        height: 100vh;
        padding: 2rem 0;
        box-shadow: 4px 0 10px rgba(0,0,0,0.1);
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
    .main-content { margin-left: 280px; padding: 2rem; }
    .topbar {
        background: var(--white); padding: 1.25rem 2rem; border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 1.5rem;
        display: flex; justify-content: space-between; align-items: center;
    }
    .topbar h2 { font-size: 1.5rem; color: var(--primary-dark); font-weight: 600; }
    .user-profile { display: flex; align-items: center; gap: 0.75rem; }
    .user-profile img { width: 40px; height: 40px; border-radius: 50%; }
    .settings-section {
        background: var(--white); padding: 1.5rem; border-radius: 12px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.05); margin-bottom: 2rem;
    }
    .settings-section h3 {
        font-size: 1.25rem; color: var(--primary-dark);
        margin-bottom: 1.25rem; font-weight: 600;
        display: flex; align-items: center; gap: 0.75rem;
    }
    .form-group { margin-bottom: 1.5rem; }
    .form-group label { display: block; font-weight: 500; margin-bottom: 0.5rem; color: var(--primary-dark); }
    .form-group input {
        width: 100%; padding: 0.875rem 1rem; border: 1px solid var(--border);
        border-radius: 8px; font-size: 0.95rem; transition: all 0.2s ease;
    }
    .form-group input:focus {
        outline: none; border-color: var(--primary);
        box-shadow: 0 0 0 3px rgba(37,99,235,0.1);
    }
    .action-btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: 0.75rem 1.25rem;
    border-radius: 8px;
    font-size: 0.95rem;
    font-weight: 500;
    text-decoration: none;
    transition: all 0.2s ease;
    cursor: pointer;
    border: none;
    gap: 0.5rem; /* space between icon and text */
}

.action-btn i {
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
    
</style>
</head>
<body>

<div class="sidebar">
    <div class="logo-box">
        <div class="logo-main">DigiHealthCard</div>
        <div class="logo-sub">DOCTOR PORTAL</div>
    </div>
    <a href="doctorDashboard.jsp"><i class="fas fa-tachometer-alt"></i><span>Dashboard</span></a>
    <a href="addPatientRecord.jsp"><i class="fas fa-user-plus"></i><span>Add Records</span></a>
    <a href="viewPatientHistory.jsp"><i class="fas fa-file-medical-alt"></i><span>View History</span></a>
    <a href="doctorSettings.jsp" class="active"><i class="fas fa-cog"></i><span>Settings</span></a>
</div>

<div class="main-content">
    <div class="topbar">
        <h2>Settings</h2>
        <div class="user-profile">
            <img src="https://ui-avatars.com/api/?name=<%= name %>&background=2563eb&color=fff" alt="Doctor">
            <form action="index.jsp" method="post" style="display:inline;">
                <button type="submit" class="action-btn btn-danger"><i class="fas fa-sign-out-alt"></i> Logout</button>
            </form>
        </div>
    </div>

    <!-- Update Profile Section -->
    <div class="settings-section">
        <h3><i class="fas fa-user-cog"></i> Update Profile</h3>
        <form action="updateDoctorProfile.jsp" method="post">
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="name" value="<%= name %>" required>
            </div>
            <div class="form-group">
                <label>Specialization</label>
                <input type="text" name="specialization" value="<%= specialization %>" required>
            </div>
            
            <button type="submit" class="action-btn btn-primary"><i class="fas fa-save"></i> Save Changes</button>
        </form>
    </div>

    <!-- Change Email Section -->
    <div class="settings-section">
        <h3><i class="fas fa-envelope"></i> Change Email & Contact</h3>
        <form action="updateDoctorPreferences.jsp" method="post">
            <div class="form-group">
                <label>New Email</label>
                <input type="email" name="newEmail" value="<%= doctorEmail %>" required>
            </div>
            <div class="form-group">
                <label>New Contact Number</label>
                <input type="text" name="newContact" value="<%= contact %>" required>
            </div>
           <button type="submit" class="action-btn btn-primary"><i class="fas fa-envelope-open"></i> Update Email & Contact</button>
        </form>
    </div>

    <!-- Change Password Section -->
    <div class="settings-section">
        <h3><i class="fas fa-lock"></i> Change Password</h3>
        <form action="updateDoctorPassword.jsp" method="post">
            <div class="form-group">
                <label>Current Password</label>
                <input type="password" name="currentPassword" required>
            </div>
            <div class="form-group">
                <label>New Password</label>
                <input type="password" name="newPassword" required>
            </div>
            <div class="form-group">
                <label>Confirm New Password</label>
                <input type="password" name="confirmPassword" required>
            </div>
      <button type="submit" class="action-btn btn-primary"><i class="fas fa-key"></i> Update Password</button>
        </form>
    </div>

</div>

</body>
</html>
