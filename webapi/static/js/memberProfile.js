/* memberProfile factory function
 is a function that create a member displaying card on html
 name         -   name of the member
 role         -   role of the member
 info         -   information of the member
 img          -   image of the member
 facebook     -   link of facebook profile of the member
 twitter      -   link of twitter profile of the member
 linkedin     -   link of linkedin profile of the member */
const memberProfile = (name, role, info, img, facebook, github, linkedin) => {
    // select where to append the profile to
    const profileRow = document.querySelector('.profile-row');
    // create a profile container
    const profile = document.createElement('div');
    profile.classList.add('col-md-3', 'profile', 'text-center');
    
    // create a member image section
    const imgSection = document.createElement('div');
    imgSection.classList.add('img-box');
    // create a member image
    const memberImg = document.createElement('img');
    memberImg.classList.add('img-responsive');
    memberImg.setAttribute('src', img);
    // create a list of social links
    const socialLinks = document.createElement('ul');
    // create individual link in list(socialLinks)
    for(let i = 1; i <= 3; i++) {
        const socialLinkItem = document.createElement('li');
        const socialLink = document.createElement('a');
        const socialIcon = document.createElement('i');
        switch(i) {
            case 1:
                socialIcon.classList.add('fa', 'fa-facebook');
                socialLink.setAttribute('href', facebook);
                break;
            case 2:
                socialIcon.classList.add('fa', 'fa-github');
                socialLink.setAttribute('href', github);
                break;
            case 3:
                socialIcon.classList.add('fa', 'fa-linkedin');
                socialLink.setAttribute('href', linkedin);
                break;
            default:
                print('You are not suppose to reach here!');
        }
        // append the icon to the individual list
        socialLinkItem.append(socialIcon);
        // append the list to the link
        socialLink.append(socialLinkItem);
        // append the link to a list of links
        socialLinks.append(socialLink);
    }

    // create a member name
    const memberName = document.createElement('h2');
    memberName.textContent = name;
    // create a member role
    const memberRole = document.createElement('h3');
    memberRole.textContent = role;
    // create a member information
    const memberInfo = document.createElement('p');
    memberInfo.textContent = info;

    // append image and a list of social links to the image section
    imgSection.append(memberImg, socialLinks);
    // append image section, member name, member role, and member information to the profile container
    profile.append(imgSection, memberName, memberRole, memberInfo);
    // append profile container to the html
    profileRow.append(profile);
};