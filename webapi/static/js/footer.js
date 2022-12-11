const footer = (() => {
    // create a footer
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
                    li.append(a);
                    ul.append(li);
                }
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
                            a.setAttribute('href', 'javascript:;');
                            break;
                        case 2:
                            a.textContent = 'Team';
                            a.setAttribute('href', 'javascript:;');
                            break;
                        default:
                            print('You are not suppose to be here!');
                    }
                    li.append(a);
                    ul.append(li);
                }
                item.append(header, ul);
                break;
            // Our company
            case 3:
                item.classList.add('col-md-3', 'item', 'text');
                header.textContent = 'Overdose company';

                // create an address paragraph
                const paragraph = document.createElement('p');
                paragraph.textContent = 'อาคารวิศววัฒนะ (Witsawawatthana Building) แขวงบางมด เขตทุ่งครุ กรุงเทพมหานคร 10140';

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
                            a.setAttribute('href', 'javascript:;');
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
                            a.setAttribute('href', 'javascript:;');
                            i.classList.add('icon', 'ion-social-instagram');
                            break;
                        default:
                            print('You are not suppose to be here!');
                    }
                    a.append(i);
                    item.append(a);
                }
                break;
            default:
                print('You are not suppose to reach here!');
        }
        row.append(item);
    }

    // create a copyright paragraph
    const copyright = document.createElement('p');
    copyright.classList.add('copyright');
    copyright.textContent = 'Overdose © 2022';

    container.append(row, copyright);
    document.body.append(footer);
})();

export default footer;