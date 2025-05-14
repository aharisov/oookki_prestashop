function saveViewedProduct(productId, maxItems = 12, cookieName = 'viewed_products') {
    // Get current list from cookie
    const existing = getCookie(cookieName);
    let viewed = existing ? existing.split(',').map(id => parseInt(id)) : [];
  
    // Remove if already exists
    viewed = viewed.filter(id => id !== productId);
    // Add to beginning
    viewed.unshift(productId);
    // Limit to last `maxItems`
    viewed = viewed.slice(0, maxItems);
  
    // Save back to cookie
    document.cookie = `${cookieName}=${viewed.join(',')}; path=/; max-age=${60 * 60 * 24 * 30}`;
}
  
// Helper to read cookie
function getCookie(name) {
    const value = `; ${document.cookie}`;
    const parts = value.split(`; ${name}=`);
    if (parts.length >= 2) return parts.pop().split(';').shift();
    return null;
}

document.addEventListener('DOMContentLoaded', () => {
    const bodyClasses = document.body.className;
    const match = bodyClasses.match(/product-id-(\d+)/);

    if (match) {
        const productId = parseInt(match[1]);
        console.info('found id', productId);

        saveViewedProduct(productId);
    }
});
  