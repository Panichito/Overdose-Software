import footer from "./footer.js";
import navBar from "./navbar.js";
import scrollIntoView from "./scrollToView.js";
import howToUse from "./howToUseSection.js";
import featureShowcase from "./featureShowcase.js";

//let howToUseImg1 = "./img/home_app.jpg";
let howToUseImg1 = home_app;
let howToUseHeader1 = "Home page";
let howToUsePara1 = "Display your profile page where the tools can be customized according to your role in the system. Use it to get an overview of your work schedule, whether it's the time or the details of your daily logs. You can customize the buttons according to your role in the system.";
let howToUseImg2 = findCare_app;
let howToUseHeader2 = "Find Available Caretaker Page";
let howToUsePara2 = "In case you need help or need someone to take care of scheduling your medications, organizing your medication packs, following up on your health reports, and so on. You can find your assistants from this menu and can view their profiles to help you make decisions.";
let howToUseImg3 = medicine_app;
let howToUseHeader3 = "All Medicine Page";
let howToUsePara3 = "You may have wondered if with each dose, what kind of drug you are taking or if it is reliable or not. This support system was created to meet the needs of users who want reliability in medicine. You can search for the drug you want to know in detail, just enter the drug name in the menu, the system will display the drug with the name related to the drug name you searched for. That's all, you can know all the drug details and trust in the safety of the drug that you run out.";
let howToUseImg4 = patient_app;
let howToUseHeader4 = "My Patients Page";
let howToUsePara4 = "If you are a caregiver, you may face a problem where you are unable to remember the details of each patient due to the large number and variety of patients. You may have to carry a lot of documents to look through which wastes time and resources on printing documents. This system has put your patient information into the application, if you want to know the details of any patient, you can enter your patient name in the system. The system displays the patient details you want to know instantly, saving time and resources spent printing paperwork.";

let featureImg1 = Chart;
let featureTxt1 = 'Chart and Reports';
let featureImg2 = red_alarm;
let featureTxt2 = 'Alarm in Application';
let featureImg3 = medicine;
let featureTxt3 = 'Filter Medicine';
let featureImg4 = health;
let featureTxt4 = 'Sensor check health';

const howToUseSection1 = howToUse(1, howToUseImg1, howToUseHeader1, howToUsePara1);
const howToUseSection2 = howToUse(2, howToUseImg2, howToUseHeader2, howToUsePara2);
const howToUseSection3 = howToUse(1, howToUseImg3, howToUseHeader3, howToUsePara3);
const howToUseSection4 = howToUse(2, howToUseImg4, howToUseHeader4, howToUsePara4);

const featureShowcase1 = featureShowcase(featureImg1, featureTxt1, featureImg2, featureTxt2, featureImg3, featureTxt3, featureImg4, featureTxt4);


