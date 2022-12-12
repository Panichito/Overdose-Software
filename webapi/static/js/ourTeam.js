// append footer and navBar to the html
import footer from "./footer.js";
import navBar from "./navbar.js";
import memberProfile from "./memberProfile.js";

let memberName1 = 'Panithi S.';
let memberRole1 = 'Chief Executive Officer';
let memberInfo1 = 'ZEN Apprentice | Stay calm no panic';
let memberImg1 = big;
let facebookLink1 = 'https://www.facebook.com/panithi.suwanno';
let twitterLink1 = 'https://github.com/Panichito';
let linkedinLink1 = 'https://www.linkedin.com/in/panithi-suwanno-89171a1a3/';

let memberName2 = 'Kantawat S.';
let memberRole2 = 'Chief Technology Officer';
let memberInfo2 = 'Frontend Developer';
let memberImg2 = map;
let facebookLink2 = 'https://www.facebook.com/map.kantawat';
let twitterLink2 = 'https://github.com/Miran-Mirantee';
let linkedinLink2 = 'javascript:;';

let memberName3 = 'Poonyavee W.';
let memberRole3 = 'Chief Data Officer';
let memberInfo3 = 'Frontend Developer | UX UI Designer';
let memberImg3 = pup;
let facebookLink3 = 'https://www.facebook.com/poonyavee.wongwisetsuk';
let twitterLink3 = 'https://github.com/pupshi';
let linkedinLink3 = 'https://www.linkedin.com/in/poonyavee-wongwisetsuk-9a0197253/';

let memberName4 = 'Phoramint C.';
let memberRole4 = 'Chief Marketing Officer ';
let memberInfo4 = 'Quality Assurance | Web Master';
let memberImg4 = min;
let facebookLink4 = 'https://www.facebook.com/profile.php?id=100007113468193';
let twitterLink4 = 'https://github.com/PhoramintTaweeros';
let linkedinLink4 = 'javascript:;';

let memberName5 = 'Pornsawalee K.';
let memberRole5 = 'Chief Operating Officer';
let memberInfo5 = 'Backend Developer | Web Master';
let memberImg5 = gus;
let facebookLink5 = 'https://www.facebook.com/pornsawalee.kanjanatiti.7';
let twitterLink5 = 'https://github.com/sugus-ss';
let linkedinLink5 = 'javascript:;';

// append each of the member's profile to the html
const member1 = memberProfile(memberName1, memberRole1, memberInfo1, memberImg1, facebookLink1, twitterLink1, linkedinLink1);
const member2 = memberProfile(memberName2, memberRole2, memberInfo2, memberImg2, facebookLink2, twitterLink2, linkedinLink2);
const member3 = memberProfile(memberName3, memberRole3, memberInfo3, memberImg3, facebookLink3, twitterLink3, linkedinLink3);
const member4 = memberProfile(memberName4, memberRole4, memberInfo4, memberImg4, facebookLink4, twitterLink4, linkedinLink4);
const member5 = memberProfile(memberName5, memberRole5, memberInfo5, memberImg5, facebookLink5, twitterLink5, linkedinLink5);