
let cards = [{front : 'I' , back : '我'}, {front : 'You' , back : '你'}];
let flashcard = document.getElementById("flashcard");
let answer = document.getElementById("answer");
let card_index = 0;
let beginButton = document.getElementById('begin');
let checkButton = document.getElementById('check');

let study = () => {
	checkButton.disabled = false;
	flashcard.innerHTML = cards[card_index].front;
}

let checkAnswer = () => {
	// flashcard.innerHTML = answer.value == cards[card_index].back ? "Correct" : "Incorrect";
	flashcard.innerHTML = cards[card_index].back;
	setTimeout(nextCard, 2000);
}

let nextCard = () => {
	card_index++;
	if (card_index == cards.length) {
		checkButton.disabled = true;
		beginButton.innerHTML = 'Again?';
		card_index = 0;
	}
	answer.value = ''
	flashcard.innerHTML = cards[card_index].front
}