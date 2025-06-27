export async function loadNavbar(selector) {
  try {
    const response = await fetch('./components/navbar.html');
    const html = await response.text();
    document.querySelector(selector).innerHTML = html;
    
    // Initialize mobile menu toggle
    const mobileMenuBtn = document.getElementById('mobile-menu-btn');
    const mobileMenu = document.getElementById('mobile-menu');
    
    if (mobileMenuBtn && mobileMenu) {
      mobileMenuBtn.addEventListener('click', () => {
        mobileMenu.classList.toggle('hidden');
        
        // Toggle menu icon
        const icon = mobileMenuBtn.querySelector('[data-lucide]');
        if (mobileMenu.classList.contains('hidden')) {
          icon.setAttribute('data-lucide', 'menu');
        } else {
          icon.setAttribute('data-lucide', 'x');
        }
        lucide.createIcons();
      });
    }
    
    // Initialize Lucide icons
    lucide.createIcons();
  } catch (error) {
    console.error('Error loading navbar:', error);
  }
}