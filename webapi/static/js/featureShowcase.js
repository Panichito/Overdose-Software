/* 
featureShowcase factory function
is a function that create a showcase of our application's features on html
  featureImg1  -   image of feature#1
  featureTxt1  -   text to explain feature#1
  featureImg2  -   image of feature#2
  featureTxt2  -   text to explain feature#2
  featureImg3  -   image of feature#3
  featureTxt3  -   text to explain feature#3
  featureImg4  -   image of feature#4
  featureTxt4  -   text to explain feature#4 
*/
const featureShowcase = (featureImg1, featureTxt1, featureImg2, featureTxt2, featureImg3, featureTxt3, featureImg4, featureTxt4) => {
    // select where to append featureShowcase to
    const featureShowcaseSection = document.querySelector('.ex-col');
    // create a container
    const container = document.createElement('div');
    container.classList.add('ex-row');

    // create a left side of the container
    const leftSide = document.createElement('div');
    leftSide.classList.add('left-col');
    // create a right side of the container
    const rightSide = document.createElement('div');
    rightSide.classList.add('right-col');

    // create features to show on both side
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
        // add a feature to left side
        if (i <= 2) {
            block.append(blockImg, blockTxt);
            leftSide.append(block)
        }
        // add a feature to right side
        else {
            block.append(blockImg, blockTxt);
            rightSide.append(block)
        }
    }
    // append left-side and right-side to the container
    container.append(leftSide, rightSide);
    // clone container for making animation
    const secondContainer = container.cloneNode(true);
    secondContainer.classList.add('second');
    // append original container for showcase and clone container for animation to the html
    featureShowcaseSection.append(container, secondContainer); 
};

export default featureShowcase;