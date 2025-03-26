// TODO: add items to the page from CMS API after choosing them in modal

const removeFromComparePage = (): void => {
    const pageButtons = document.querySelectorAll(".remove-from-compare");
    const modalButtons = document.querySelectorAll(".compare-search-modal .js-compare-remove");

    if (pageButtons) {
        pageButtons.forEach(btn => {
            btn.addEventListener("click", function(this: HTMLElement) {
                removeCompareItem(this.getAttribute("data-id"));
                toggleSelectButtonsState();
            })
        })
    }

    if (modalButtons) {
        modalButtons.forEach(btn => {
            btn.addEventListener("click", function(this: HTMLElement) {
                const compareItem = this.closest(".compare-item") as HTMLElement;
                if (!compareItem) return;
                
                const colIndex = compareItem.getAttribute("aria-colindex") || "";
                const compareItemId = this.getAttribute("data-id");
                const deselectedItem = document.querySelector(`.compare-search-modal .model-item[data-id="${compareItemId}"]`)
    
                compareItem.innerHTML = "";
                compareItem.classList.add("empty");
                compareItem.removeAttribute("data-id");
                removeCompareItem(compareItemId);

                changeCompareButtonState();
                toggleSelectButtonsState();
                deselectedItem?.classList.remove("active");
                localStorage.setItem("colIndex", colIndex);
            })
        })
    }
}

/**
 * Removes product from compare page
 * @param id - product id
 */
const removeCompareItem = (id: string | null): void => {
    const items = document.querySelectorAll(`.compare-item[data-id="${id}"]`);
    if (!items) return;

    items.forEach((item) => {
        let itemDataId = item.getAttribute("data-id");
        
        if (itemDataId == id) {
            item.innerHTML = ""; 
            item.classList.add("empty"); 
        }
    });

    addSelectButton(".compare-top .compare-item.empty");
    removeEmptyLines();
}

/**
 * Adds button for adding new product to compare page
 * @param element - parent element with compare items
 */
const addSelectButton = (element: string): void => {
    const items = document.querySelectorAll(element);
    if (!items) return;

    items.forEach(item => {
        const newButton = document.createElement("button");
        newButton.classList.add("open-modal");
        newButton.setAttribute("data-modal", "compare-modal");
        newButton.innerHTML = `<span class="icon">
            <svg class="svg-inline--fa fa-plus" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="plus" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M256 80c0-17.7-14.3-32-32-32s-32 14.3-32 32l0 144L48 224c-17.7 0-32 14.3-32 32s14.3 32 32 32l144 0 0 144c0 17.7 14.3 32 32 32s32-14.3 32-32l0-144 144 0c17.7 0 32-14.3 32-32s-14.3-32-32-32l-144 0 0-144z"></path></svg><!-- <i class="fa-solid fa-plus"></i> Font Awesome fontawesome.com -->
            </span>
            <span>Ajouter</span>`;

        item.innerHTML = "";
        item.append(newButton);

        if (!item.classList.contains("empty")) {
            item.classList.add("empty");
        }
    })

    openModal();
    getColumnNumber();
}

const countEmptyCells = (): number => {
    const topEmptyItems = document.querySelectorAll(".compare-top .compare-item.empty");
    
    return topEmptyItems.length;
}

const countModalEmptyCells = (): number => {
    const emptyCells = document.querySelectorAll(".compare-search-modal .compare-item.empty");
    
    return emptyCells.length;
}

const initEmptyCells = (): void => {
    const emptyCells = document.querySelectorAll(".compare-search-modal .compare-item.empty");
    if (emptyCells.length == 0) return;

    if (window.innerWidth < 768) {
        emptyCells[emptyCells.length - 1].remove();
    }
}

const toggleSelectButtonsState = (): void => {
    const compareItems = document.querySelectorAll(".compare-search-modal .model-item") as NodeListOf<HTMLButtonElement>;

    if (countModalEmptyCells() == 0) {
        compareItems.forEach(item => {
            if (!item.classList.contains("active")) {
                item.disabled = true;
            }
        })
    } else {
        compareItems.forEach(item => {
            item.disabled = false;
        })
    }
}

const removeEmptyLines = (): void => {
    const lines = document.querySelectorAll(".compare-line");
    if (!lines) return;

    lines.forEach((line) => {
        if (countEmptyCells() == 3) {
            if (!line.classList.contains("compare-top")) {
                line.remove();
            }
        }     
    });

    addSelectButton(".compare-top .compare-item.empty");
}

const getColumnNumber = (): void => {
    const buttons = document.querySelectorAll(".compare-wrap .compare-top .open-modal");
    if (!buttons) return;

    buttons.forEach((btn) => {
        const colIndex = btn.closest(".compare-item")?.getAttribute("aria-colindex");

        btn.addEventListener("click", () => {
            localStorage.setItem("colIndex", colIndex!);
        })
    });
}

const changeCompareButtonState = (): void => {
    const button = document.querySelector(".compare-search-modal .js-open-compare") as HTMLButtonElement;
    const compareItems = document.querySelectorAll(".compare-search-modal .compare-item.empty");
    if (!button) return;

    if (compareItems.length <= 1) {
        button.disabled = false;
    } else {
        button.disabled = true;
    }
}

const closeCompareSearchModal = (): void => {
    const button = document.querySelector(".compare-search-modal .js-open-compare") as HTMLButtonElement;
    const modal = document.querySelector(".compare-search-modal") as HTMLElement;
    const modalBg = document.querySelector(".bg-modal") as HTMLElement;

    if (!button) return;

    button.addEventListener("click", () => {
        modal.classList.remove("show");
        modalBg.classList.remove("show");
    })
}

const setColIndex = (): void => {
    const emptyItems = document.querySelectorAll(".compare-search-modal .compare-item.empty");

    if (emptyItems.length > 0) {
        localStorage.setItem("colIndex", emptyItems[0].getAttribute("aria-colindex") || "");
    }
}

const onChangeButtonClick = () => {
    const buttons = document.querySelectorAll(".compare-products button.open-modal");
    if (!buttons) return;

    buttons.forEach(btn => {
        btn.addEventListener("click", function(this: HTMLButtonElement) {
            const parent = this.closest(".compare-item") as HTMLDivElement;
            const colIndex = parent.getAttribute("aria-colindex");
            const itemId = parent.getAttribute("data-id");
            const modalItem = document.querySelector(`.compare-search-modal .compare-item[data-id='${itemId}']`) as HTMLElement;
            const removeButton = document.querySelector(`.compare-top .remove-from-compare[data-id='${itemId}']`) as HTMLButtonElement;

            localStorage.setItem("colIndex", colIndex || "");
            modalItem.innerHTML = "";
            modalItem.classList.add("empty");
            removeButton!.click();
        })
    })
}

const compareSearch = () => {
    const brands: Record<string, CompareItem[]> = {
        Apple: [
            { id: "13", name: "iPhone 13", image: "images/brands-logo/iphone13.png", brand: "Apple" },
            { id: "14", name: "iPhone 14", image: "images/brands-logo/iphone14.png", brand: "Apple" },
            { id: "15", name: "iPhone 15", image: "images/brands-logo/iphone15.png", brand: "Apple" },
            { id: "1", name: "iPhone 16 Plus", image: "images/brands-logo/iphone16plus.png", brand: "Apple" },
            { id: "16", name: "iPhone 16 Pro", image: "images/brands-logo/iphone16pro.png", brand: "Apple" }
        ],
        Samsung: [
            { id: "23", name: "Galaxy S23", image: "images/brands-logo/s23.png", brand: "Samsung" },
            { id: "2", name: "Galaxy S25 Ultra", image: "images/brands-logo/s24.png", brand: "Samsung" },
            { id: "55", name: "Galaxy A55", image: "images/brands-logo/a55.png", brand: "Samsung" }
        ],
        Xiaomi: [
            { id: "33", name: "Redmi Note 13", image: "images/brands-logo/note13.png", brand: "Xiaomi" },
            { id: "34", name: "Redmi 12", image: "images/brands-logo/redmi12.png", brand: "Xiaomi" },
            { id: "35", name: "14", image: "images/brands-logo/x14.png", brand: "Xiaomi" }
        ]
    };

    const brandLogos = [
        "images/brands-logo/apple.png", 
        "images/brands-logo/samsung.png",
        "images/brands-logo/xiaomi.png"
    ];

    const searchInput = document.querySelector(".compare-search-modal input") as HTMLInputElement;
    const brandList = document.querySelector(".compare-search-modal .brand-list") as HTMLDivElement;
    const modelList = document.querySelector(".compare-search-modal .model-list") as HTMLDivElement;
    const returnBtn = document.querySelector(".compare-search-modal .return") as HTMLInputElement;
    const compareNote = document.querySelector(".compare-search-modal .note span") as HTMLElement;
    if (!searchInput || !brandList || !modelList || !returnBtn) return;

    if (window.innerWidth < 768) {
        compareNote.innerHTML = "2";
    } else {
        compareNote.innerHTML = "3";
    }

    function displayBrands(): void {
        brandList.innerHTML = "";
        Object.keys(brands).forEach((brand, index) => {
            const icon = document.createElement("img");
            icon.setAttribute("src", brandLogos[index]);

            const button = document.createElement("button");
            button.textContent = brand;
            button.className = "brand";
            button.onclick = () => {
                brandList.classList.add("hidden");
                returnBtn.classList.add("active");

                getSelectedItems();
                displayModels(brand as keyof typeof brands);
                toggleSelectButtonsState();
            }
            button.appendChild(icon);
            brandList.appendChild(button);
        });
    }

    function displayModels(brand: keyof typeof brands): void {
        modelList.innerHTML = "";
        modelList.classList.remove("hidden");
        brands[brand].forEach((product: CompareItem) => {
            const item = document.createElement("button");
            item.innerHTML = `<img src="${product.image}" alt="${product.name}"> ${product.name}`;
            item.className = "model-item";
            item.setAttribute("data-id", product.id);
            
            let comparedProducts = JSON.parse(localStorage.getItem("comparedProducts") || "");
            if (comparedProducts.includes(product.id)) {
                item.classList.add("active");
            } else {
                item.classList.remove("active");
            }

            item.onclick = () => {
                if (item.classList.contains("active")) {
                    item.classList.remove("active");
                    selectItem(product, false);
                } else {
                    item.classList.add("active");
                    selectItem(product, true);
                }

                changeCompareButtonState();
            }
            modelList.appendChild(item);
        });
    }

    function getSelectedItems(): void {
        const selectedItems = document.querySelectorAll(".compare-search-modal .compare-item:not(.empty)");
        const idList: string[] = [];

        localStorage.setItem("comparedProducts", "");
        selectedItems.forEach(item => {
            idList.push(item.getAttribute("data-id") || "");
        })

        localStorage.setItem("comparedProducts", JSON.stringify(idList));
    }

    function selectItem(product: CompareItem, select: boolean): void {
        if (select) {
            const colIndex = localStorage.getItem("colIndex");
            const compareBox = document.querySelector(`.compare-search-modal .compare-item[aria-colindex='${colIndex}']`);
            if (!compareBox) return;

            compareBox.classList.remove("empty");
            compareBox.setAttribute("data-id", product.id);

            compareBox.innerHTML = `
                <div class='compare-remove js-compare-remove' data-id='${product.id}'></div>
                <div class='inner flex'>
                    <div class='pic'>
                        <img src='${product.image}' alt=''>
                    </div>
                    <div class='right'>
                        <div class='brand'>${product.brand}</div>
                        <div class='name'>${product.name}</div>
                    </div>
                </div>
            `;

            setColIndex();
        } else {
            const compareBox = document.querySelector(`.compare-search-modal .compare-item[data-id='${product.id}']`);
            if (!compareBox) return;

            compareBox.innerHTML = "";
            compareBox.classList.add("empty");
            compareBox.removeAttribute("data-id");
            localStorage.setItem("colIndex", compareBox.getAttribute("aria-colindex") || "");
        }

        removeFromComparePage();
        toggleSelectButtonsState();
    }

    function searchModels(): void {
        const query = searchInput.value.toLowerCase();
        modelList.innerHTML = "";
        modelList.classList.remove("hidden");
        let results: { id: string, name: string; image: string; }[] = [];

        if (query) {
            Object.entries(brands).forEach(([_, models]) => {
                results = results.concat(models.filter((model) => model.name.toLowerCase().includes(query)));
            });

            if (results.length === 0) {
                modelList.innerHTML = "<p>Aucun résultat trouvé</p>";
            } else {
                results.forEach(({ id, name, image }) => {
                    const item = document.createElement("button");
                    item.innerHTML = `<img src="${image}" alt="${name}"> ${name}`;
                    item.className = "model-item";
                    item.setAttribute("data-id", id);
                    // item.onclick = () => selectItem(item);
                    modelList.appendChild(item);
                });
            }
        } else {
            displayBrands();
            modelList.classList.add("hidden");
        }
    }

    searchInput.addEventListener("input", searchModels);
    returnBtn.addEventListener("click", () => {
        brandList.classList.remove("hidden");
        modelList.classList.add("hidden");
        returnBtn.classList.remove("active");
    })
    displayBrands();
}

const clearComparePage = (): void => {
    const clearBtn = document.querySelector(".compare-search-modal .js-clear-compare");
    const modalItems = document.querySelectorAll(".compare-search-modal .compare-item");
    const pageItems = document.querySelectorAll(".compare-wrap .compare-line:not(.compare-top)");
    if (!clearBtn || !modalItems || !pageItems) return;

    clearBtn?.addEventListener('click', () => {
        modalItems.forEach((item) => {
            item.innerHTML = ""; 
            item.classList.add("empty"); 
            item.removeAttribute("data-id");
        });

        pageItems.forEach(item => {
            item.remove();
        })

        addSelectButton(".compare-top .compare-item");
        changeCompareButtonState();
    });
}

initEmptyCells();
compareSearch();
removeFromComparePage();
getColumnNumber();
changeCompareButtonState();
closeCompareSearchModal();
clearComparePage();
onChangeButtonClick();