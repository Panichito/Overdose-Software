const memberProfile = (name, role, info, img, facebook, github, linkedin) => {
    const profileRow = document.querySelector('.profile-row');
    const profile = document.createElement('div');
    profile.classList.add('col-md-3', 'profile', 'text-center');
    
    // member image section
    const imgSection = document.createElement('div');
    imgSection.classList.add('img-box');
    // member image
    const memberImg = document.createElement('img');
    memberImg.classList.add('img-responsive');
    memberImg.setAttribute('src', img);
    // list of social links
    const socialLinks = document.createElement('ul');
    // create individual link in socialLinks
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
        socialLinkItem.append(socialIcon);
        socialLink.append(socialLinkItem);
        socialLinks.append(socialLink);
    }

    const memberName = document.createElement('h2');
    memberName.textContent = name;
    const memberRole = document.createElement('h3');
    memberRole.textContent = role;
    const memberInfo = document.createElement('p');
    memberInfo.textContent = info;

    imgSection.append(memberImg, socialLinks);
    profile.append(imgSection, memberName, memberRole, memberInfo);
    profileRow.append(profile);
};

export default memberProfile;