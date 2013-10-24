function info(title,content){
    $("#sample-popup").remove();
    var tag="<div id='sample-popup' class='popuplayout addNewPop dn' style='padding:0'>";
    tag+="<div class='popuptitle'><img src='/images/icons/warning_black.png' width=16>&nbsp;"
    tag+= title+"<span class='close-icon bClose fr'>x</span>";
    tag+="<div class='cl'></div></div>";
    tag+="<div class='popupc' style='font-size:12px'>"+content+"<div><br/>";
    tag+="<span class='popupok fr bClose' align='center'>OK</span><div class='cl'></div></div></div></div>"
    $("body").append(tag);
    showPopUp('sample-popup');
}
