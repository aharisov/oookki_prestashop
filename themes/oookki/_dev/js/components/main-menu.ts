const openCloseMenu = (): void => {
    const menuBtn = document.querySelector('.js-open-menu') as HTMLElement | null;
    const menu = document.querySelector('.main-menu') as HTMLElement | null;
    const body = document.querySelector('body') as HTMLElement | null;

    if (!menuBtn || !menu || !body) return;

    menuBtn.addEventListener('click', function () {
        this.classList.toggle('opened');
        menu.classList.toggle('active');
        body.classList.toggle('lock');
    });
};

const openDropdown = (): void => {
    const parentItems = document.querySelectorAll('.main-menu__parent');

    parentItems.forEach(item => {
        item.addEventListener('click', function (this: HTMLElement, event: Event) {
            event.stopPropagation();

            // Close all other dropdowns
            parentItems.forEach(otherItem => {
                if (otherItem !== item) {
                    otherItem.classList.remove('opened');
                }
            });

            // Toggle the clicked one
            this.classList.toggle('opened');
        });
    });

    document.addEventListener('click', () => {
        parentItems.forEach(item => item.classList.remove('opened'));
    });
};

const scrollMenu = (): void => {
    let lastScrollTop = 0;
    const header = document.querySelector("header") as HTMLElement | null;
    const searchForm = document.querySelector('.header__search') as HTMLElement | null;
    const filterTop = document.getElementById('filter-top') as HTMLElement | null;

    if (!header || !searchForm || !filterTop) return;

    window.addEventListener("scroll", function () {
        let currentScroll = window.scrollY;

        if (window.scrollY > 200 && !filterTop.classList.contains("fixed")) {
            if (currentScroll > lastScrollTop) {
                // Scrolling Down → Hide header
                header.classList.add("header-hidden");
                searchForm.classList.remove("active");
            } else {
                // Scrolling Up → Show header
                header.classList.remove("header-hidden");
            }
        }

        lastScrollTop = currentScroll;
    });
};

document.addEventListener('DOMContentLoaded',  function(event) {
    openCloseMenu();   
    openDropdown(); 
    scrollMenu();
});