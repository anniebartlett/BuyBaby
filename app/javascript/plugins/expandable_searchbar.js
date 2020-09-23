const expandableSearchBar = () => {

  const searchBtn = document.querySelector(".fa-search");
  const searchBox = document.querySelector(".input");

  searchBtn.addEventListener('click', () => {
    searchBox.style.width = '100%';
    searchBox.style.paddingLeft = '40px';
    searchBox.style.cursor = 'text';
    searchBox.focus();
    searchBox.setAttribute('placeholder', 'Search for items');
  });
}

export { expandableSearchBar };
