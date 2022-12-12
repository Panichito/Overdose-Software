// navBar factory function is a function that create navigation bar to navigates to other pages on html
const navBar = (() => {
    // create navBar container
    const container = document.createElement('header');
    container.classList.add('top-header-2');
    const navBar = document.createElement('nav');
    
    // create logo
    const logo = document.createElement('a');
    logo.setAttribute('href', '/');
    const logoImg = document.createElement('img');
    logoImg.classList.add('logo-header');
    logoImg.setAttribute('src', logopic);
    logo.append(logoImg)

    // create hamberger button for responsive design
    const hamButton = document.createElement('a');
    hamButton.classList.add('toggle-button');
    hamButton.setAttribute('href', 'javascript:;');

    // add stripes to hamberger button
    for(let i = 1; i <= 3; i++) {
        const hamBar = document.createElement('span');
        hamBar.classList.add('bar');
        hamButton.append(hamBar);
    }

    // create links to pages on navBar
    const navLinks = document.createElement('ul');
    navLinks.classList.add('nav-links');

    // create links for navLinks
    for(let i = 1; i <= 4; i++) {
        const navLinksItem = document.createElement('li');
        const link = document.createElement('a');
        switch(i) {
            case 1:
                link.textContent = 'Home';
                link.setAttribute('href', '/');
                break;
            case 2:
                link.textContent = 'Our team';
                link.setAttribute('href', '/about');
                break;
            case 3:
                link.textContent = 'Contact';
                link.setAttribute('href', '/contact');
                break;
            case 4:
                link.textContent = 'Download';
                link.setAttribute('href', 'https://drive.google.com/drive/folders/11B1iHNkQi0HDjUran_029edsGej3-9QN');
                navLinksItem.classList.add('btn');
                break;
            default:
                print('You are not suppose to reach here!');
        }
        // append link to each list
        navLinksItem.append(link);
        // append each list to the navLinks
        navLinks.append(navLinksItem);
    }

    // implement clickable hamberger button
    hamButton.addEventListener('click', () => {
        navLinks.classList.toggle('active');
    });

    // append logo, hamberger button, and links to other pages on navBar to the navigation bar
    navBar.append(logo, hamButton, navLinks);
    // append navigation bar to the container
    container.append(navBar);
    // append container to the html file before every elements
    document.body.insertBefore(container, document.body.firstChild);
})();

export default navBar;