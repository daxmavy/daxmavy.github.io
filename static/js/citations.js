// Citation hover functionality
// Shows citation preview on hover

(function() {
  'use strict';

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initCitations);
  } else {
    initCitations();
  }

  function initCitations() {
    const citationLinks = document.querySelectorAll('.citation-link');

    if (citationLinks.length === 0) return;

    // Create popup element
    const popup = document.createElement('div');
    popup.className = 'footnote-popup'; // Reuse footnote popup styles
    document.body.appendChild(popup);

    citationLinks.forEach(link => {
      const citationKey = link.getAttribute('data-citation');
      const refId = 'ref-' + citationKey;
      const refElement = document.getElementById(refId);

      if (!refElement) return;

      link.addEventListener('mouseenter', (e) => {
        popup.innerHTML = refElement.innerHTML;
        popup.classList.add('active');

        const rect = link.getBoundingClientRect();
        const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        const scrollLeft = window.pageXOffset || document.documentElement.scrollLeft;

        let top = rect.bottom + scrollTop + 5;
        let left = rect.left + scrollLeft;

        const popupRect = popup.getBoundingClientRect();
        if (left + popupRect.width > window.innerWidth) {
          left = window.innerWidth - popupRect.width - 20;
        }

        if (top + popupRect.height > window.innerHeight + scrollTop) {
          top = rect.top + scrollTop - popupRect.height - 5;
        }

        popup.style.top = top + 'px';
        popup.style.left = left + 'px';
      });

      link.addEventListener('mouseleave', () => {
        popup.classList.remove('active');
      });
    });
  }
})();
