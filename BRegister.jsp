<!doctype html>
<html lang="en">
<head>
  <title>Buyer Center ? Login/Register</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet" />
  <style>
    :root{
      --bg1:#67b3f3;
      --bg2:#6bd28f;
      --card:#ffffff;
      --text:#2b2f36;
      --muted:#6b7280;
      --line:#e5e7eb;
      --accent:#7ecd8d;
      --accent-hover:#69b678;
      --link:#1b84ff;
      --shadow: 0 20px 60px rgba(20, 27, 45, .15);
      --radius: 18px;
    }
    * { box-sizing: border-box; }
    html,body{height:100%}
    body{
      margin:0;
      font-family: Inter, system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial, "Apple Color Emoji", "Segoe UI Emoji";
      color:var(--text);
      background: radial-gradient(90% 110% at 10% 10%, rgba(255,255,255,.2) 0%, rgba(255,255,255,0) 60%),
                  linear-gradient(135deg, var(--bg1), var(--bg2));
    }
    .wrap{
      min-height:100vh;
      display:grid;
      place-items:center;
      padding:32px;
    }
    .card{
      width:min(1100px, 100%);
      background:var(--card);
      border-radius:24px;
      box-shadow:var(--shadow);
      overflow:hidden;
      display:grid;
      grid-template-columns: 1.1fr 1fr; 
    }

    /* Left / Form */
    .left{
      padding:56px 56px 28px;
      display:flex; flex-direction:column; gap:28px;
    }
    .brand{ display:flex; align-items:center; gap:12px; }
    .logo-text{ font-weight:700; font-size:28px; letter-spacing:.2px; }
    .badge{ font-size:12px; background:#ffcf7d; color:#6b4e00; padding:4px 8px; border-radius:6px; font-weight:700; }

    h1{ font-size:20px; margin:8px 0 4px; }
    .sub{ color:var(--muted); font-size:14px; }

    .tabs{
      display:flex;
      gap:12px;
      margin-bottom:16px;
    }
    .tab{
      padding:8px 16px;
      cursor:pointer;
      border-bottom:3px solid transparent;
      font-weight:600;
      color:var(--muted);
      transition: all 0.2s ease;
    }
    .tab.active{
      border-color:var(--accent);
      color:var(--text);
    }

    .form{ display:grid; gap:14px; margin-top:4px; }
    .input{ position:relative; }
    .input input{
      width:100%;
      height:44px;
      padding:0 44px 0 42px;
      background:#fff;
      border:1px solid var(--line);
      border-radius:10px;
      font-size:14px;
      outline:none;
      transition:border .2s, box-shadow .2s;
    }
    .input input:focus{
      border-color:#b3d7ff;
      box-shadow:0 0 0 3px rgba(27,132,255,.15);
    }
    .icon{
      position:absolute; left:12px; top:50%; transform:translateY(-50%);
      width:18px; height:18px; opacity:.6;
    }
    .peek{
      position:absolute; right:10px; top:50%; transform:translateY(-50%);
      background:none; border:none; padding:6px; cursor:pointer; opacity:.6;
    }
    .peek:hover{ opacity:.9; }

    .actions{ display:grid; gap:12px; margin-top:6px; }
    .btn{
      height:42px; border:none; border-radius:10px; cursor:pointer;
      background:var(--accent);
      color:white; font-weight:600; font-size:15px;
      transition:transform .02s ease, background .2s;
      box-shadow:0 8px 20px rgba(106, 194, 129, .35);
    }
    .btn:active{ transform:translateY(1px); }
    .btn:hover{ background:var(--accent-hover); }

    .links{ display:flex; justify-content:space-between; align-items:center; gap:12px; color:var(--muted); font-size:13px; margin-top:4px; }
    a{ color:var(--link); text-decoration:none; }
    a:hover{ text-decoration:underline; }

    .footer{ color:#9aa1ab; font-size:12px; text-align:center; margin-top:auto; padding-top:12px; }

    /* Right / Illustration */
    .right{
      padding:56px 56px 56px 0;
      display:grid; place-items:center;
      background: radial-gradient(60% 60% at 70% 30%, rgba(27,132,255,.07), transparent 60%);
    }
    .hero{ max-width:480px; width:100%; }
    .tagline{ margin-top:18px; line-height:1.1; }
    .tagline .big{ font-size:44px; font-weight:700; }
    .tagline .brand{ color:#ff3d5a; font-weight:800; }

    /* Responsive */
    @media (max-width: 980px){
      .card{ grid-template-columns: 1fr; }
      .right{ display:none; }
      .left{ padding:40px 28px 22px; }
    }
    .warning {
      color: #721c24;
      background-color: #f8d7da;
      border: 1px solid #f5c6cb;
      padding: 10px;
      margin-top: 10px;
      border-radius: 5px;
      display: none; /* By default hidden */
    }
      .error {
            color: red;
        }
  </style>
</head>
<body>
  <div class="wrap">
    <main class="card" aria-labelledby="welcomeTitle">
      <section class="left">
        <div class="brand" aria-label="Brand">
          <div class="logo-text">Thanks for Chossing our Platform</div>
          <span class="badge">Happy Shopping</span>
        </div>
        <form action="BuyerLog.jsp">
        <div class="tabs">
          <button class="btn" type="submit">Login</button>  
          <div class="tab active" data-tab="Register">Register</div>
          </div>
         </form>
          <form class="form" id="registerForm" action="BuyerReg2.jsp" onsubmit="validatePasswords(event)">
          <label class="input">
            <svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2a10 10 0 1 0 10 10A10 10 0 0 0 12 2z"/></svg>
            <input type="text" name="Name" placeholder="Full Name"  value="<%= request.getAttribute("Name") == null ? "" : request.getAttribute("Name") %>" required />
          </label>
          <label class="input">
            <svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2a10 10 0 1 0 10 10A10 10 0 0 0 12 2z"/></svg>
            <input type="tel" name="CNo" id="CNo2" maxlength="10" placeholder="Contact No" pattern="[789][0-9]{9}" value="<%= request.getAttribute("CNo") == null ? "" : request.getAttribute("CNo") %>"  required />
            <font id="X"></font>
          </label> 
         <label class="input">
          <svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" 
            stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
           <rect x="2" y="4" width="20" height="16" rx="3"/>
            <path d="M22 7L12 13 2 7"/>
         </svg>
          <input type="email" name="Email" placeholder="Email Address" value="<%= request.getAttribute("Email") == null ? "" : request.getAttribute("Email") %>"  required />
         </label>

<!-- Error message should be OUTSIDE the label -->
         <p id="errorBox" class="warning">
         <%= request.getAttribute("error") == null ? "" : request.getAttribute("error") %>  
         </p>

        <script>
        const errorBox = document.getElementById("errorBox");
        if (errorBox.innerText.trim() !== "")
        {
        errorBox.style.display = "block";
        }
</script>
	  <label class="input">
            <svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="11" width="18" height="11" rx="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
            <input id="pwdRegister1" name="Password" type="password" placeholder="Password" value="<%= request.getAttribute("Password") == null ? "" : request.getAttribute("Password") %>" required />
            <button class="peek" type="button" onclick="togglePwd('pwdRegister1', this)"><svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8S1 12 1 12z"/><circle cx="12" cy="12" r="3"/></svg></button>
            
          </label>
          <label class="input">
            <svg class="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="11" width="18" height="11" rx="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
            <input id="pwdRegister2" type="password" placeholder="ConfirmPassword" required aria-label="Password" />
            <button class="peek" type="button" onclick="togglePwd('pwdRegister2', this)" onkeyup="checkpwd('pwdRegister1','pwdRegister2')"><svg width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8S1 12 1 12z"/><circle cx="12" cy="12" r="3"/></svg></button>
          </label>
             <div id="error-message" class="error"></div><br>
          <div class="actions">
            <button class="btn" type="submit">Register</button>
          </div>
          <div class="actions">
          <button class="btn" type="button" onclick="goBack()">Back</button>
           <font id="Y"></font>        
         </div>
        </form>
           </section>
        <aside class="right" aria-hidden="true">
        <div>
          <svg class="hero" viewBox="0 0 540 380" xmlns="http://www.w3.org/2000/svg">
            <g>
              <rect x="90" y="210" rx="28" ry="28" width="360" height="150" fill="#1f2a37"/>
              <rect x="110" y="228" rx="18" ry="18" width="320" height="114" fill="#0f172a"/>
              <rect x="125" y="245" width="290" height="15" rx="6" fill="#e5e7eb"/>
              <rect x="125" y="266" width="220" height="15" rx="6" fill="#cbd5e1"/>
              <rect x="125" y="287" width="180" height="15" rx="6" fill="#94a3b8"/>
            </g>
          </svg>
          <div class="tagline"><div class="big">Grow your business<br/></div></div>
        </div>
      </aside>
                <script>
            function goBack()
            {
                window.location.href="Log.jsp"; 
            }
             function togglePwd(id, btn){
      const input = document.getElementById(id);
      input.type = input.type === 'password' ? 'text' : 'password';
            }
            function Contact()
            {
             a=document.getElementById("CNo2").value;
             var re=/^\d\d\d\d\d\d\d\d\d\d$/;
             if(re.test(a))
             {
                 document.getElementById("X").innerHTML="welcome"; 
             }
             else
             {
                  document.getElementById("X").innerHTML="invalid data"; 
             }
            }
             function validatePasswords(event) {
            const password = document.getElementById("pwdRegister1").value;
            const confirmPassword = document.getElementById("pwdRegister2").value;
            const errorMsg = document.getElementById("error-message");

            if (password !== confirmPassword) {
                errorMsg.textContent = "Passwords do not match!";
                event.preventDefault();  // Prevent form submission
            } else {
                errorMsg.textContent = "";  // Clear error
            }
        }
        </script>
</body>
</html>
