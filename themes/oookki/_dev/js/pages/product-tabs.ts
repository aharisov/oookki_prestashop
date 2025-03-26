function initTabs() {
    const tabButtons: NodeListOf<HTMLButtonElement> = document.querySelectorAll(".tab-button");
    const tabPanels: NodeListOf<HTMLDivElement> = document.querySelectorAll(".tab-panel");
    const tabSelect: HTMLElement | null = document.querySelector(".product-top__tabs-select");
    const tabSwitch: HTMLElement | null = document.querySelector(".product-top__tabs-switch");

    function activateTab(tabId: string): void {
        tabButtons.forEach(button => {
            button.classList.toggle("active", button.dataset.tab === tabId);
        });

        tabPanels.forEach(panel => {
            if (panel.id === tabId) {
                panel.setAttribute("aria-hidden", "false");

                // Get panel position and subtract offset (e.g., 20px for spacing)
                const offset = 100;
                const panelTop = panel.getBoundingClientRect().top + window.scrollY - offset;

                // Smooth scroll
                window.scrollTo({ top: panelTop, behavior: "smooth" });
            } else {
                panel.setAttribute("aria-hidden", "true");
            }
        });

        // Update the select text on mobile
        if (tabSelect) {
            const activeButton = document.querySelector(`[data-tab="${tabId}"]`) as HTMLButtonElement | null;
            if (activeButton) {
                tabSelect.textContent = activeButton.textContent;
                tabSelect.classList.remove("active");
            }
        }
    }

    // Handle tab button clicks
    tabButtons.forEach(button => {
        button.addEventListener("click", () => {
            if (button.dataset.tab) {
                activateTab(button.dataset.tab);
            }

            // Close mobile menu after selection
            if (tabSwitch) {
                tabSwitch.classList.remove("open");
                tabSelect!.classList.remove("active");
            }
        });
    });

    // Toggle tab menu on mobile
    tabSelect?.addEventListener("click", () => {
        tabSwitch?.classList.toggle("open");
        tabSelect!.classList.toggle("active");
    });

    // Ensure the first tab is active on load
    const firstTab = tabButtons[0]?.dataset.tab;
    if (firstTab) activateTab(firstTab);  
}

document.addEventListener("DOMContentLoaded", () => {
    initTabs();    
});
