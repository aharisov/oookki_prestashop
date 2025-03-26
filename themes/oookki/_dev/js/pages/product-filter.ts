const showCloseFilter = (): void => {
    const filter = document.querySelector(".section-filter") as HTMLElement | null;
    const openFilterBtn = document.querySelector(".js-open-filter") as HTMLElement | null;
    const screenW = window.innerWidth;
    const closeFilterBtn = document.querySelector(".js-close-filter") as HTMLElement | null;
    const sortList = document.querySelector(".sort-list") as HTMLElement | null;
    const bgModal = document.querySelector(".bg-modal") as HTMLElement | null;
    
    if (filter && openFilterBtn && closeFilterBtn && bgModal && screenW < 768) {
        openFilterBtn.addEventListener("click", () => {
            filter.classList.toggle("open");
            
            if (screenW < 550) {
                if (sortList?.classList.contains("open")) {
                    sortList.classList.remove("open");
                    bgModal.classList.add("show");
                } else {
                    bgModal.classList.toggle("show");
                }
            } 
            if (screenW >= 550 && screenW < 768) {
                bgModal.classList.toggle("show");
            }
        });

        closeFilterBtn.addEventListener("click", () => {
            filter.classList.remove("open");
            openFilterBtn.classList.remove("active");
            bgModal.classList.remove("show");
        });
    }
}

const openFilterBlock = (): void => {
    const filterBlocks = document.querySelectorAll(".filter-block");
    
    filterBlocks.forEach(block => {
        const header = block.querySelector("h4[role='btn']") as HTMLElement | null;
        const content = block.querySelector(".filter-block__inner") as HTMLElement | null;
        
        if (header && content) {
            header.addEventListener("click", () => {
                const isActive = header.getAttribute("aria-active") === "true";
                header.setAttribute("aria-active", isActive ? "false" : "true");
                content.setAttribute("aria-hidden", isActive ? "true" : "false");
            });
        }
    });
}

const showMoreFilterValues = (): void => {
    const showMoreBtn = document.querySelector(".js-show-more") as HTMLElement | null;
    if (!showMoreBtn) return;
    const container = showMoreBtn.parentElement;

    showMoreBtn.addEventListener("click", function () {
        if (container) {
            container.classList.toggle("expanded");
            this.textContent = container.classList.contains("expanded") ? "- moins de marques" : "+ de marques";
        }
    });
}

const stickyFilter = (): void => {
    const filterTop = document.getElementById("filter-top") as HTMLElement | null;
    const sidebar = document.querySelector(".section-filter") as HTMLElement | null;
    const sidebarInner = document.querySelector(".section-filter__inner") as HTMLElement | null;
    const container = document.querySelector(".section-products") as HTMLElement | null;
    const header = document.querySelector("header") as HTMLElement | null;
    
    if (filterTop && sidebar && sidebarInner && container && header) {
        const filterTopOffset = filterTop.offsetTop;
        const sidebarInitialOffset = sidebar.offsetTop - 180;

        window.addEventListener("scroll", () => {
            const scrollY = window.pageYOffset || document.documentElement.scrollTop;
            
            if (scrollY >= filterTopOffset - 150) {
                filterTop.classList.add("fixed");
                header.classList.add("header-hidden");
            } else {
                filterTop.classList.remove("fixed");
                header.classList.remove("header-hidden");
            }

            if (window.innerWidth >= 768) {
                const containerRect = container.getBoundingClientRect();
                const containerBottom = containerRect.bottom;
                const sidebarHeight = sidebarInner.offsetHeight;
                
                if (scrollY >= sidebarInitialOffset) {
                    if (containerBottom < sidebarHeight) {
                        sidebarInner.classList.add("absolute");
                        sidebarInner.classList.remove("fixed");
                        sidebarInner.style.top = `${container.offsetHeight - sidebarHeight}px`;
                    } else {
                        sidebarInner.classList.add("fixed");
                        sidebarInner.classList.remove("absolute");
                        sidebarInner.style.top = "80px";
                    }
                } else {
                    sidebarInner.classList.remove("absolute", "fixed");
                    sidebarInner.style.top = "";
                }
            }
        });
    }
}
document.addEventListener('DOMContentLoaded',  function(event) {
    showCloseFilter();
    openFilterBlock();
    showMoreFilterValues();
    stickyFilter();
});