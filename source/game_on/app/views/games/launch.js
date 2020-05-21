function adjustView() {
    document.getElementById("play_game").style.visibility = "hidden";
    window.scrollTo(0,document.body.scrollHeight);
}

function downloadLoader() {
    xhr = new XMLHttpRequest(),
    method = "GET",
    url = "http://localhost:3000/games/download_loader";

    xhr.open(method, url, true);
    xhr.onreadystatechange = function () {
	if(xhr.readyState === XMLHttpRequest.DONE) {
	    var status = xhr.status;
	    if (status === 0 || (status >= 200 && status < 400)) {
		// The request has been completed successfully
		var script = document.createElement("script");
		script.type = "text/javascript";
		script.text = xhr.responseText;
		document.body.appendChild(script);
		var container = document.getElementById("unityContainer");
		window.unityInstance = UnityLoader.instantiate(container, 'gameplay.json', {onProgress: UnityProgress});
	    } else {
		alert("There has been an error with the request!");
	    }
	}
    };
    xhr.send();
}

function launchGame() {
    adjustView();
    downloadLoader();
    window.addEventListener('beforeunload',function(evt){
	// evt.returnValue = false;
	if(window.unityInstance != undefined) {
	    // Gracefully quit unity
	    unityInstance.Quit(function() {
		console.log("done!");
	    });
	    unityInstance = null;
	    
	    // Delete cookie
	    document.cookie = "game=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
	}
	// return 'Something happens';
    });
}

launchGame();
