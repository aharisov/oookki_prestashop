function stickyElement(element: HTMLElement, hideHeader: boolean) {
    if (!element) return;

    const elementRect = element.getBoundingClientRect();
    const header = document.querySelector("header") as HTMLElement | null;

    const originalTop = elementRect.top + window.scrollY - 70;
    const stickyClass = "sticky";

    function handleScroll() {
        if (window.scrollY >= originalTop) {
            if (!element.classList.contains(stickyClass)) {
                element.classList.add(stickyClass);

                if (hideHeader) header?.classList.add("header-hidden");
            }
        } else {
            if (element.classList.contains(stickyClass)) {
                element.classList.remove(stickyClass);
                element.style.transform = "";

                if (hideHeader) header?.classList.remove("header-hidden");
            }
        }
    }

    window.addEventListener("scroll", handleScroll);
}

document.addEventListener("DOMContentLoaded", () => {
    const stickyProductTop = document.querySelector(".product-top") as HTMLElement;
    const stickyMobileTabs = document.querySelector(".product-top__tabs") as HTMLElement;
    const stickyPlanTop = document.querySelector(".plan-details-top") as HTMLElement;
    const stickyCompareTop = document.querySelector(".compare-products") as HTMLElement;
    const stickySearchPageTop = document.querySelector(".search-page .filter-top") as HTMLElement;

    if (stickyProductTop && window.innerWidth >= 1024) {
        stickyElement(stickyProductTop, true);
    }

    if (stickyMobileTabs && window.innerWidth < 1024) {
        stickyElement(stickyMobileTabs, true);
    }

    if (stickyPlanTop && window.innerWidth >= 768) {
        stickyElement(stickyPlanTop, true);
    }

    if (stickyCompareTop) {
        stickyElement(stickyCompareTop, true);
    }

    if (stickySearchPageTop) {
        stickyElement(stickySearchPageTop, true);
    }
});
