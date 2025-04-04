const validateEmail = (email: string): boolean => {
    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    return emailRegex.test(email);
};

const validateBirthDate = (birthDate: string): boolean => {
    const birthDateRegex = /^(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[0-2])\/\d{4}$/;

    if (!birthDateRegex.test(birthDate)) return false;

    const [day, month, year] = birthDate.split("/").map(Number);
    const dateObj = new Date(year, month - 1, day);

    return (
        dateObj.getFullYear() === year &&
        dateObj.getMonth() === month - 1 &&
        dateObj.getDate() === day
    );
};

const formValidation = (
        formClass: string, 
        submitBtn: string, 
        input: string,
        checkRadioGroup: boolean,
        nextEvent: () => void
    ) => {
    const form = document.querySelector<HTMLFormElement>(formClass);
    const submitButton = document.querySelector<HTMLButtonElement>(submitBtn);
    const inputs = document.querySelectorAll<HTMLInputElement | HTMLTextAreaElement>(input);
    const requiredCheckboxes = document.querySelectorAll<HTMLInputElement>("input[type='checkbox'][required]");

    if (!form || !submitButton || inputs.length === 0) return;
    
    // create and append error message
    const showErrorMessage = (input: HTMLInputElement | HTMLTextAreaElement, message: string) => {
        const parent = input.closest(".form-line");
        if (!parent) return;

        let errorMessage = parent.querySelector<HTMLSpanElement>(".error-message");

        if (!errorMessage) {
            errorMessage = document.createElement("span");
            errorMessage.classList.add("error-message");
            parent.appendChild(errorMessage);
        }

        errorMessage.innerHTML = `<i>!</i> ${message}`;
        parent.classList.add("error");
    };

    // remove error message
    const removeErrorMessage = (input: HTMLInputElement | HTMLTextAreaElement) => {
        const parent = input.closest(".form-line");
        if (!parent) return;

        const errorMessage = parent.querySelector<HTMLSpanElement>(".error-message");
        if (errorMessage) errorMessage.remove();

        parent.classList.remove("error");
    };

    const handleBlur = (event: Event) => {
        const input = event.target as HTMLInputElement | HTMLTextAreaElement;
        validateInput(input);
        checkInputs();
    };

    const handleCheckbox = (event: Event) => {
        const input = event.target as HTMLInputElement | HTMLTextAreaElement;
        validateInput(input);
        checkInputs();
    };

    // Validate a single input field
    const validateInput = (input: HTMLInputElement | HTMLTextAreaElement): boolean => {
        const parent = input.closest(".form-line");
        if (!parent) return false;

        const fieldName = parent.querySelector(".form-line__title")?.getAttribute("data-name");

        if (input.hasAttribute("required") && !input.value.trim()) {
            showErrorMessage(input, `Veuillez renseigner votre ${fieldName}`);
            return false;
        }

        if (input.type === "email" && !validateEmail(input.value)) {
            showErrorMessage(input, "Veuillez entrer un email valide");
            return false;
        }

        if ((input.getAttribute("name") === "birthDate" || input.getAttribute("name") === "birthday") && !validateBirthDate(input.value)) {
            showErrorMessage(input, "Veuillez entrer une date valide au format JJ/MM/AAAA");
            return false;
        }

        removeErrorMessage(input);
        return true;
    };

    // Check if all required inputs are filled
    const checkInputs = (): boolean => {
        let allValid = true;

        // validate radio buttons
        if (checkRadioGroup) {
            if (!isRadioGroupSelected("sex")) {
                let radioElem = document.querySelector(".radio-group") as HTMLInputElement;
                if (!radioElem) return false;
                
                showErrorMessage(radioElem, "Veuillez sélectionner votre civilité");

                allValid = false;
                return false;
            }
        }

        // validate inputs
        inputs.forEach(input => {
            if (checkRadioGroup) {
                handleRadioGroup("sex");
                if (!input.value.trim() && isRadioGroupSelected("sex")) {
                    allValid = false;
                    return false;
                }
            } else {
                if (input.hasAttribute("required") && !input.value.trim()) {
                    allValid = false;

                    // input.addEventListener("input", handleBlur);
                    validateInput(input);
                    return false;
                } else {
                    allValid = true;
                }
            }
        });

        // validate checkboxes
        if (requiredCheckboxes) {
            requiredCheckboxes.forEach(checkbox => {
                if (!checkbox.checked) {
                    showErrorMessage(checkbox, "Vous devez accepter les conditions");
                    allValid = false;
                } else {
                    removeErrorMessage(checkbox);
                }
            });
        }

        submitButton.disabled = !allValid;
        return allValid;
    };

    form.addEventListener("submit", (event) => {
        event.preventDefault(); 
        
        if (checkInputs()) {
            nextEvent(); 
        }
    });
    
    // event Listeners
    inputs.forEach(input => {
        input.addEventListener("input", handleBlur); // Re-check when typing
        input.addEventListener("blur", handleBlur);   
    });
    requiredCheckboxes.forEach(checkbox => {
        checkbox.addEventListener("input", handleCheckbox); 
    });

    submitButton.addEventListener("click", () => {
            if (!checkInputs()) {
                const offset = 100;
                const sectionTop = form.getBoundingClientRect().top + window.scrollY - offset;

                // Smooth scroll
                window.scrollTo({ top: sectionTop, behavior: "smooth" });
            }
        }
    );
}

const login = () => {
    // If authentication is successful, save a cookie
    localStorage.setItem("authenticated", "true");

    // Redirect user after login
    window.location.href = "index.php"; 
}
const restoreSuccess = () => {
    const successMess = document.querySelector(".form-note.success");
    const email = document.querySelector(".restore-form input") as HTMLInputElement;
    const span = successMess?.querySelector("span");

    if (!successMess || !email || !span) return;
    span.innerHTML = email?.value;
    successMess.classList.add("active");
}
const updatedAddress = () => {
    window.location.href = "profile-addresses.php"; 
}

formValidation(".order-wrap", ".next-step", ".order-wrap input:required", true, () => showNextStep);
formValidation(".signin-form", "#submit-login", ".signin-form input:required", false, () => login());
formValidation(".signup-form", "#submit-register", ".signup-form .form-line__title + input:required", false, () => login());
formValidation(".restore-form", "#submit-restore", ".restore-form input:required", false, () => restoreSuccess());
formValidation(".address-form", "#submit-address", ".address-form input:required", false, () => updatedAddress());