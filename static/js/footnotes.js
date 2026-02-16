// Footnote hover functionality
// Creates a popup when hovering over footnote references

(function() {
  'use strict';

  // Wait for DOM to be ready
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initFootnotes);
  } else {
    initFootnotes();
  }

  function initFootnotes() {
    // Get all footnote references
    const footnoteRefs = document.querySelectorAll('.footnote-ref');

    if (footnoteRefs.length === 0) return;

    // Create popup element
    const popup = document.createElement('div');
    popup.className = 'footnote-popup';
    document.body.appendChild(popup);

    footnoteRefs.forEach(ref => {
      // Get the footnote ID
      const href = ref.getAttribute('href');
      if (!href || !href.startsWith('#')) return;

      const footnoteId = href.substring(1);
      const footnote = document.getElementById(footnoteId);

      if (!footnote) return;

      // Get footnote content (excluding the back reference)
      const footnoteContent = footnote.cloneNode(true);
      const backref = footnoteContent.querySelector('.footnote-backref');
      if (backref) backref.remove();

      // Add hover listeners
      ref.addEventListener('mouseenter', (e) => {
        popup.innerHTML = footnoteContent.innerHTML;
        popup.classList.add('active');

        // Position popup near the reference
        const rect = ref.getBoundingClientRect();
        const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        const scrollLeft = window.pageXOffset || document.documentElement.scrollLeft;

        // Try to position below the reference, but adjust if it goes off screen
        let top = rect.bottom + scrollTop + 5;
        let left = rect.left + scrollLeft;

        // Adjust if popup goes off right edge
        const popupRect = popup.getBoundingClientRect();
        if (left + popupRect.width > window.innerWidth) {
          left = window.innerWidth - popupRect.width - 20;
        }

        // Adjust if popup goes off bottom
        if (top + popupRect.height > window.innerHeight + scrollTop) {
          top = rect.top + scrollTop - popupRect.height - 5;
        }

        popup.style.top = top + 'px';
        popup.style.left = left + 'px';
      });

      ref.addEventListener('mouseleave', () => {
        popup.classList.remove('active');
      });
    });

    // Close popup when clicking anywhere
    document.addEventListener('click', (e) => {
      if (!e.target.closest('.footnote-ref')) {
        popup.classList.remove('active');
      }
    });
  }
})();
