const expandableSearchBar = () => {

  const searchBtn = document.querySelector(".search-btn");
  const searchBox = document.querySelector(".input");

  searchBtn.addEventListener('click', () => {
    searchBox.style.width = '80%';
    searchBox.style.paddingLeft = '40px';
    searchBox.focus();
    searchBox.setAttribute('placeholder', 'Search for items');
  });
}

export { expandableSearchBar };
