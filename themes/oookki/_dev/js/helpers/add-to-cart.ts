function addToCart(): void {
    const modal = document.getElementById("in-cart-modal") as HTMLDivElement;
    const modalBg = document.querySelector(".bg-modal") as HTMLDivElement;
    const modalTitle = document.querySelector(".modal-product .name") as HTMLHeadingElement;
    const modalImage = document.querySelector(".modal-picture img") as HTMLImageElement;
    const continueShopping = document.querySelector(".continue") as HTMLButtonElement;
    const cartCounter = document.querySelector(".btn-cart .cnt") as HTMLElement;
    const addToCartButtons = document.querySelectorAll(".add-to-cart");
    const body = document.querySelector("body") as HTMLElement;

    if (!modalTitle || !modalImage || !continueShopping || !cartCounter || !addToCartButtons) {
        return;
    }
    
    let cartCount = 0;

    function updateModal(title: string, imageUrl: string) {
        modalTitle.textContent = `${title}`;
        modalImage.src = imageUrl;

        // Increment cart count
        cartCount++;
        cartCounter.textContent = cartCount.toString();
    }

    // Close modal function
    function closeModalHandler() {
        modal.classList.remove("show");
        modalBg.classList.remove("show");
        body.classList.remove("lock");
    }

    // Event listeners for add to cart buttons
    addToCartButtons.forEach(button => {
        button.addEventListener("click", function (this: HTMLButtonElement) {
            const productTitle = this.getAttribute("data-title")!;
            const productImage = this.getAttribute("data-image")!;
            updateModal(productTitle, productImage);

            body.classList.add("lock");
        });
    });

    continueShopping.addEventListener("click", closeModalHandler);
}

document.addEventListener("DOMContentLoaded", () => {
    addToCart();
});