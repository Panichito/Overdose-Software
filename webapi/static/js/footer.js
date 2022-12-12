// footer factory function
// is a function that create a footer of website to display information on html
const footer = (() => {
    // create a footer section
    const footer = document.createElement('footer');
    footer.classList.add('footer-dark');
    
    // create a container
    const container = document.createElement('div');
    container.classList.add('container');
    footer.append(container);

    // create a row for links
    const row = document.createElement('div');
    row.classList.add('row');
    
    // create items inside a row
    for(let i = 1; i <= 4; i++) {
        const item = document.createElement('div');
        const header = document.createElement('h3');
        const ul = document.createElement('ul');
        
        switch(i) {
            // Services links
            case 1:
                item.classList.add('col-sm-6', 'col-md-3', 'item');
                header.textContent = 'Services';

                // create sub-links inside an item
                for(let i = 1; i <= 2; i++) {
                    const li = document.createElement('li');
                    const a = document.createElement('a');
                    switch(i) {
                        case 1:
                            a.textContent = 'App design';
                            a.setAttribute('href', 'javascript:;');
                            break;
                        case 2:
                            a.textContent = 'Development';
                            a.setAttribute('href', 'javascript:;');
                            break;
                        default:
                            print('You are not suppose to be here!');
                    }
                    // append link to the list
                    li.append(a);
                    // append lists to the unordered list
                    ul.append(li);
                }
                // append header and undordered list to the item
                item.append(header, ul);
                break;

            // About links
            case 2:
                item.classList.add('col-sm-6', 'col-md-3', 'item');
                header.textContent = 'About';
                // create sub-links inside an item
                for(let i = 1; i <= 2; i++) {
                    const li = document.createElement('li');
                    const a = document.createElement('a');
                    switch(i) {
                        case 1:
                            a.textContent = 'Company';
                            a.setAttribute('href', '/contact');
                            break;
                        case 2:
                            a.textContent = 'Team';
                            a.setAttribute('href', '/about');
                            break;
                        default:
                            print('You are not suppose to be here!');
                    }
                    // append link to the list
                    li.append(a);
                    // append lists to the unordered list
                    ul.append(li);
                }
                // append header and undordered list to the item
                item.append(header, ul);
                break;
            // Our company
            case 3:
                item.classList.add('col-md-3', 'item', 'text');
                header.textContent = 'Overdose Software';

                // create an address paragraph
                const paragraph = document.createElement('p');
                paragraph.textContent = 'Witsawawatthana Building (10th floor), Bangmod Subdistrict, Thung Khru District, Bangkok 10140';

                item.append(header, paragraph);
                break;

            // Our social media
            case 4:
                item.classList.add('col', 'item', 'social');
                item.style.marginTop = '20px';

                for(let x = 1; x <= 4; x++) {
                    const a = document.createElement('a');
                    const i = document.createElement('i');
                    i.style.padding = '1px';
                    switch(x) {
                        case 1:
                            a.setAttribute('href', 'https://www.facebook.com/KMUTT/');
                            i.classList.add('icon', 'ion-social-facebook');
                            break;
                        case 2:
                            a.setAttribute('href', 'javascript:;');
                            i.classList.add('icon', 'ion-social-twitter');
                            break;
                        case 3:
                            a.setAttribute('href', 'javascript:;');
                            i.classList.add('icon', 'ion-social-snapchat');
                            break;
                        case 4:
                            a.setAttribute('href', 'https://www.instagram.com/love.kmutt/');
                            i.classList.add('icon', 'ion-social-instagram');
                            break;
                        default:
                            print('You are not suppose to be here!');
                    }
                    // append icon to the link
                    a.append(i);
                    // append link to the item
                    item.append(a);
                }
                break;
            default:
                print('You are not suppose to reach here!');
        }
        // append item to the row
        row.append(item);
    }

    // create a copyright paragraph
    const copyright = document.createElement('p');
    copyright.classList.add('copyright');
    copyright.textContent = 'Overdose Software | MIT LICENSE ©2022';

    // append a row and a copyright paragraph to the container
    container.append(row, copyright);
    // append the container to the html
    document.body.append(footer);
})();

export default footer;