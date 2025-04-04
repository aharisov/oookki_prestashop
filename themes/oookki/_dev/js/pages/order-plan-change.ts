const updateOrderPlan = () => {
    const changeButton = document.querySelector<HTMLButtonElement>(".js-change-plan");

    if (!changeButton) return;

    changeButton.addEventListener("click", () => {
        const modal = document.getElementById("change-plan-modal");
        const bgModal = document.querySelector(".bg-modal");
        if (!modal && !bgModal) return;
        const dataId = modal?.getAttribute("data-id");

        const activePack = modal?.querySelector(".pack-item.active");
        if (!activePack) return;

        // Extract data from the active pack
        const title = activePack.querySelector<HTMLHeadingElement>(".pack-item__title")?.textContent?.trim() || "N/A";
        const offer = activePack.querySelector<HTMLDivElement>(".pack-item__offer")?.textContent?.trim() || "";
        const priceNum = activePack.querySelector<HTMLDivElement>(".pack-item__price .num")?.textContent?.trim() || "0";
        const priceMore = activePack.querySelector<HTMLDivElement>(".pack-item__price .more span")?.textContent?.trim() || "€ 0";
        const priceNote = activePack.querySelector<HTMLDivElement>(".pack-item__price .note")?.textContent?.trim() || "";

        // Update the .summary-product block
        const summaryProduct = document.querySelector(`.summary-product[data-id="${dataId}"]`);
        if (!summaryProduct) return;

        summaryProduct.querySelector<HTMLAnchorElement>(".product-title a")!.textContent = title;
        summaryProduct.querySelector<HTMLDivElement>(".product-props")!.textContent = `${priceNote} - ${offer}`;
        summaryProduct.querySelector<HTMLDivElement>(".product-note")!.textContent = `${priceNum}${priceMore}/mois`;

        modal?.classList.remove("show");
        bgModal?.classList.remove("show");
    });
};

const choosePlan = () => {
    const planList = document.querySelectorAll<HTMLElement>(".packs-list-modal .pack-item");
    const changeBtn = document.querySelector<HTMLButtonElement>(".js-change-plan");

    if (!planList || !changeBtn) return;

    planList.forEach(plan => {
        plan.addEventListener("click", function () {
            // Remove "active" class from all plans
            planList.forEach(p => p.classList.remove("active"));

            // Add "active" to clicked plan
            this.classList.add("active");

            // Enable the change button
            changeBtn.disabled = false;
        });
    });
}

choosePlan();
updateOrderPlan();
