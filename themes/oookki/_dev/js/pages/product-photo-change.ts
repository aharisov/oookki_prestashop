function productPhotoChange() {
    const colorButtons: NodeListOf<HTMLButtonElement> = document.querySelectorAll("input[name='color']");
    const swiperContainer: HTMLElement | null = document.querySelector(".product-page__slider .swiper-wrapper");

    if (!swiperContainer || !colorButtons) return;

    function updateGallery(color: string) {
        if (!swiperContainer) return;

        // Convert colors with 2 words, ex. "Bleu nuit" to "bleu-nuit"
        const formattedColor = color.toLowerCase().replace(/\s+/g, "-"); 
        const images = swiperContainer.querySelectorAll("img");
        const toCartBtn = document.querySelector(".add-to-cart");

        images.forEach((img) => {
            const link = img.closest("a");
            const newImage = img.getAttribute(`data-${formattedColor}`);

            if (newImage && img.src !== newImage) {
                img.style.opacity = "0"; // Start fade out

                setTimeout(() => {
                    img.src = newImage;
                    link?.setAttribute("href", newImage);
                    img.setAttribute("alt", `Smartphone color: ${color}`);
                    img.style.opacity = "1"; // Fade in after src change
                }, 300); // Wait for fade out duration
            }
        });

        // update image on btn
        toCartBtn?.setAttribute("data-image", images[0]?.getAttribute(`data-${formattedColor}`)!);

        // Refresh Swiper to update images
        const swiperInstance = (window as any).swiper;
        if (swiperInstance) {
            swiperInstance.update();
        }
    }

    colorButtons.forEach((button) => {
        button.addEventListener("click", () => {
            const selectedColor = button.value;
            if (selectedColor) {
                updateGallery(selectedColor);
            }
        });
    });
}

document.addEventListener("DOMContentLoaded", () => {
    productPhotoChange();
})