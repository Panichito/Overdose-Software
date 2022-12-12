/* howToUse factory function
 is a function that create a how-to-use section inside the html
 style        -   choose which style to apply on, 1 is 'main-content' or 2 is 'main-content', 'second'
 img          -   image to display in this section
 headerTxt    -   header text to display in this section
 paragraphTxt -   paragraph text to display in this section 
 */
const howToUse = (style, img, headerTxt, paragrahTxt) => {
    // create a container
    const container = document.createElement('div');

    const box = document.createElement('div');
    box.classList.add('box');
    
    // create an image to display 
    const image = document.createElement('img');
    image.classList.add('app-image');
    image.setAttribute('src', img);
    
    // create a column to attach information
    const textColumn = document.createElement('div');
    textColumn.classList.add('column');

    // create a header of this section
    const header = document.createElement('h2');
    header.textContent = headerTxt;

    // create a paragraph of this section
    const paragraph = document.createElement('p');
    paragraph.classList.add('text-page');
    paragraph.textContent = paragrahTxt;

    // append a header and a paragraph to the column
    textColumn.append(header, paragraph);
    
    // choose which style to apply on this section
    switch(style) {
        case 1:
            container.classList.add('main-content');
            box.append(textColumn, image);
            break;
        case 2:
            container.classList.add('main-content','second');
            box.append(image, textColumn);
            break;
        default:
            print('You are not suppose to reach here!');
    }
    // append sub-container to the container
    container.append(box);

    // select where to append the howToUse section to
    const section = document.querySelector('.how-to-use');
    // append howToUse section to the html
    section.append(container);
};

export default howToUse;