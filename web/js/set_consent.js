const saveToStorage = (acceptedCookies) => {
    const jsonString = JSON.stringify(acceptedCookies);
    localStorage.setItem(consentPropertyName, jsonString);
};

window.onload = () => {
    const consentPopup = document.getElementById("consent-popup");
    const consentPopupDetails = document.getElementById("consent-popup-details");
    const acceptBtn = document.getElementById("accept-btn");
    const moreInfoBtn = document.getElementById("info-btn");
    const saveBtn = document.getElementById("save-btn");
    const cancelBtn = document.getElementById("cancel-btn");
    const rejectBtn = document.getElementById("reject-btn");

    const acceptFn = (event) => {
        const cookiesTmp = [...essentialCookies, ...analyticsCookies];
        saveToStorage(cookiesTmp);
        // Reload window after localStorage was updated.
        // The blacklist will then only contain items the user has not yet consented to.
        window.location.reload();
    };

    const cancelFn = (event) => {
        consentPopup.classList.remove("hidden");
        consentPopupDetails.classList.add("hidden");
    };

    const rejectFn = (event) => {
        console.log("Rejected!");
    };

    const showDetailsFn = () => {
        consentPopup.classList.add("hidden");
        consentPopupDetails.classList.remove("hidden");
    };

    const saveFn = (event) => {
        const analyticsChecked = document.getElementById("analytics-cb").checked;
        var cookiesTmp = [...essentialCookies];
        if (analyticsChecked) {
            cookiesTmp.push(...analyticsCookies);
        }
        consentPopupDetails.classList.add("hidden");
        consentPopup.classList.remove("hidden");
    };

    acceptBtn.addEventListener("click", acceptFn);
    moreInfoBtn.addEventListener("click", showDetailsFn);
    saveBtn.addEventListener("click", saveFn);
    cancelBtn.addEventListener("click", cancelFn);
    rejectBtn.addEventListener("click", rejectFn);

    if (consentIsMissing) {
        consentPopup.classList.remove("hidden");
    }
};