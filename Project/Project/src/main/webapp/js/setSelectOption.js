var startplace = $("#startplace")
var finishplace = $("#finishplace")
var number = $("#number").val()

var now = new Date();

var day = ("0" + (now.getDate()+1)).slice(-2);
var month = ("0" + (now.getMonth() + 1)).slice(-2);

var today = now.getFullYear()+"-"+(month)+"-"+(day) ;
var minday=now.getFullYear()+"-"+(month)+"-"+(day) ;
$('#myDate').val(today);
$('#myDate').attr({"min" : minday});

$("#typeBus").val($('#Cb_ChuyenXe option:selected').data('type-bus'));

$("#Cb_ChuyenXe").change(

function() {
	$("#typeBus").val($('#Cb_ChuyenXe option:selected').data('type-bus'));
});

$('select[name="schedule_id"]').val(number);


//get reference to element containing toppings checkboxes
var el = document.getElementById('div_chart');

// get reference to input elements in toppings container element
var tops = el.getElementsByTagName('input');

// assign function to onclick property of each checkbox
for (var i=0, len=tops.length; i<len; i++) {
    if ( tops[i].type === 'checkbox' ) {
        tops[i].onclick = function() {
        	document.getElementById("finishbookseat").style.display = "block";
        	document.getElementById("finishbookseat1").style.display = "none";
        }
    }
}