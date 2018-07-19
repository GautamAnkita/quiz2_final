$(document).ready(function(){

    // var coll = document.getElementsByClassName("collapsible");
    // coll.addEventListener("click", function() {
    //     var check = this.classList.toggle("active");
    //     console.log(check);
    //     // var content = this.nextElementSibling;
    //     var content = document.getElementsByClassName("content");
    //     if (content.style.maxHeight){
    //       content.style.maxHeight = null;
    //     } else {
    //       content.style.maxHeight = content.scrollHeight + "px";
    //     } 
    //   });

    var coll = document.getElementsByClassName("collapsible");
    var i;
    
    for (i = 0; i < coll.length; i++) {
      coll[i].addEventListener("click", function() {
        this.classList.toggle("active");
        var content = this.nextElementSibling;
        if (content.style.maxHeight){
          content.style.maxHeight = null;
        } else {
          content.style.maxHeight = content.scrollHeight + "px";
        } 
      });
    }


});
