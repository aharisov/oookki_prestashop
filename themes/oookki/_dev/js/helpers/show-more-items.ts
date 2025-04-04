const showMoreItems = () => {
    const container = document.querySelector<HTMLElement>(".more-products .section-inner");
    const showMoreBtn = document.querySelector<HTMLButtonElement>(".more-products .show-more");

    if (!container || !showMoreBtn) return;

    const childDivs = Array.from(container.children) as HTMLElement[];
    let visibleCount = 2; // Initially show 2 divs

    // Function to determine how many divs to show based on screen size
    const getIncrement = () => (window.innerWidth < 640 || (window.innerWidth >= 768 && window.innerWidth < 1024)) ? 1 : 2;

    // Hide all divs except the initially visible ones
    childDivs.forEach((div, index) => {
        if (index >= visibleCount) {
            div.style.opacity = "0";
            div.style.height = "0px";
            div.style.marginBottom = "0";
            div.style.overflow = "hidden";
            div.style.transition = "opacity 0.3s ease, height 0.3s ease";
        }
    });

    showMoreBtn.addEventListener("click", () => {
        let increment = getIncrement();
        let shown = 0;

        for (let i = visibleCount; i < childDivs.length && shown < increment; i++, shown++) {
            const div = childDivs[i];
            div.style.height = "calc(100% - 1rem)";
            div.style.marginBottom = "1rem";
            div.style.opacity = "1";
        }

        visibleCount += increment;

        // Hide button if all divs are visible
        if (visibleCount >= childDivs.length) {
            showMoreBtn.style.display = "none";
        }
    });

    // Update visibleCount on resize
    window.addEventListener("resize", () => {
        visibleCount = Math.min(visibleCount, childDivs.length);
    });
};

document.addEventListener("DOMContentLoaded", showMoreItems);