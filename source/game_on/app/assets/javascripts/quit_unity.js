function quitUnity(e){
    console.debug(":(");
    unityInstance.Quit(function() {
	console.log("done!");
    });
    unityInstance = null;
}
