console.debug(window.location.href);
document.getElementById("gameplay").style.visibility = "hidden";
document.getElementById("webgl-canvas").style.visibility = "visible";

xhr = new XMLHttpRequest(),
    method = "GET",
    url = "http://localhost:3000/games/download_loader";

xhr.open(method, url, true);
xhr.onreadystatechange = function () {
  // In local files, status is 0 upon success in Mozilla Firefox
  if(xhr.readyState === XMLHttpRequest.DONE) {
    var status = xhr.status;
    if (status === 0 || (status >= 200 && status < 400)) {
      // The request has been completed successfully
      var script = document.createElement("script");
      script.type = "text/javascript";
      script.text = xhr.responseText;
      document.body.appendChild(script);
      window.unityInstance = UnityLoader.instantiate("unityContainer", 'DebugBuild.json', {onProgress: UnityProgress});
    } else {
      alert("There has been an error with the request!");
    }
  }
};
xhr.send();

window.addEventListener('beforeunload',function(evt){
  // evt.returnValue = false;
  if(window.unityInstance != undefined) {
      // Gracefully quit unity
      unityInstance.Quit(function() {
	  console.log("done!");
      });
      unityInstance = null;
      
      // Delete cookies
      document.cookie = "game=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
  }
  // return 'Something happens';
});
