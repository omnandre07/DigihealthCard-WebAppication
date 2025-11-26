<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, main_project.Dbconnection" %>

<%
    String message = "";
    String messageType = "";
    String userEmail = (String) session.getAttribute("patient");
    if (userEmail == null) {
        response.sendRedirect("patientLogin.jsp");
        return;
    }

    String name = "", age = "", contact = "";

    // Fetch current details
    try {
        Connection con = Dbconnection.connect();
        PreparedStatement pst = con.prepareStatement("SELECT * FROM patient WHERE email=?");
        pst.setString(1, userEmail);
        ResultSet rs = pst.executeQuery();
        if (rs.next()) {
            name = rs.getString("name");
            age = rs.getString("age");
            contact = rs.getString("contact");
        }
    } catch (Exception e) {
        message = "Error loading profile data: " + e.getMessage();
        messageType = "error";
    }

    // Handle form submission
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String newName = request.getParameter("name");
        String newAge = request.getParameter("age");
        String newContact = request.getParameter("contact");

        try {
            Connection con = Dbconnection.connect();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE patient SET name=?, age=?, contact=? WHERE email=?"
            );
            ps.setString(1, newName);
            ps.setString(2, newAge);
            ps.setString(3, newContact);
            ps.setString(4, userEmail);

            int updated = ps.executeUpdate();
            if (updated > 0) {
                message = "Profile updated successfully!";
                messageType = "success";
                name = newName;
                age = newAge;
                contact = newContact;
            } else {
                message = "Update failed. Please try again.";
                messageType = "error";
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
            messageType = "error";
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Edit Profile | DigiHealthCard</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    :root {
      --primary: #2563eb;
      --primary-dark: #1e40af;
      --primary-light: #93c5fd;
      --white: #ffffff;
      --gray-light: #f8fafc;
      --gray-medium: #e2e8f0;
      --gray-dark: #64748b;
      --success: #16a34a;
      --error: #dc2626;
      --warning: #f59e0b;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Segoe UI', 'Roboto', system-ui, sans-serif;
      background: linear-gradient(-45deg, #e0f7ff, #38bdf8, #1e3a8a, #38bdf8);
      background-size: 400% 400%;
      animation: gradientBG 15s ease infinite;
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 20px;
    }

    .profile-container {
      width: 100%;
      max-width: 600px;
      background-color: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      -webkit-backdrop-filter: blur(10px);
      border-radius: 16px;
      box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
      overflow: hidden;
      animation: fadeIn 0.6s ease-out;
    }

    .profile-header {
      background: linear-gradient(135deg, var(--primary), var(--primary-dark));
      color: var(--white);
      padding: 1.5rem;
      text-align: center;
    }

    .profile-header h2 {
      font-size: 1.75rem;
      font-weight: 600;
    }

    .profile-content {
      padding: 2rem;
    }

    .form-group {
      margin-bottom: 1.5rem;
    }

    label {
      display: block;
      font-size: 0.95rem;
      font-weight: 500;
      margin-bottom: 0.5rem;
      color: var(--primary-dark);
    }

    input {
      width: 100%;
      padding: 0.875rem 1rem;
      border: 1px solid var(--gray-medium);
      border-radius: 8px;
      font-size: 0.95rem;
      transition: all 0.2s ease;
    }

    input:focus {
      outline: none;
      border-color: var(--primary);
      box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.2);
    }

    .btn-update {
      background: linear-gradient(to right, var(--primary), var(--primary-dark));
      color: var(--white);
      border: none;
      padding: 1rem;
      border-radius: 8px;
      font-size: 1rem;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.2s ease;
      width: 100%;
    }

    .btn-update:hover {
      transform: translateY(-2px);
      box-shadow: 0 4px 12px rgba(37, 99, 235, 0.2);
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
      color: var(--error);
      border: 1px solid #fecaca;
    }

    .alert i {
      font-size: 1.25rem;
    }

    .footer {
      text-align: center;
      padding: 1rem;
      font-size: 0.875rem;
      color: var(--gray-dark);
    }

    @keyframes gradientBG {
      0% { background-position: 0% 50%; }
      50% { background-position: 100% 50%; }
      100% { background-position: 0% 50%; }
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    @media (max-width: 768px) {
      .profile-content {
        padding: 1.5rem;
      }
    }
  </style>
</head>
<body>

<div class="profile-container">
  <div class="profile-header">
    <h2>Edit Your Profile</h2>
  </div>

  <div class="profile-content">
    <% if (!message.isEmpty()) { %>
      <div class="alert <%= messageType.equals("success") ? "alert-success" : "alert-error" %>">
        <i class="bi <%= messageType.equals("success") ? "bi-check-circle-fill" : "bi-exclamation-circle-fill" %>"></i>
        <span><%= message %></span>
      </div>
    <% } %>

    <form method="post">
      <div class="form-group">
        <label for="name">Full Name</label>
        <input type="text" id="name" name="name" value="<%= name %>" required>
      </div>

      <div class="form-group">
        <label for="age">Age</label>
        <input type="number" id="age" name="age" value="<%= age %>" min="1" max="120" required>
      </div>

      <div class="form-group">
        <label for="contact">Contact Number</label>
        <input type="tel" id="contact" name="contact" value="<%= contact %>" required>
      </div>

      <button type="submit" class="btn-update">
        <i class="bi bi-save"></i> Update Profile
      </button>
    </form>
  </div>

  <div class="footer">
    &copy; <span id="current-year"></span> DigiHealthCard. All rights reserved.
  </div>
</div>

<script>
  document.getElementById('current-year').textContent = new Date().getFullYear();
</script>

</body>
</html>