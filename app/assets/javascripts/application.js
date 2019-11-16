// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require_tree .

function Comma(pay) {
    var result = Number(pay.replace(/[^0-9]/g,''));
    result = result.toLocaleString();
    return result;
}

function RemoveComma(pay) {
    var result = pay;
    result = pay.replace(/,/gi, "");
    return result;
}

function eventToast(theme, msg) {
    var toast = new ax5.ui.toast();
    toast.setConfig({
        icon: '<i class="fa fa-bell"></i>',
        containerPosition: "top-right",
        closeIcon: '<i class="fa fa-times"></i>'
    });
    
    toast.push({
        theme: theme,
        msg: msg
    });
}

function myFunction() {
  var person = prompt("아직 개발중입니다. 비밀번호를 입력해주세요.", "");

  if (person == 'wjdvy95') {
    document.getElementsByClassName("intro")[0].style.display = "none";
    document.getElementsByClassName("original")[0].style.display = "block";
    
  }else{
    document.getElementsByClassName("intro")[0].style.display = "block";
    document.getElementsByClassName("original")[0].style.display = "none";
  }
}
