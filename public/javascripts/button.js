let flash = document.getElementById('flash');
let xButton = document.getElementById('x-button') || nil;

if (!!xButton) {
	xButton.addEventListener("click", e => {
		flash.style.visibility = "hidden";
		
	});
}

//look into attaching to something that does exist  to preven not exist error
