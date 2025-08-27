// Mobile Map Fix Script
// Add this script to all HTML files to ensure maps work on mobile

function initializeMobileMapFix() {
    // Check if we're on a mobile device
    const isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
    
    // Wait for Leaflet to be loaded
    if (typeof L === 'undefined') {
        setTimeout(initializeMobileMapFix, 100);
        return;
    }

    // Fix for all Leaflet maps on the page
    document.querySelectorAll('[id^="map"]').forEach(mapElement => {
        // Ensure proper sizing
        if (isMobile) {
            mapElement.style.width = '100%';
            mapElement.style.minHeight = '350px';
            mapElement.style.position = 'relative';
            mapElement.style.zIndex = '1';
        }
    });

    // Override Leaflet map initialization
    const originalMap = L.map;
    L.map = function(id, options) {
        // Add mobile-friendly default options
        const mobileOptions = {
            tap: true,
            touchZoom: true,
            dragging: true,
            scrollWheelZoom: !isMobile, // Disable scroll zoom on mobile
            ...options
        };
        
        const map = originalMap.call(this, id, mobileOptions);
        
        // Force resize after initialization
        setTimeout(() => {
            map.invalidateSize();
        }, 250);
        
        // Handle orientation changes
        window.addEventListener('orientationchange', () => {
            setTimeout(() => {
                map.invalidateSize();
            }, 300);
        });
        
        // Handle window resize
        window.addEventListener('resize', () => {
            setTimeout(() => {
                map.invalidateSize();
            }, 300);
        });
        
        return map;
    };
}

// Initialize on DOM ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initializeMobileMapFix);
} else {
    initializeMobileMapFix();
}