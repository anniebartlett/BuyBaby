const explandableSearchBar = () => {

  const searchBtn = document.querySelector('.search-btn');
  const searchBox = document.querySelector('#query');

  searchBtn.addEventListener('click', () => {
    searchBox.style.width = '80%';
    searchBox.style.paddingLeft = '40px';
    searchBox.focus();
    searchBox.setAttribute('placeholder', 'Browse items')
  });
}

export { expandableSearchBar };
