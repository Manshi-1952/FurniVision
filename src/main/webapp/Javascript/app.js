//hamburger

document.getElementById("hamburger").addEventListener("click", function() {
    let menu = document.getElementById("category-list");
    if (menu.style.display === "none" || menu.style.display === "") {
        menu.style.display = "block";
    } else {
        menu.style.display = "none";
    }
});

let items = document.querySelectorAll('.slider .list .item');
let next = document.getElementById('next');
let prev = document.getElementById('prev');
let thumbnails = document.querySelectorAll('.thumbnail .item');

// config param
let countItem = items.length;
let itemActive = 0;
// event next click
next.onclick = function(){
    itemActive = itemActive + 1;
    if(itemActive >= countItem){
        itemActive = 0;
    }
    showSlider();
}
//event prev click
prev.onclick = function(){
    itemActive = itemActive - 1;
    if(itemActive < 0){
        itemActive = countItem - 1;
    }
    showSlider();
}
// auto run slider
let refreshInterval = setInterval(() => {
    next.click();
}, 5000)
function showSlider(){
    // remove item active old
    let itemActiveOld = document.querySelector('.slider .list .item.active');
    let thumbnailActiveOld = document.querySelector('.thumbnail .item.active');
    itemActiveOld.classList.remove('active');
    thumbnailActiveOld.classList.remove('active');

    // active new item
    items[itemActive].classList.add('active');
    thumbnails[itemActive].classList.add('active');
    setPositionThumbnail();

    // clear auto time run slider
    clearInterval(refreshInterval);
    refreshInterval = setInterval(() => {
        next.click();
    }, 5000)
}
function setPositionThumbnail () {
    let thumbnailActive = document.querySelector('.thumbnail .item.active');
    let rect = thumbnailActive.getBoundingClientRect();
    if (rect.left < 0 || rect.right > window.innerWidth) {
        thumbnailActive.scrollIntoView({ behavior: 'smooth', inline: 'nearest' });
    }
}

// click thumbnail
thumbnails.forEach((thumbnail, index) => {
    thumbnail.addEventListener('click', () => {
        itemActive = index;
        showSlider();
    })
})

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

// slider animation
window.addEventListener("scroll", function () {
    const slider = document.querySelector(".slider"); // Change this to your slider class or ID
    const whyChooseUs = document.getElementById("why-choose-us");

    if (window.scrollY >= whyChooseUs.offsetTop - 100) {
        slider.style.transform = "translateY(-100%)"; // Moves slider fully upwards
        slider.style.transition = "transform 0.6s ease-in-out"; // Smooth animation
    } else {
        slider.style.transform = "translateY(0)"; // Reset when scrolling back up
    }
});

// portfolio
let slideIndex = 0;

function showSlide(index) {
    const slides = document.querySelectorAll('.slider .list .item');
    if (index >= slides.length) {
        slideIndex = 0;
    } else if (index < 0) {
        slideIndex = slides.length - 1;
    }

    slides.forEach(slide => slide.classList.remove('active'));
    slides[slideIndex].classList.add('active');
}

function moveSlide(step) {
    slideIndex += step;
    showSlide(slideIndex);
}

// Initialize the slider
document.addEventListener('DOMContentLoaded', () => {
    setTimeout(() => {
        const slides = document.querySelectorAll('.slider .list .item');

        if (slides.length === 0) {
            console.error("No elements found with class .slider .list .item");
            return;
        }

        showSlide(slideIndex);
    }, 100);
});


