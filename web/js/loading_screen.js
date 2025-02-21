const progressLine = document.getElementById("pre-loader-bar");
const loadingComponent = document.getElementById("column-loading");
const retryButton = document.getElementById("retry-button");

// function removeSplashFromWeb() {
//   document.getElementById("splash")?.remove();
//   document.getElementById("splash-branding")?.remove();
//   document.body.style.background = "transparent";
// }
// progressLine.style.display = "block";
// loadingComponent.style.display = "block";
// retryButton.style.display = "none";

let isLoaded = false;

window.addEventListener("flutter-first-frame", function () {
    // setTimeout(() => {
    isLoaded = true;
    retryButton.style.zIndex = 0;
    progressLine.remove();
    loadingComponent.remove();
    // }, 20000);
});
setTimeout(() => {
    if (!isLoaded) {
        retryButton.style.display = "flex";
    }
}, 8000);

retryButton.addEventListener("click", function () {
    location.reload();
    retryButton.classList.add("loading"); // Add a loading class
    document.querySelector(".loading-circle").style.display =
        "inline-block";
    document.getElementById("splash-image").style.display = "none";
    document.getElementById("loader-component").style.display = "none";
    console.log("Reloading...");
});