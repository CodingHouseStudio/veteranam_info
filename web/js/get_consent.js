const essentialCookies = ["js.stripe.com", "www.gstatic.com"];
const analyticsCookies = ["www.google-analytics.com"];
const allCookies = [...essentialCookies, ...analyticsCookies];
const consentPropertyName = "cookie_consent";

const retrieveConsentSettings = () => {
    const consentJsonString = localStorage.getItem(consentPropertyName);
    return JSON.parse(consentJsonString);
};

const checkConsentIsMissing = () => {
    const consentObj = retrieveConsentSettings();
    if (!consentObj || consentObj.length == 0) {
        return true;
    }
    return false;
};

const consentIsMissing = checkConsentIsMissing();

var blacklist;
if (consentIsMissing) {
    blacklist = allCookies;
} else {
    const acceptedCookies = retrieveConsentSettings();
    // Remove all script urls from blacklist that the user accepts (if all are accepted the blacklist will be empty)
    blacklist = allCookies.filter((el) => !acceptedCookies.includes(el));
}

// Yett blacklist expects list of RegExp objects
var blacklistRegEx = [];
for (let index = 0; index < blacklist.length; index++) {
    const regExp = new RegExp(blacklist[index]);
    blacklistRegEx.push(regExp);
}

YETT_BLACKLIST = blacklistRegEx;