const sortDropdown = (): void => {
    const sortActive = document.querySelector(".sort-active") as HTMLElement | null;
    const sortList = document.querySelector(".sort-list") as HTMLElement | null;
    const sortButtons = document.querySelectorAll(".sort-list-inner button") as NodeListOf<HTMLButtonElement>;
    const screenW = window.innerWidth;
    const sortCloseBtn = document.querySelector(".js-sort-close") as HTMLElement | null;
    const bgModal = document.querySelector(".bg-modal") as HTMLElement | null;
    const sortInput = document.querySelector(".sort-list input[name='sort']") as HTMLInputElement | null;
    const sortHeadActive = document.querySelector(".sort-head__active") as HTMLElement | null;
    const sectionFilter = document.querySelector(".section-filter") as HTMLElement | null;
    const body = document.querySelector("body") as HTMLElement | null;
    
    if (!sortActive || !sortList || !sortInput || !sortHeadActive || !sectionFilter || !body || !bgModal) return;
    
    // Toggle dropdown visibility
    sortActive.addEventListener("click", () => {
        sortActive.classList.toggle("open");

        if (sortList.classList.contains("open")) {
            sortList.classList.remove("open");
            if (screenW >= 550) sortList.style.maxHeight = "0px";
        } else {
            sortList.classList.add("open");
            if (screenW >= 550) sortList.style.maxHeight = `${sortList.scrollHeight}px`;
        }

        if (screenW < 550) {
            if (sectionFilter.classList.contains("open")) {
                sectionFilter.classList.remove("open");
                bgModal.classList.add("show");
                body.classList.add("lock");
            } else {
                bgModal.classList.toggle("show");
                body.classList.toggle("lock");
            }
        } else {
            sectionFilter.classList.remove("open");
            bgModal.classList.remove("show");
            body.classList.remove("lock");
        }
    });

    if (screenW < 550 && sortCloseBtn) {
        sortCloseBtn.addEventListener("click", () => {
            sortList.classList.remove("open");
            sortActive.classList.remove("open");
            bgModal.classList.remove("show");
            body.classList.remove("lock");
        });
    }

    // Handle option selection
    sortButtons.forEach(button => {
        button.addEventListener("click", (e: Event) => {
            e.preventDefault();

            // Remove "aria-selected" from all buttons
            sortButtons.forEach(btn => btn.setAttribute("aria-selected", "false"));

            // Set the clicked button as selected
            button.setAttribute("aria-selected", "true");

            // Update the active selection text
            sortActive.textContent = button.textContent;
            sortInput.value = button.getAttribute("data-id") || "";
            if (screenW < 550) sortHeadActive.textContent = button.textContent || "";
            sortActive.classList.remove("open");

            // Close dropdown smoothly
            if (screenW >= 550) {
                sortList.classList.remove("open");
                sortList.style.maxHeight = "0px";
            }
        });
    });

    // Close dropdown when clicking outside
    document.addEventListener("click", (event: MouseEvent) => {
        if (!sortActive.contains(event.target as Node) && !sortList.contains(event.target as Node)) {
            sortList.classList.remove("open");
            sortActive.classList.remove("open");
            if (screenW >= 550) sortList.style.maxHeight = "0px";
        }
    });
};
document.addEventListener('DOMContentLoaded',  function(event) {
    sortDropdown();
});