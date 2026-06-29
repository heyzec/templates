/**
 * CSS to hide everything on the page,
 * except for elements that have the "beastify-image" class.
 */
const hidePage = `body > :not(.beastify-image) {
                    display: none;
                  }`;

/**
 * Listen for clicks on the buttons, and send the appropriate message to
 * the content script in the page.
 */
function listenForClicks() {
  document.addEventListener("click", (e) => {
    console.log(`You clicked on a ${e.target.textContent} button!`);
  });
}

/**
 * When the popup loads, inject a content script into the active tab,
 * and add a click handler.
 * If we couldn't inject the script, handle the error.
 */
(async function runOnPopupOpened() {
  try {
    const [tab] = await browser.tabs.query({
      active: true,
      currentWindow: true,
    });

    // await browser.scripting.executeScript({
    //   target: { tabId: tab.id },
    //   files: ["/content_scripts/beastify.js"],
    // });
    listenForClicks();
  } catch (e) {
    reportExecuteScriptError(e);
  }
})();
