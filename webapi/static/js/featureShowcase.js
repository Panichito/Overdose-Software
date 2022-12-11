const featureShowcase = (featureImg1, featureTxt1, featureImg2, featureTxt2, featureImg3, featureTxt3, featureImg4, featureTxt4) => {
    const featureShowcaseSection = document.querySelector('.ex-col');
    const container = document.createElement('div');
    container.classList.add('ex-row');

    const leftSide = document.createElement('div');
    leftSide.classList.add('left-col');
    const rightSide = document.createElement('div');
    rightSide.classList.add('right-col');

    // add features to both side
    for(let i = 1; i <= 4; i++) {
        const block = document.createElement('div');
        block.classList.add('block');
        const blockImg = document.createElement('img');
        blockImg.classList.add('block-img');
        const blockTxt = document.createElement('div');
        blockTxt.classList.add('block-txt');

        switch(i) {
            case 1:
                blockImg.setAttribute('src', featureImg1);
                blockTxt.textContent = featureTxt1;
                break;
            case 2:
                blockImg.setAttribute('src', featureImg2);
                blockTxt.textContent = featureTxt2;
                break;
            case 3:
                blockImg.setAttribute('src', featureImg3);
                blockTxt.textContent = featureTxt3;
                break;
            case 4:
                blockImg.setAttribute('src', featureImg4);
                blockTxt.textContent = featureTxt4;
                break;   
            default:
                print('You are not suppose to be here!');
        }
        // Add a feature to left side
        if (i <= 2) {
            block.append(blockImg, blockTxt);
            leftSide.append(block)
        }
        // Add a feature to right side
        else {
            block.append(blockImg, blockTxt);
            rightSide.append(block)
        }
    }
    container.append(leftSide, rightSide);
    // clone container for making animation
    const secondContainer = container.cloneNode(true);
    secondContainer.classList.add('second');
    featureShowcaseSection.append(container, secondContainer); 
};

export default featureShowcase;