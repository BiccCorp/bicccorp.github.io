document.addEventListener('DOMContentLoaded', () => {
  const links = document.querySelectorAll('a');

  links.forEach(link => {
    if (link.href && link.origin === window.location.origin) {
      link.addEventListener('click', e => {
        e.preventDefault();

        document.body.classList.add('fade-out');

        setTimeout(() => {
          window.location.href = link.href;
        }, 500);
      });
    }
  });
});
