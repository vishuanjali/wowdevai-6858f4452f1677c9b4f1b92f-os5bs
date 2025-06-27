export async function loadFooter(selector) {
  try {
    const response = await fetch('./components/footer.html');
    const html = await response.text();
    document.querySelector(selector).innerHTML = html;
    
    // Initialize Lucide icons
    lucide.createIcons();
  } catch (error) {
    console.error('Error loading footer:', error);
  }
}