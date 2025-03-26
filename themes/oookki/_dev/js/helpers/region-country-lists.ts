const regionsFranceList: string[] = [
    "Hors France", "Ain (01)", "Aisne (02)", "Allier (03)", "Alpes-de-Haute-Provence (04)", "Hautes-Alpes (05)",
    "Alpes-Maritimes (06)", "Ardèche (07)", "Ardennes (08)", "Ariège (09)", "Aube (10)",
    "Aude (11)", "Aveyron (12)", "Bouches-du-Rhône (13)", "Calvados (14)", "Cantal (15)",
    "Charente (16)", "Charente-Maritime (17)", "Cher (18)", "Corrèze (19)", "Corse-du-Sud (2A)",
    "Haute-Corse (2B)", "Côte-d'Or (21)", "Côtes-d'Armor (22)", "Creuse (23)", "Dordogne (24)",
    "Doubs (25)", "Drôme (26)", "Eure (27)", "Eure-et-Loir (28)", "Finistère (29)", "Gard (30)",
    "Haute-Garonne (31)", "Gers (32)", "Gironde (33)", "Hérault (34)", "Ille-et-Vilaine (35)",
    "Indre (36)", "Indre-et-Loire (37)", "Isère (38)", "Jura (39)", "Landes (40)", "Loir-et-Cher (41)",
    "Loire (42)", "Haute-Loire (43)", "Loire-Atlantique (44)", "Loiret (45)", "Lot (46)", "Lot-et-Garonne (47)",
    "Lozère (48)", "Maine-et-Loire (49)", "Manche (50)", "Marne (51)", "Haute-Marne (52)", "Mayenne (53)",
    "Meurthe-et-Moselle (54)", "Meuse (55)", "Morbihan (56)", "Moselle (57)", "Nièvre (58)", "Nord (59)",
    "Oise (60)", "Orne (61)", "Pas-de-Calais (62)", "Puy-de-Dôme (63)", "Pyrénées-Atlantiques (64)",
    "Hautes-Pyrénées (65)", "Pyrénées-Orientales (66)", "Bas-Rhin (67)", "Haut-Rhin (68)", "Rhône (69)",
    "Haute-Saône (70)", "Saône-et-Loire (71)", "Sarthe (72)", "Savoie (73)", "Haute-Savoie (74)", "Paris (75)",
    "Seine-Maritime (76)", "Seine-et-Marne (77)", "Yvelines (78)", "Deux-Sèvres (79)", "Somme (80)", "Tarn (81)",
    "Tarn-et-Garonne (82)", "Var (83)", "Vaucluse (84)", "Vendée (85)", "Vienne (86)", "Haute-Vienne (87)",
    "Vosges (88)", "Yonne (89)", "Territoire de Belfort (90)", "Essonne (91)", "Hauts-de-Seine (92)",
    "Seine-Saint-Denis (93)", "Val-de-Marne (94)", "Val-d'Oise (95)"
];

const countriesList: string[] = [
    "Afghanistan", "Albanie", "Algérie", "Andorre", "Angola", "Antigua-et-Barbuda", "Argentine", "Arménie", "Australie", "Autriche", 
    "Azerbaïdjan", "Bahamas", "Bahreïn", "Bangladesh", "Barbade", "Belgique", "Belize", "Bénin", "Bhoutan", "Bolivie", 
    "Bosnie-Herzégovine", "Botswana", "Brésil", "Brunei", "Bulgarie", "Burkina Faso", "Burundi", "Cambodge", "Cameroun", "Canada", 
    "Cap-Vert", "Chili", "Chine", "Chypre", "Colombie", "Comores", "Congo (République du Congo)", "Congo (République Démocratique du Congo)", 
    "Costa Rica", "Croatie", "Cuba", "Danemark", "Djibouti", "Dominique", "Égypte", "El Salvador", "Équateur", "Érythrée", 
    "Espagne", "Estonie", "Eswatini", "États-Unis", "Éthiopie", "Fidji", "Finlande", "France", "Gabon", "Gambie", "Géorgie", 
    "Ghana", "Grèce", "Grenade", "Guatemala", "Guinée", "Guinée-Bissau", "Guinée équatoriale", "Guyana", "Haïti", "Honduras", 
    "Hongrie", "Inde", "Indonésie", "Irak", "Iran", "Irlande", "Islande", "Israël", "Italie", "Jamaïque", "Japon", "Jordanie", 
    "Kazakhstan", "Kenya", "Kiribati", "Koweït", "Laos", "Lesotho", "Lettonie", "Liban", "Liberia", "Libye", "Liechtenstein", 
    "Lituanie", "Luxembourg", "Macédoine du Nord", "Madagascar", "Malaisie", "Malawi", "Maldives", "Mali", "Malte", "Maroc", 
    "Marshall (îles)", "Maurice", "Mauritanie", "Mexique", "Micronésie", "Moldavie", "Monaco", "Mongolie", "Monténégro", 
    "Mozambique", "Namibie", "Nauru", "Népal", "Nicaragua", "Niger", "Nigeria", "Niue", "Norvège", "Nouvelle-Zélande", 
    "Oman", "Ouganda", "Pakistan", "Palaos", "Panama", "Papouasie-Nouvelle-Guinée", "Paraguay", "Pays-Bas", "Pérou", "Philippines", 
    "Pologne", "Portugal", "Qatar", "République tchèque", "République dominicaine", "République du Congo", "Roumanie", 
    "Rwanda", "Saint-Christophe-et-Niévès", "Saint-Marin", "Saint-Siège", "Sainte-Lucie", "Sénégal", "Serbie", "Seychelles", 
    "Sierra Leone", "Singapour", "Syrie", "Somalie", "Soudan", "Soudan du Sud", "Sri Lanka", "Suède", "Suisse", "Suriname", 
    "Suisse", "Syrie", "Tadjikistan", "Tanzanie", "Tchad", "Thaïlande", "Timor oriental", "Togo", "Tonga", "Trinité-et-Tobago", 
    "Tunisie", "Turkménistan", "Turquie", "Tuvalu", "Ukraine", "Uruguay", "Vanuatu", "Vatican", "Venezuela", "Vietnam", "Yémen", 
    "Zambie", "Zimbabwe"
];  

/**
 * Shows/hides list popup
 * @param selectClass selector for list parent
 * @param inputSelector selector for list input
 * @param show boolean for show or hide list popup
 * @returns 
 */
const showDataList = (selectClass: string, inputSelector: string = "input", show: boolean) => {
    const dataList = document.querySelector(selectClass);
    if (!dataList) return;
    
    const dataInput = dataList.querySelector(inputSelector) as HTMLInputElement;
    if (!dataInput) return;

    if (show) {
        dataList.setAttribute("aria-hidden", "false");
        dataInput.required = true;
    } else {
        dataList.setAttribute("aria-hidden", "true");
        dataInput.required = false;
    }
}

// initialize regions and countires lists
const initDataList = (): void => {
    const inputRegionField = document.getElementById("birth-region") as HTMLInputElement;
    const dataRegionList = document.getElementById("region-datalist") as HTMLInputElement;

    const inputCountryField = document.getElementById("birth-country") as HTMLInputElement;
    const dataCountryList = document.getElementById("country-datalist") as HTMLInputElement;

    if (!inputRegionField || !dataRegionList || !inputCountryField || !dataCountryList) return;

    const dataListChange = (data: string[], input: HTMLInputElement, listElement: HTMLInputElement) => {
        const inputParent = input.closest(".with-list");
        if (!inputParent) return;

        // create data list
        const populateDatalist = (filter: string = "") => {
            listElement.innerHTML = ""; 
            const filteredList = data.filter(dataItem =>
                dataItem.toLowerCase().includes(filter.toLowerCase())
            );

            if (filteredList.length === 0) {
                listElement.setAttribute("aria-hidden", "true");
                inputParent?.classList.remove("open");
                return;
            }

            filteredList.forEach(dataItem => {
                const listItem = document.createElement("li");
                listItem.textContent = dataItem;
                listItem.classList.add("option");
                listItem.addEventListener("click", () => {
                    input.value = dataItem;
                    listElement.setAttribute("aria-hidden", "true");
                    inputParent?.classList.remove("open");
                    inputParent?.querySelector(".error-message")?.remove();
                    inputParent?.classList.remove("error");

                    if (input.getAttribute("id") == "birth-region") {
                        if (input.value == "Hors France") {
                            showDataList(".country-select", "input", true);
                            showDataList(".birth-city-select", "input", false);
                        } else {
                            showDataList(".country-select", "input", false);
                            showDataList(".birth-city-select", "input", true);
                        }
                    }
                });
                listElement.appendChild(listItem);
            });

            listElement.setAttribute("aria-hidden", "false"); 
            inputParent?.classList.remove("open");
        };

        // show list
        input.addEventListener("focus", () => {
            populateDatalist();

            inputParent?.classList.add("open");
        });

        // dynamic filter of list items
        input.addEventListener("input", () => populateDatalist(input.value));

        // hide list on clicking outside of it
        document.addEventListener("click", (event) => {
            if (!input.contains(event.target as Node) && !listElement.contains(event.target as Node)) {
                listElement.setAttribute("aria-hidden", "true");
                inputParent?.classList.remove("open");
            }
        });
    }

    dataListChange(regionsFranceList, inputRegionField, dataRegionList);
    dataListChange(countriesList, inputCountryField, dataCountryList);
}

initDataList();