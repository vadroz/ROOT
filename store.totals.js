//Functions for basic AJAX web app.
function callAPI(type,url,callback){
	// AJAX function to call proxy
	var proxy = 'http://www.sunandskipatio.com/dev/api/fluidsurveys/proxy.php?method=';

	var j = $.ajax({
		beforeSend: function(xhr){
			xhr.setRequestHeader('Content-Type', 'application/json');
		},
		url: proxy+url,
		type: type,
		success: function(data){
			//API returns JSON - parse the data and pass it to callback
			callback(JSON.parse(data));
		},
		error: function(event, jqXHR, ajaxSettings, thrownError){
			console.log(event, jqXHR, ajaxSettings, thrownError);
		}
	});		
}


SURVEYS = {};
RESPONSES = [];
base = 'https://app.fluidsurveys.com/api/v2';
var date_range = "";

function getData(){		
	
	//List of all survey IDs for each store
	var surveys = ["175781","173702","173701","173700","173699","173698","173697","173696","173695","173694","173693","173691","173690","173689","173688","173687","173686","173685","173684","173683","173682","173681","173679","173678","173677","173676","173675","173674","173673","173672"];
	
	$.each(surveys,function(k,survey){
		
		callAPI('GET',base+'/surveys/'+surveys[k]+'/responses/?_completed=1'+date_range, function(data){
			
			//Add each of the responses to the responses list.
			RESPONSES = [];
			$.each(data.responses,function(i,response){
				re = [];
				$.each(response,function(key,value){
					if(key.lastIndexOf('_', 0) === 0){
						//This is a property of the response, ignore for now.
					}
					else{
						//console.log(key,value);
						re.push({id:key,'value':value});
					}						
				});
				RESPONSES.push(re);
			});
			
			//Get survey responses
			if (RESPONSES) {
				var markup = "", numItems = RESPONSES.length;
				
				var q1_total = 0;
				var q2_total = 0;
				var q3_total = 0;
				
				// Generate a list for each response.  
				for ( var i = 0; i < numItems; i++ ) {
					
					var questions = RESPONSES[i].length;
					
					//Generate a list item for each answer in the response. 
					for (var j = 0; j < questions; j++){
						
						//Set values for specified questions
						if(RESPONSES[i][j].id == "VukKHzUGua_0"){
							var q1_value = +RESPONSES[i][j].value;
							q1_total += q1_value;
						}
						
						else if(RESPONSES[i][j].id == "VukKHzUGua_1"){
							var q2_value = +RESPONSES[i][j].value;
							q2_total += q2_value;
						}
						
						else if(RESPONSES[i][j].id == "VukKHzUGua_3"){
							var q3_value = +RESPONSES[i][j].value;
							q3_total += q3_value;
						}
						
						else {

						}
					}
				}
				
				// Average out response values
				q1_avg = q1_total / i;
				q2_avg = q2_total / i;
				q3_avg = q3_total / i;
				
				//Average out totals for three question totals
				q_tot = ((q1_avg + q2_avg + q3_avg) / 3);
				q_tot = q_tot.toPrecision(3);
				
				var containr = "#s_"+surveys[k]+" span";
				
				markup = "<p>Score: "+q_tot+"</p>";
				$(containr).html(markup);
			}
		});
	});
}

$(function() {
	$( "#from" ).datepicker({
		defaultDate: "+1w",
		dateFormat: 'yy-mm-dd',
		changeMonth: true,
		numberOfMonths: 3,
		onClose: function( selectedDate ) {
			$("#to").datepicker("option", "minDate", selectedDate);
		}
	});
	
	$( "#to" ).datepicker({
		defaultDate: "+1w",
		dateFormat: 'yy-mm-dd',
		changeMonth: true,
		numberOfMonths: 3,
		onClose: function( selectedDate ) {
			$("#from").datepicker("option", "maxDate", selectedDate);
		}
	});
});


$(".submit_date").click(function(){
	date_range = "%26_created_at%3E"+$("#from").val()+"%26_created_at%3C"+$("#to").val();
	getData();
});


$(document).ready(function(){
	getData();
});


