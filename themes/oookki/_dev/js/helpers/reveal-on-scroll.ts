const revealOnScroll = () => {
    const container = document.querySelector<HTMLElement>(".order-content .more-products .section-inner"); 
    if (!container) return;

    const divs = Array.from(container.children).slice(2) as HTMLElement[]; // Selects divs starting from the third one

    const observer = new IntersectionObserver(
        (entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.remove("hidden");
                    observer.unobserve(entry.target); // Stop observing once visible
                }
            });
        },
        { root: null, threshold: 0.2 } // 20% visibility triggers animation
    );

    divs.forEach(div => observer.observe(div));
};

// Run when DOM is loaded
// document.addEventListener("DOMContentLoaded", revealOnScroll);
