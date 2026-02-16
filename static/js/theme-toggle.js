(function() {
  'use strict';

  const STORAGE_KEY = 'theme-preference';

  function getColorPreference() {
    if (localStorage.getItem(STORAGE_KEY)) {
      return localStorage.getItem(STORAGE_KEY);
    }
    // Default to dark mode
    return 'dark';
  }

  function setPreference(theme) {
    localStorage.setItem(STORAGE_KEY, theme);
    reflectPreference(theme);
  }

  function reflectPreference(theme) {
    document.documentElement.setAttribute('data-theme', theme);

    const toggleBtn = document.querySelector('.theme-toggle');
    if (toggleBtn) {
      toggleBtn.setAttribute('aria-label', theme === 'dark' ? 'Switch to light mode' : 'Switch to dark mode');
    }
  }

  function init() {
    // Set initial theme
    const theme = getColorPreference();
    reflectPreference(theme);

    // Add click handler
    const toggleBtn = document.querySelector('.theme-toggle');
    if (toggleBtn) {
      toggleBtn.addEventListener('click', function() {
        const currentTheme = document.documentElement.getAttribute('data-theme');
        const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
        setPreference(newTheme);
      });
    }

    // Watch for system theme changes
    window
      .matchMedia('(prefers-color-scheme: dark)')
      .addEventListener('change', function(e) {
        const newTheme = e.matches ? 'dark' : 'light';
        setPreference(newTheme);
      });
  }

  // Run on DOM ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
