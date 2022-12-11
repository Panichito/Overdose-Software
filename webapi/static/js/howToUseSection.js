const howToUse = (style, img, headerTxt, paragrahTxt) => {
    const container = document.createElement('div');

    const box = document.createElement('div');
    box.classList.add('box');
    
    const image = document.createElement('img');
    image.classList.add('app-image');
    image.setAttribute('src', img);
    
    const textColumn = document.createElement('div');
    textColumn.classList.add('column');

    const header = document.createElement('h2');
    header.textContent = headerTxt;

    const paragraph = document.createElement('p');
    paragraph.classList.add('text-page');
    paragraph.textContent = paragrahTxt;

    textColumn.append(header, paragraph);
    // choosing style
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
    container.append(box);

    const section = document.querySelector('.how-to-use');
    section.append(container);
};

export default howToUse;