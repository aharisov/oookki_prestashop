// radio buttons select on order step 1
const handleRadioSelection = () => {
    const cardRadios = document.querySelectorAll<HTMLInputElement>("input[name='card']");
    const phoneSaveRadios = document.querySelectorAll<HTMLInputElement>("input[name='phone_save']");
    const abonRadios = document.querySelectorAll<HTMLInputElement>("input[name='abon']");
    const phoneNumber = document.querySelector<HTMLInputElement>("#phone-number");
    const phoneRio = document.querySelector<HTMLInputElement>("#phone-rio");

    cardRadios.forEach(radio => radio.addEventListener("change", updatePayBlock));
    [...cardRadios, ...phoneSaveRadios, ...abonRadios].forEach(radio => radio.addEventListener("change", updateButtonState));

    if (phoneNumber) phoneNumber.addEventListener("keyup", updateButtonState);
    if (phoneRio) phoneRio.addEventListener("keyup", updateButtonState);
};

// update pay block with the value of chosen sim card
const updatePayBlock = () => {
    const payBlockList = document.querySelectorAll<HTMLElement>(".pay-summary .pay-block.all-info ul");
    const selectedCard = document.querySelector<HTMLInputElement>("input[name='card']:checked");

    if (!payBlockList || !selectedCard) return;

    // Remove existing "offer" entry if any
    payBlockList.forEach(el => {
        const existingOffer = el.querySelector(".card-offer");

        if (existingOffer) {
            existingOffer.remove();
        }
    })

    payBlockList.forEach(el => {
        // Create new list item for selected card
        const newListItem = document.createElement("li");
        newListItem.classList.add("card-offer");
        newListItem.innerHTML = `<span>${selectedCard.value}</span><span>offerte</span>`;

        // Append new list item to the list
            el.appendChild(newListItem);
    });
};

// verify if all radios are checked in order step 1
const updateButtonState = () => {
    const phoneSaveChecked = document.querySelector<HTMLInputElement>("input[name='phone_save']:checked")?.value === "yes";
    const abonChecked = document.querySelector<HTMLInputElement>("input[name='abon']:checked")?.value === "yes";
    const phoneNumber = document.querySelector<HTMLInputElement>("#phone-number");
    const phoneRio = document.querySelector<HTMLInputElement>("#phone-rio");
    const nextStepButton = document.querySelector<HTMLButtonElement>(".next-step");

    if (!nextStepButton || !phoneNumber || !phoneRio) return;

    // Check if all radio groups have a selection
    const allGroupsChecked = ["card", "phone_save", "abon"].every(group =>
        document.querySelector(`input[name='${group}']:checked`)
    );

    if (!allGroupsChecked) {
        nextStepButton.disabled = true;
        // console.info('not all checked');
        return;
    } else {
        nextStepButton.disabled = false;
        nextStepButton.addEventListener("click", showNextStep);
    }

    if (phoneSaveChecked) {
        phoneNumber.required = true;
        phoneRio.required = true;
        
        const isPhoneNumberFilled = phoneNumber.value.length === phoneNumber.maxLength;
        const isPhoneRioFilled = phoneRio.value.length === phoneRio.maxLength;

        nextStepButton.disabled = !(isPhoneNumberFilled && isPhoneRioFilled);
    } else {
        phoneNumber.required = false;
        phoneRio.required = false;
    }

    if (abonChecked) {
        nextStepButton.disabled = true;
    }
};

// go to next step
const showNextStep = (e: Event) => {
    e.preventDefault();

    const nextStepButton = document.querySelector<HTMLButtonElement>(".order-buttons .next-step");
    if (!nextStepButton) return;

    const url = nextStepButton.getAttribute("data-next");
    if (url) {
        window.location.href = url;
    }
}

// show second part of order step 1
const showNextSection = (e: Event) => {
    e.preventDefault();

    const nextStepButton = document.querySelector<HTMLButtonElement>(".order-buttons .next");
    const currentSection = document.querySelector<HTMLButtonElement>(".order-content.recommend-list");
    const nextSection = document.querySelector<HTMLButtonElement>(".order-content.config-content");
    if (!nextStepButton || !currentSection || !nextSection) return;

    const url = nextStepButton.getAttribute("data-next");

    if (url) {
        window.location.href = url;
    } else {
        currentSection.setAttribute("aria-hidden", "true");
        nextSection.setAttribute("aria-hidden", "false");

        const offset = 100;
        const sectionTop = nextSection.getBoundingClientRect().top + window.scrollY - offset;

        // Smooth scroll
        window.scrollTo({ top: sectionTop, behavior: "smooth" });
    }
}

function isRadioGroupSelected(groupName: string): boolean {
    const selectedOption = document.querySelector<HTMLInputElement>(`input[name="${groupName}"]:checked`);
    return selectedOption !== null;
}

function handleRadioGroup(groupName: string): void {
    const radioButtons = document.querySelectorAll<HTMLInputElement>(`input[name="${groupName}"]`);
  
    radioButtons.forEach((radio) => {
        radio.addEventListener("change", (event) => {
            const selectedRadio = event.target as HTMLInputElement;
            const parent = selectedRadio.closest(".form-line");
            parent?.classList.remove("error");
            parent?.querySelector(".error-message")?.remove();
        });
    });
}
  
// open/close cart on mobile device in order after step 1
const showMobileCart = () => {
    const showBtn = document.querySelector<HTMLButtonElement>(".show-mobile-cart");
    const cartSummary = document.querySelector<HTMLButtonElement>(".cart-summary");
    if (!showBtn || !cartSummary) return;

    showBtn?.addEventListener("click", () => {
        if (cartSummary.classList.contains("show")) {
            showBtn.innerHTML = 'Détail du panier <i class="fa-solid fa-angles-down"></i>';
        } else {
            showBtn.innerHTML = 'Cacher le panier <i class="fa-solid fa-angles-up"></i>';
        }

        cartSummary?.classList.toggle("show");
    })
}

const addDeliveryToSummary = () => {
    const payBlockList = document.querySelectorAll<HTMLElement>(".pay-summary .pay-block.all-info ul");
    const selectedDeliveryItem = document.querySelector<HTMLInputElement>("input[name='delivery']:checked");

    if (!payBlockList || !selectedDeliveryItem) return;

    // Remove existing entry if any
    payBlockList.forEach(el => {
        const existingElement = el.querySelector(".delivery-info");

        if (existingElement) {
            existingElement.remove();
        }
    })

    payBlockList.forEach(el => {
        // Create new list item for selected entry
        const newListItem = document.createElement("li");
        let price = selectedDeliveryItem.getAttribute("data-price") + "€";
        if (selectedDeliveryItem.getAttribute("data-price") == "gratuit") price = "gratuit";

        newListItem.classList.add("delivery-info");
        newListItem.innerHTML = `<span>Delivery ${selectedDeliveryItem.value}</span><span>${price}</span>`;

        // Append new list item to the list
            el.appendChild(newListItem);
    });
}

const validateDeliveryStep = () => {
    const nextStepButton = document.querySelector<HTMLButtonElement>(".order-buttons .next-step");
    const radioButtons = document.querySelectorAll<HTMLInputElement>(`input[name="delivery"]`);

    if (!nextStepButton || !radioButtons) return;
      
    radioButtons.forEach((radio) => {
        radio.addEventListener("change", (event) => {
            addDeliveryToSummary();
            if (isRadioGroupSelected("delivery")) nextStepButton.disabled = false;
        });
    });

    nextStepButton.addEventListener("click", showNextStep);
}

const validatePayStep = () => {
    const nextStepButton = document.querySelector<HTMLButtonElement>(".order-buttons .next-step");
    const radioButtons = document.querySelectorAll<HTMLInputElement>(`input[name="payment"]`);
    
    if (!nextStepButton || !radioButtons) return;
      
    radioButtons.forEach((radio) => {
        radio.addEventListener("change", (event) => {
            if (isRadioGroupSelected("payment")) nextStepButton.disabled = false;
        });
    });

    nextStepButton.addEventListener("click", showNextStep);
}

const init = () => {
    handleRadioSelection();
    updateButtonState(); 
    showMobileCart();
    validateDeliveryStep();
    validatePayStep();
    
    // button in first step
    const nextButton = document.querySelector<HTMLButtonElement>(".order-buttons .next");
    if (!nextButton) return;
    nextButton.addEventListener("click", showNextSection);
};

init();
