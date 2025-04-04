function moveElementOnResize(
    elementSelector: string,
    fromSelector: string,
    toSelector: string,
    beforeFromSelector: string,
    beforeToSelector: string,
    breakpoint: number
): void {
    const element = document.querySelector(elementSelector) as HTMLElement | null;
    const fromContainer = document.querySelector(fromSelector) as HTMLElement | null;
    const toContainer = document.querySelector(toSelector) as HTMLElement | null;
    const beforeFromElement = document.querySelector(beforeFromSelector) as HTMLElement | null;
    const beforeToElement = document.querySelector(beforeToSelector) as HTMLElement | null;

    if (!element || !fromContainer || !toContainer || !beforeFromElement || !beforeToElement) {
        console.error("One or more elements not found");
        return;
    }

    function moveElement(): void {
        if (window.innerWidth <= breakpoint) {
            if (element!.parentElement !== toContainer) {
                fromContainer!.contains(element) && fromContainer!.removeChild(element!);
                toContainer!.insertBefore(element!, beforeFromElement);
            }
        } else {
            if (element!.parentElement !== fromContainer) {
                toContainer!.contains(element) && toContainer!.removeChild(element!);
                fromContainer!.insertBefore(element!, beforeToElement);
            }
        }
    }

    window.addEventListener("resize", moveElement);
    window.addEventListener("DOMContentLoaded", moveElement);
    moveElement(); // Initial check
}

moveElementOnResize(".product-title", ".product-info__inner", ".product-info", ".product-page__slider", ".return-calculate", 768);