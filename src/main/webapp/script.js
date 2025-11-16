// Toggle Class Active
const navbartitle = document.querySelector(".navbar-title");
const hamMenu = document.querySelector("#ham-menu");

hamMenu.addEventListener("click", (e) => {
    e.preventDefault(); // cegah <a href="#"> balik ke atas
    navbartitle.classList.toggle("active");
});

document.addEventListener("click", function (e) {
    if (!hamMenu.contains(e.target) && !navbartitle.contains(e.target)) {
        navbartitle.classList.remove("active");
    }
});

// Navbar Scroll Effect
const navbar = document.querySelector(".navbar");

function getThreshold() {
    return 20;
}

function checkScroll() {
    const threshold = getThreshold();

    if (window.scrollY > threshold) {
        navbar.classList.add("scrolled");
        navbar.classList.remove("fade");
    } else {
        navbar.classList.remove("scrolled");
        navbar.classList.add("fade");
    }
}

checkScroll();
window.addEventListener("scroll", checkScroll);
window.addEventListener("resize", checkScroll);

// background change

const bg = document.querySelector(".background");
const images = [
    "/images/home-hotel.jpg",
    "/images/home-hotel2.jpeg",
    "/images/home-hotel3.jpeg",
    "/images/home-hotel4.jpeg",
    "/images/home-hotel5.jpeg",
];

let index = 0;

setInterval(() => {
    index = (index + 1) % images.length;
    bg.style.backgroundImage = `url(${images[index]})`;
}, 5000);

// Calendar
const datepicker = document.querySelector(".datepicker");
const rangeInput = datepicker.querySelector("input");
const calendarContainer = datepicker.querySelector(".calendar");
const leftCalendar = datepicker.querySelector(".left-side");
const rightCalendar = datepicker.querySelector(".right-side");
const prevButton = datepicker.querySelector(".prev");
const nextButton = datepicker.querySelector(".next");
const selectionEl = datepicker.querySelector(".selection");
const applyButton = datepicker.querySelector(".apply");
const cancelButton = datepicker.querySelector(".cancel");

let start = null;
let end = null;
let originalStart = null;
let originalEnd = null;

let leftDate = new Date();
leftDate.setDate(1);
let rightDate = new Date(leftDate);
rightDate.setMonth(rightDate.getMonth() + 1);

// format date as YYYY-MM-DD
const formatDate = (date) => {
    const y = date.getFullYear();
    const m = String(date.getMonth() + 1).padStart(2, "0");
    const d = String(date.getDate()).padStart(2, "0");
    return `${y}-${m}-${d}`;
};

const createDateEl = (date, isDisabled, isToday) => {
    const span = document.createElement("span");
    span.textContent = date.getDate();
    span.classList.toggle("disabled", isDisabled);
    if (!isDisabled) {
        span.classList.toggle("today", isToday);
        span.setAttribute("data-date", formatDate(date));
    }

    span.addEventListener("click", handleDateClick);
    span.addEventListener("mouseover", handleDateMouseover);

    return span;
};

const displaySelection = () => {
    if (start && end) {
        const startDate = start.toLocaleDateString("en");
        const endDate = end.toLocaleDateString("en");
        selectionEl.textContent = `${startDate} - ${endDate}`;
    }
};

const applyHighlighting = () => {
    const dateElements = datepicker.querySelectorAll("span[data-date]");
    for (const dateEl of dateElements) {
        dateEl.classList.remove("range-start", "range-end", "in-range");
    }

    // highlight start
    if (start) {
        const startDate = formatDate(start);
        const startEl = datepicker.querySelector(
            `span[data-date="${startDate}"]`
        );
        if (startEl) {
            startEl.classList.add("range-start");
            if (!end) startEl.classList.add("range-end");
        }
    }

    // highlight end
    if (end) {
        const endDate = formatDate(end);
        const endEl = datepicker.querySelector(`span[data-date="${endDate}"]`);
        if (endEl) endEl.classList.add("range-end");
    }

    // highlight range
    if (start && end) {
        for (const dateEl of dateElements) {
            const date = new Date(dateEl.dataset.date);
            if (date > start && date < end) {
                dateEl.classList.add("in-range");
            }
        }
    }
};

const handleDateMouseover = (event) => {
    const hoverEl = event.target;
    if (start && !end) {
        applyHighlighting();
        const hoverDate = new Date(hoverEl.dataset.date);
        datepicker.querySelectorAll("span[data-date]").forEach((dateEl) => {
            const date = new Date(dateEl.dataset.date);
            if (date > start && date < hoverDate && start < hoverDate) {
                dateEl.classList.add("in-range");
            }
        });
    }
};

const handleDateClick = (event) => {
    const dateEl = event.target;
    const selectedDate = new Date(dateEl.dataset.date);

    if (!start || (start && end)) {
        //first click or selecting a new range
        start = selectedDate;
        end = null;
    } else if (selectedDate < start) {
        // clicked date is before start date
        start = selectedDate;
    } else {
        // send it as end
        end = selectedDate;
    }

    applyHighlighting();
    displaySelection();
};

const renderCalendar = (calendar, year, month) => {
    const label = calendar.querySelector(".label");
    label.textContent = new Date(year, month).toLocaleString(
        navigator.language || "en-US",
        {
            year: "numeric",
            month: "long",
        }
    ); // Month YYYY

    const datesContainer = calendar.querySelector(".dates");
    datesContainer.innerHTML = "";

    // start on first sunday of the month
    const startDate = new Date(year, month, 1);
    startDate.setDate(startDate.getDate() - startDate.getDay());

    // end in 6 weeks
    const endDate = new Date(startDate);
    endDate.setDate(endDate.getDate() + 42);

    const fragment = document.createDocumentFragment();
    while (startDate < endDate) {
        const isDisabled = startDate.getMonth() != month;
        const isToday = formatDate(startDate) == formatDate(new Date());
        const dateEl = createDateEl(startDate, isDisabled, isToday);
        fragment.appendChild(dateEl);
        startDate.setDate(startDate.getDate() + 1);
    }

    datesContainer.appendChild(fragment);

    applyHighlighting();
};

const updateCalendars = () => {
    renderCalendar(leftCalendar, leftDate.getFullYear(), leftDate.getMonth());
    renderCalendar(
        rightCalendar,
        rightDate.getFullYear(),
        rightDate.getMonth()
    );
};

// show datepicker
rangeInput.addEventListener("focus", () => {
    originalStart = start;
    originalEnd = end;
    calendarContainer.hidden = false;
});

document.addEventListener("click", (event) => {
    if (!datepicker.contains(event.target)) {
        calendarContainer.hidden = true;
    }
});

//navigate prev month
prevButton.addEventListener("click", () => {
    leftDate.setMonth(leftDate.getMonth() - 1);
    rightDate.setMonth(rightDate.getMonth() - 1);
    updateCalendars();
});

//navigate next month
nextButton.addEventListener("click", () => {
    leftDate.setMonth(leftDate.getMonth() + 1);
    rightDate.setMonth(rightDate.getMonth() + 1);
    updateCalendars();
});

let mulai = "";
let selesai = "";

//handle apply selection click
applyButton.addEventListener("click", () => {
    if (start && end) {
        const startDate = start.toLocaleDateString("en");
        const endDate = end.toLocaleDateString("en");
        rangeInput.value = `${startDate} - ${endDate}`;
        calendarContainer.hidden = true;

        mulai = startDate;
        selesai = endDate;
    }
});

//handle cancel selection click
cancelButton.addEventListener("click", () => {
    start = originalStart;
    end = originalEnd;
    applyHighlighting();
    displaySelection();
    calendarContainer.hidden = true;
});

//init datepicker
updateCalendars();

document.querySelectorAll(".choose-btn").forEach((btn) => {
    btn.addEventListener("click", function () {
        console.log("this.dataset:", this.dataset);
        const roomTypeId = this.dataset.roomid;
        const roomName = this.dataset.roomname;
        const price = Number(this.dataset.price);

        const start = mulai;
        const end = selesai;

        const url = `/booking?room_type_id=${roomTypeId}&room_name=${roomName}&price=${price}&checkin=${start}&checkout=${end}`;
        window.location.href = url;
    });
});
