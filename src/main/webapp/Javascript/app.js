//hamburger

document.getElementById("hamburger").addEventListener("click", function() {
  let menu = document.getElementById("category-list");
  if (menu.style.display === "none" || menu.style.display === "") {
    menu.style.display = "block";
  } else {
    menu.style.display = "none";
  }
});

//slider
let items = document.querySelectorAll('.slider .list .item');
let next = document.getElementById('next');
let prev = document.getElementById('prev');

// config param
let countItem = items.length;
let itemActive = 0;

// event next click
next.onclick = function () {
  itemActive = itemActive + 1;
  if (itemActive >= countItem) {
    itemActive = 0;
  }
  showSlider();
}

// event prev click
prev.onclick = function () {
  itemActive = itemActive - 1;
  if (itemActive < 0) {
    itemActive = countItem - 1;
  }
  showSlider();
}

// auto run slider
let refreshInterval = setInterval(() => {
  next.click();
}, 4000);

function showSlider() {
  // remove item active old
  let itemActiveOld = document.querySelector('.slider .list .item.active');
  itemActiveOld.classList.remove('active');

  // activate new item
  items[itemActive].classList.add('active');

  // clear auto time run slider
  clearInterval(refreshInterval);
  refreshInterval = setInterval(() => {
    next.click();
  }, 4000);
}

//dropdown
document.addEventListener("DOMContentLoaded", function () {
  let dropdownBtn = document.querySelector(".dropbtn");
  let dropdownContent = document.querySelector(".dropdown-content");

  dropdownBtn.addEventListener("click", function (event) {
    event.stopPropagation();
    dropdownContent.style.display = dropdownContent.style.display === "block" ? "none" : "block";
  });

  document.addEventListener("click", function () {
    dropdownContent.style.display = "none";
  });
});



