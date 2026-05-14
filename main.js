/**
 * ReviewGamer Main Script
 * Consolidates all site functionality into one file.
 */

document.addEventListener("DOMContentLoaded", () => {
    initMenu();
    initSmoothScroll();
    initGalleries();
    initVersionSelectors();
});

/**
 * Mobile Menu Logic
 */
function initMenu() {
    const menuToggle = document.getElementById("menu-toggle");
    const nav = document.getElementById("main-nav");

    menuToggle?.addEventListener("click", () => {
        const isOpen = nav.classList.toggle("open");
        menuToggle.setAttribute("aria-expanded", isOpen);
        menuToggle.setAttribute("aria-label", isOpen ? "Cerrar menú" : "Abrir menú");
    });
}

/**
 * Smooth Scroll for internal links
 */
function initSmoothScroll() {
    const nav = document.getElementById("main-nav");
    const menuToggle = document.getElementById("menu-toggle");

    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            const href = this.getAttribute('href');
            if (href === "#") return;

            // Only smooth scroll if on the same page
            if (href.startsWith("#")) {
                const target = document.querySelector(href);
                if (target) {
                    e.preventDefault();
                    target.scrollIntoView({
                        behavior: 'smooth'
                    });
                    // Close mobile menu if open
                    nav?.classList.remove("open");
                    menuToggle?.setAttribute("aria-expanded", "false");
                    menuToggle?.setAttribute("aria-label", "Abrir menú");
                }
            }
        });
    });
}

/**
 * Product Gallery Logic
 */
function initGalleries() {
    const thumbs = document.querySelectorAll('.gallery-thumbs img');
    const mainImg = document.querySelector('.gallery-main img');
    
    if (!mainImg || thumbs.length === 0) return;

    thumbs.forEach(thumb => {
        thumb.addEventListener('click', function() {
            mainImg.src = this.src;
            mainImg.alt = this.alt;
            
            // Remove active border from all thumbs
            thumbs.forEach(t => {
                t.parentElement.style.borderColor = 'transparent';
            });
            
            // Add active border to current thumb
            // Check for brand-specific border color
            const brandColor = getComputedStyle(document.documentElement).getPropertyValue('--xbox-green').trim();
            this.parentElement.style.borderColor = brandColor || 'var(--primary)';
        });
    });
}

/**
 * Product Version Selector Logic
 */
function initVersionSelectors() {
    const versionBtns = document.querySelectorAll('.version-btn');
    if (versionBtns.length === 0) return;

    const elements = {
        title: document.getElementById('product-title'),
        priceOld: document.getElementById('price-old'),
        priceNew: document.getElementById('price-new'),
        desc: document.getElementById('product-desc'),
        storage: document.getElementById('benefit-storage'),
        design: document.getElementById('benefit-design'),
        rating: document.getElementById('rating-text'),
        reviews: document.getElementById('reviews-list')
    };

    // Data should be provided in a global variable or data attribute
    // For now, we'll check if the global 'productVersions' exists
    if (typeof productVersions === 'undefined') return;

    versionBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const v = this.getAttribute('data-version');
            const data = productVersions[v];
            if (!data) return;

            // Update UI
            if (elements.title) elements.title.innerText = data.title;
            if (elements.priceOld) elements.priceOld.innerText = data.priceOld;
            if (elements.priceNew) elements.priceNew.innerText = data.priceNew;
            if (elements.desc) elements.desc.innerText = data.desc;
            if (elements.storage) elements.storage.innerText = data.storage;
            if (elements.design) elements.design.innerText = data.design;
            if (elements.rating) elements.rating.innerText = data.rating;
            if (elements.reviews) elements.reviews.innerHTML = data.reviews;

            // Update active button
            versionBtns.forEach(b => b.classList.remove('active'));
            this.classList.add('active');
        });
    });
}
