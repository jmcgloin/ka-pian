let card = document.getElementById("card");
let checkmark = document.getElementById("checkmark");
let bigX = document.getElementById("big-x");
let answer = document.getElementById("answer");
let submit = document.getElementById("submit");
let next = document.getElementById("next");
let front = document.getElementById("front");
let question = document.getElementById("question");
let correctAnswer = document.getElementById("correct-answer");
let cards = [];
let card_index = 0;

document.addEventListener('DOMContentLoaded', event => {

	if(question) {
		answer.addEventListener("keydown", e => {
			if(e.keyCode == 13 ) {
				// e.preventDefault();
				flipCard();
			}
	});
		getCards();	
	}

});

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
	if(card_index == 0) {
		answer.focus();
		updateCard(0);
		card_index++;
	} else if (card_index >= cards.length) {
		let redirect_url = `/decks/${cards[0].deckId}`
		window.location = redirect_url
		// probably show a completed view with option to do it again or end
	} else {
		updateCard(card_index)
		card.classList.toggle("is-flipped");
		bigX.style.visibility = "hidden";
		checkmark.style.visibility = "hidden";
		submit.disabled = false;
		next.disabled = true;
		answer.value = "";
		answer.focus();
		card_index++;
	}
}

let updateCard = (i) => {
	thiscard = cards[i];
		front.innerHTML = cards[i].front;
		question.innerHTML = cards[i].front;
		correctAnswer.innerHTML = cards[i].back;
}

let getCards = () => {
	fetch("/decks/cards")
    	.then(response => response.json())
    	.then(data => {
    		data.forEach((card) => {
    			cards.push({front: card.front, back: card.back, id: card.id, frequency: card.frequency, deckId: card.deck_id})
    		});
    	nextCard();
    });
};

