const removeFromCart = (): void => {
    const removeButtons = document.querySelectorAll(".product-buttons .delete") as NodeListOf<Element>;
    if (!removeButtons) return;

    removeButtons.forEach(btn => {
        btn.addEventListener("click", function(this: HTMLElement) {
            const product = this.closest(".summary-product");

            if (product) {
                product.remove();

                if (product.getAttribute("aria-label") == "plan") {
                    onPlanRemove();
                }

                // Check if there are remaining products
                setTimeout(() => {
                    const remainingProducts = document.querySelectorAll(".summary-product");
                    if (remainingProducts.length === 0) {
                        window.location.href = "basket-empty.php";
                    }
                }, 200);
            }
        })
    })
}

const onPlanRemove = () => {
    const configBlocks = document.querySelectorAll(".line-config-block") as NodeListOf<Element>;
    const payBlockElements = document.querySelectorAll(".pay-block li[aria-label='plan']") as NodeListOf<Element>;
    if (!configBlocks || !payBlockElements) return;

    configBlocks.forEach(block => {
        block.classList.add("hidden");
    })

    payBlockElements.forEach(block => {
        block.classList.add("hidden");
    })
}
removeFromCart();