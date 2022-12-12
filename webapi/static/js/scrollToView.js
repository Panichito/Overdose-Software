// scrollIntoView factory function
// is a function that scroll the page to a specific point of the page
const scrollIntoView = (() => {
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener("click", function(e){
            e.preventDefault();
            document.querySelector(this.getAttribute("href")).scrollIntoView({
                behavior : "smooth"
            });
        });
    });    
})();

export default scrollIntoView;
