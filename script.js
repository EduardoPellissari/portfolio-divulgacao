const revealItems = document.querySelectorAll(".reveal");

const observer = new IntersectionObserver(
  (entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.classList.add("visible");
        observer.unobserve(entry.target);
      }
    });
  },
  { threshold: 0.18 }
);

revealItems.forEach((item) => observer.observe(item));

const year = document.getElementById("year");
if (year) year.textContent = new Date().getFullYear();

const carousels = document.querySelectorAll("[data-carousel]");

carousels.forEach((carousel) => {
  const viewport = carousel.querySelector("[data-viewport]");
  const track = carousel.querySelector("[data-track]");
  const slides = carousel.querySelectorAll(".carousel-slide");
  const prevBtn = carousel.querySelector("[data-prev]");
  const nextBtn = carousel.querySelector("[data-next]");
  const dots = carousel.querySelectorAll("[data-dot]");
  const current = carousel.querySelector("[data-current]");
  const total = carousel.querySelector("[data-total]");

  if (!viewport || !track || !slides.length) return;

  let index = 0;
  let startX = 0;
  let endX = 0;

  if (total) total.textContent = String(slides.length);

  const goToSlide = (newIndex) => {
    index = (newIndex + slides.length) % slides.length;
    const offset = viewport.clientWidth * index;
    track.style.transform = `translateX(-${offset}px)`;

    dots.forEach((dot, dotIndex) => {
      dot.classList.toggle("active", dotIndex === index);
    });

    if (current) current.textContent = String(index + 1);
  };

  prevBtn?.addEventListener("click", () => goToSlide(index - 1));
  nextBtn?.addEventListener("click", () => goToSlide(index + 1));

  dots.forEach((dot, dotIndex) => {
    dot.addEventListener("click", () => goToSlide(dotIndex));
  });

  carousel.addEventListener("keydown", (event) => {
    if (event.key === "ArrowLeft") goToSlide(index - 1);
    if (event.key === "ArrowRight") goToSlide(index + 1);
  });

  carousel.addEventListener("touchstart", (event) => {
    startX = event.changedTouches[0].clientX;
  });

  carousel.addEventListener("touchend", (event) => {
    endX = event.changedTouches[0].clientX;
    const distance = endX - startX;
    if (distance > 40) goToSlide(index - 1);
    if (distance < -40) goToSlide(index + 1);
  });

  window.addEventListener("resize", () => goToSlide(index));

  goToSlide(0);
});
