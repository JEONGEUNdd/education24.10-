// DOM이 완전히 로드된 후 실행
document.addEventListener('DOMContentLoaded', function() {
    // 현재 활성화된 네비게이션 링크 표시
    highlightCurrentPage();

    // 스크롤 이벤트 처리
    handleScroll();

    // 모바일 메뉴 처리 (필요한 경우)
    initMobileMenu();
});

// 현재 페이지에 해당하는 네비게이션 링크 하이라이트
function highlightCurrentPage() {
    const currentPath = window.location.pathname;
    const navLinks = document.querySelectorAll('.nav-links a');

    navLinks.forEach(link => {
        if (link.getAttribute('href') === currentPath) {
            link.classList.add('active');
        }
    });
}

// 스크롤 이벤트 처리
function handleScroll() {
    const header = document.querySelector('header');
    const scrollThreshold = 50;

    window.addEventListener('scroll', () => {
        if (window.scrollY > scrollThreshold) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
    });
}

// 모바일 메뉴 초기화
function initMobileMenu() {
    const nav = document.querySelector('nav');
    const mobileMenuButton = document.createElement('button');
    mobileMenuButton.className = 'mobile-menu-button';
    mobileMenuButton.innerHTML = `
        <span class="menu-icon">
            <span></span>
            <span></span>
            <span></span>
        </span>
    `;

    // 모바일 화면에서만 버튼 표시
    if (window.innerWidth <= 768) {
        nav.insertBefore(mobileMenuButton, nav.firstChild);
    }

    // 모바일 메뉴 토글
    mobileMenuButton.addEventListener('click', () => {
        nav.classList.toggle('mobile-menu-open');
    });

    // 화면 크기 변경 감지
    window.addEventListener('resize', () => {
        if (window.innerWidth <= 768) {
            if (!nav.contains(mobileMenuButton)) {
                nav.insertBefore(mobileMenuButton, nav.firstChild);
            }
        } else {
            if (nav.contains(mobileMenuButton)) {
                nav.removeChild(mobileMenuButton);
            }
            nav.classList.remove('mobile-menu-open');
        }
    });
}

// 부드러운 스크롤 기능
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth'
            });
        }
    });
});

// 페이지 로드 애니메이션
function addLoadAnimation() {
    const mainContent = document.querySelector('main');
    mainContent.style.opacity = '0';

    window.addEventListener('load', () => {
        mainContent.style.transition = 'opacity 0.5s ease-in';
        mainContent.style.opacity = '1';
    });
}
addLoadAnimation();

// 폼 유효성 검사 (필요한 경우)
function validateForm(formElement) {
    const inputs = formElement.querySelectorAll('input[required], textarea[required]');
    let isValid = true;

    inputs.forEach(input => {
        if (!input.value.trim()) {
            isValid = false;
            showError(input, '이 필드는 필수입니다.');
        } else {
            clearError(input);
        }
    });

    return isValid;
}

// 에러 메시지 표시
function showError(element, message) {
    const errorDiv = element.nextElementSibling?.classList.contains('error-message')
        ? element.nextElementSibling
        : document.createElement('div');

    errorDiv.className = 'error-message';
    errorDiv.textContent = message;

    if (!element.nextElementSibling?.classList.contains('error-message')) {
        element.parentNode.insertBefore(errorDiv, element.nextElementSibling);
    }

    element.classList.add('error');
}

// 에러 메시지 제거
function clearError(element) {
    const errorDiv = element.nextElementSibling;
    if (errorDiv?.classList.contains('error-message')) {
        errorDiv.remove();
    }
    element.classList.remove('error');
}

// 이미지 지연 로딩
function lazyLoadImages() {
    const images = document.querySelectorAll('img[data-src]');

    const imageObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const img = entry.target;
                img.src = img.dataset.src;
                img.removeAttribute('data-src');
                observer.unobserve(img);
            }
        });
    });

    images.forEach(img => imageObserver.observe(img));
}

// 페이지 로드 시 이미지 지연 로딩 실행
if ('IntersectionObserver' in window) {
    lazyLoadImages();
}

// 디바운스 함수 (성능 최적화)
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

// 스크롤 위치에 따른 'Scroll to Top' 버튼 표시
function initScrollToTop() {
    const scrollButton = document.createElement('button');
    scrollButton.className = 'scroll-to-top';
    scrollButton.innerHTML = '↑';
    document.body.appendChild(scrollButton);

    const handleScroll = debounce(() => {
        if (window.scrollY > 300) {
            scrollButton.classList.add('visible');
        } else {
            scrollButton.classList.remove('visible');
        }
    }, 100);

    window.addEventListener('scroll', handleScroll);

    scrollButton.addEventListener('click', () => {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });
}

// 스크롤 투 탑 버튼 초기화
initScrollToTop();