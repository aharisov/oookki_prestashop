function stickySidebar(leftElement: HTMLElement, rightElement: HTMLElement, offset: number = 20): void {
    function onScroll() {
        const leftRect = leftElement.getBoundingClientRect();
        const rightRect = rightElement.getBoundingClientRect();
        const rightBottom = rightElement.offsetTop + rightElement.offsetHeight;
        const scrollY = window.scrollY || window.pageYOffset;
        const leftHeight = leftElement.offsetHeight;
        
        if (scrollY + offset > rightElement.offsetTop && scrollY + leftHeight + offset < rightBottom) {
            leftElement.style.position = "fixed";
            leftElement.style.top = `${offset}px`;
            leftElement.classList.add("sticky");
        } else if (scrollY + leftHeight + offset >= rightBottom) {
            leftElement.style.position = "absolute";
            leftElement.style.top = `${rightElement.offsetHeight - leftHeight}px`;
        } else {
            leftElement.style.position = "static";
            leftElement.classList.remove("sticky");
        }
    }

    window.addEventListener("scroll", onScroll);
    window.addEventListener("resize", onScroll); // Handle screen resizing
    onScroll(); // Call once to set the initial position
}

// Example usage:
const left = document.querySelector(".product-page__slider .inner") as HTMLElement;
const right = document.querySelector(".product-info .product-info__inner") as HTMLElement;
if (left && right && window.innerWidth >= 768) {
    stickySidebar(left, right, 100);
}