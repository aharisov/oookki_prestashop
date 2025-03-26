// handle login form submission
function handleSignin(event: Event): void {
    event.preventDefault(); 

    // If authentication is successful, save a cookie
    localStorage.setItem("authenticated", "true");

    // Redirect user after login
    window.location.href = "index.php"; 
}

function handleSignout(event: Event): void {
    event.preventDefault(); 

    localStorage.setItem("authenticated", "false");

    toggleProfileLink();

    const url = window.location.href.split("/");
    if (url[3] && url[3] == "profile") {
        window.location.href = "../index.php"
    } else {
        window.location.href = "index.php"
    }
}

function toggleProfileLink(): void { 
    const checkLogin = localStorage.getItem("authenticated");
    const btnLogin = document.querySelector(".btn-login");
    const btnProfile = document.querySelector(".btn-profile");
    const btnLogout = document.querySelector(".js-logout");

    if (!btnLogin || !btnProfile) return;

    if (checkLogin == "true") {
        btnLogin?.classList.add("hidden");
        btnProfile?.classList.remove("hidden");
        btnLogout?.classList.remove("hidden");
    } else {
        btnLogin?.classList.remove("hidden");
        btnProfile?.classList.add("hidden");
        btnLogout?.classList.add("hidden");
    }
}

const initProfileFunctions = () => {
    const loginForm = document.getElementById("auth-form");
    if (loginForm) {
        loginForm.addEventListener("submit", handleSignin);
    }

    const logoutBtns = document.querySelectorAll(".js-logout");
    if (logoutBtns) {
        logoutBtns.forEach(btn => {
            btn.addEventListener("click", handleSignout);
        })
    }
}

initProfileFunctions();
toggleProfileLink();