// common accordion
const accordion = () => {
    const accordionHeaders = document.querySelectorAll(".accordion-head");

    if (accordionHeaders.length > 0) {
        accordionHeaders.forEach(el => {
            el.addEventListener("click", function (this: HTMLElement) {
                const accordionItem = this.parentElement;
                const isActive = accordionItem!.classList.contains("active");  
                const isOption = accordionItem!.classList.contains("config-option");

                if (!accordionItem) return;

                const accordionContainer = accordionItem.closest(".accordion-container");
                const accordionShowAll = accordionItem.closest(".accordion-show-all");
                // Close all accordion items
                if (accordionContainer) {
                    accordionContainer.querySelectorAll(".accordion-item").forEach(item => {
                        item.classList.remove("active");
                    });
                } else if (accordionShowAll) {

                } else {
                    document.querySelectorAll(".accordion-item").forEach(item => {
                        item.classList.remove("active");
                    });
                }

                if (accordionShowAll) { 
                    accordionItem.classList.toggle("active");
                } else {
                    // Toggle only the clicked one
                    if (!isActive || isOption) {
                        accordionItem.classList.add("active");
                    }
                }
            });
        });
    }
}
// scroll to top button
const scrollToTop = (): void => {
    const scrollToTopBtn = document.querySelector(".up-btn") as HTMLDivElement;

    if (!scrollToTopBtn) return;

    // Show button when user scrolls down
    window.addEventListener("scroll", function () {
        if (window.scrollY > 400) {
            scrollToTopBtn.style.opacity = "1";
        } else {
            scrollToTopBtn.style.opacity = "0";
        }
    });

    // Scroll to top on button click
    scrollToTopBtn.addEventListener("click", function () {
        window.scrollTo({
            top: 0,
            behavior: "smooth"
        });
    });
}

// show/hide search input in mobile version
const openCloseSearch = (): void => {
    const btn = document.querySelector('.js-open-search');
    const searchForm = document.querySelector('.header__search');

    if (!btn || !searchForm) return;

    btn.addEventListener('click', function() {
        searchForm.classList.toggle('active');
    })
}

// open modal windows
const openModal = () => {
    const body = document.querySelector("body") as HTMLElement;
    const bg = document.querySelector(".bg-modal") as HTMLDivElement;
    const openButtons = document.querySelectorAll("[data-modal]");
    const closeButtons = document.querySelectorAll(".modal .modal-close");

    if (!bg || !openButtons || !closeButtons) return;

    openButtons.forEach(button => {
        button.addEventListener("click", function (this: HTMLElement, e: Event) {
            e.preventDefault();
            const modalId = this.getAttribute("data-modal");
            if (!modalId) return;
            const modal = document.getElementById(modalId);
            const dataId = this.getAttribute("data-id");

            if (modal) {
                bg.classList.add("show", "on-top");
                modal.classList.add("show");

                if (dataId) {
                    modal.setAttribute("data-id", dataId);
                }
            }
        });
    });

    closeButtons.forEach(button => {
        button.addEventListener("click", function (this: HTMLElement | null) {
            bg.classList.remove("show", "on-top");
            this!.closest(".modal")!.classList.remove("show");
            this!.closest(".modal")!.setAttribute("data-id", "");
            body.classList.remove("lock");
        });
    });

    window.addEventListener("click", function (e) {
        if (e.target === bg) {
            document.querySelectorAll(".modal").forEach(modal => {
                modal.classList.remove("show");
            });
            bg.classList.remove("show");
            body.classList.remove("lock");
        }
    });
}
// toggle password visibility
const showHidePass = (input: string): void => {
    const passwordInput = document.getElementById(input) as HTMLInputElement;
    if (!passwordInput) return;

    const parent = passwordInput.closest(".inner");
    if (!parent) return;
    
    const toggleButton = parent.querySelector(".js-toggle-pass") as HTMLElement;
    if (!toggleButton) return;

    toggleButton.addEventListener("click", () => {
        let iconHide = toggleButton!.querySelector('.fa-eye-slash') as HTMLElement;
        let iconShow = toggleButton!.querySelector('.fa-eye') as HTMLElement;

        if (passwordInput.type === "password") {
            passwordInput.type = "text";
            iconHide.style.display = "block";
            iconShow.style.display = "none";
        } else {
            passwordInput.type = "password";
            iconHide.style.display = "none";
            iconShow.style.display = "block";
        }
    });

}

document.addEventListener('DOMContentLoaded',  function(event) {
    accordion();
    scrollToTop();
    openCloseSearch();
    openModal();
    showHidePass("field-password");
    showHidePass("field-new_password");
});