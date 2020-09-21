const explandableSearchBar = () => {
  const searchBtn = document.getElementById('search-btn');
  const search = document.getElementById('search');
  const i = 0;
  const message = 'Browse products';
  const speed = 100;

  searchBtn.addEventListener('click', () => {
    search.style.width = '80%';
    search.style.paddingLeft = '40px';
    search.focus();
    search.setAttribute('placeholder', 'Browse products')
  });
}

export { expandableSearchBar };
