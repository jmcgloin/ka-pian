let card = document.getElementById("card");
let checkmark = document.getElementById("checkmark");
let bigX = document.getElementById("big-x");
let answer = document.getElementById("answer");
let submit = document.getElementById("submit");
let next = document.getElementById("next");
let correctAnswer = document.getElementById("correct-answer");

let flipCard = () => {
	if(!card.classList.contains("is-flipped")){
		submit.disabled = true;
		card.classList.toggle("is-flipped");
		next.disabled = false;
		checkAnswer();
	}
}

let checkAnswer = () => {
	event.preventDefault();
	if(answer.value == correctAnswer.innerHTML.trim() && card.classList.contains("is-flipped")) {
		checkmark.style.visibility = "visible";
	} else if( card.classList.contains("is-flipped")) {
		bigX.style.visibility =  "visible";
	}
	next.focus();
}

let nextCard = () => {
	// check if you're at the last card
	//if so, do something about it
	if(false) {
		//this will be where i check for no more cards
	} else {
		//if there are more cards
		card.classList.toggle("is-flipped");
		bigX.style.visibility = "hidden";
		checkmark.style.visibility = "hidden";
		submit.disabled = false;
		next.disabled = true;
		answer.value = "";
		answer.focus();
		//load the answer into back.innerHTML
	}
}

answer.onkeydown = (e) => {
	if(e.keyCode == 13 ) {
		e.preventDefault();
		flipCard();
	}
}

getCards = () => {
	getAjax('/decks/cards', (data) => { alert(data) })
}

getAjax = (url, success) => {
    var xhr = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject('Microsoft.XMLHTTP');
    xhr.open('GET', url);
    xhr.onreadystatechange = function() {
        if (xhr.readyState>3 && xhr.status==200) {
        	success(xhr.responseText);
        } else {
        	alert(xhr.status)
        }
    };
    xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
    xhr.send();
    return xhr;
}