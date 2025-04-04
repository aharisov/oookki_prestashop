const togglePlanAbon = (): void => {
    const switchBtns = document.querySelectorAll(".js-toggle-switch") as NodeListOf<HTMLElement> | null;
    if (!switchBtns) return;

    switchBtns.forEach(btn => {
        btn.addEventListener("click", function (this: HTMLElement) {
            switchBtns.forEach(b => b.classList.toggle("active"));
        })
    })
}

togglePlanAbon();