let flash = document.getElementById('flash');
let xButton = document.getElementById('x-button') || false;

if (!!xButton) {
	xButton.addEventListener("click", e => {
		flash.style.visibility = "hidden";
		
	});
}