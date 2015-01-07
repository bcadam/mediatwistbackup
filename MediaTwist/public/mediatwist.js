/*************************************************************************
 * 
 * Rooftop Dev
 * __________________
 * 
 *  2014-2015
 *  All Rights Reserved.
 * 
 *  NOTICE:  All information contained herein is, and remains
 *  the property of Rooftop Dev and its suppliers,
 *  if any.  The intellectual and technical concepts contained
 *  herein are proprietary to Rooftop Dev and its suppliers and may 
 *  be covered by U.S. and Foreign Patents,
 *  patents in process, and are protected by trade secret or copyright law.
 *  Dissemination of this information or reproduction of this material
 *  is strictly forbidden unless prior written permission is obtained
 *  from Rooftop Dev.
 */


/// load in the two libraries necessary for this to work
loadScript("https://cdn.jsdelivr.net/parse/1.2.9/parse.min.js", function(){

/// create the parse connection to get the info about the site
Parse.initialize("eDMdMhqERrdc0eN16XJ5mZ5Iq0iTmk4URQrNJVaX", "Ap331XrGb0AyMT4FzysCJXWoTkkXXvTLNQYDPBsh");

// look for the clues in the url. This will only match imags whose tags match perfectly
if (document.referrer)
{
    lookingForArray = processURL(document.referrer);
} else
{
    lookingForArray = processURL(window.location.href);
}

//get all the images in the document included multipe data points
var imagesonCurrentPage = document.images;

//var test = document.images.length;
//alert(test);

//all of the assets that have been associated with the site
var arraySiteAssets = new Array();

//array of url of images on current page
//var arrayofImagesUrls = new String();

//var matchingSite = new Object();
//var matchingBassets = new Object();
//var matchingTargets = new Object();

var TempSite = Parse.Object.extend("Site");
var TempTarget = Parse.Object.extend("Target");
var TempBassets = Parse.Object.extend("Basset");

var querySite = new Parse.Query(TempSite);
var queryTargets = new Parse.Query(TempTarget);
var queryBassets = new Parse.Query(TempBassets);

//all of the urls combined on the Targets that match the current site
//var combinedTargetUrls = new Array();

//querySite.limit(1);
//queryTargets.limit(50);
//queryBassets.limit(50);

//var windowurl = window.location.protocol + "//" + window.location.host + window.location.pathname;
var windowurl = window.location.protocol + "//" + window.location.host; 
//alert(windowurl);

querySite.equalTo("url", windowurl);
querySite.find(function(results) {

          matchingSite = results[0];
          arraySiteAssets = matchingSite.get("siteassets");
       
          }).then(function(){

            queryBassets.equalTo("siteid", matchingSite.id);
            queryBassets.equalTo("published", true);
            queryBassets.find(function(results) {
            matchingBassets = results;
            //remove unmatched bassets based on refferring info
            for (var i=0, counter=matchingBassets.length; i<counter; i++)
                {
                    
                    if ( intersect( matchingBassets[i].get("tags") , lookingForArray ).length < 1)
                    {
                       matchingBassets.remove(i);
                       i = i - 1;
                    }

                }


            /** should check to see if any of the tags matches before subing in the new ones**/
            });

        }).then(function(){

            queryTargets.equalTo("siteid", matchingSite.id );
            queryTargets.equalTo("published", true);
            queryTargets.find(function(results)
            {

                matchingTargets = results;
                // go through every image on the current page and check if it is a target
                // if it is then replace the target with a Basset
                for (var i=0, iLen=imagesonCurrentPage.length; i<iLen+1; i++) 
                {

                    for (var x=0, xLen=matchingTargets.length; x<xLen; x++) 
                    {
                            //if( combinedTargetUrls.contains(imagesonCurrentPage[i].src) )



                            if( matchingTargets[x].get("url") == imagesonCurrentPage[i].src )
                            {
                                var matchedPic = matchingBassets[i].get("image");
                                imagesonCurrentPage[i].src = matchedPic.url();
                                //alert(matchingTargets[x].get("height"));
                                var holderHeight = imagesonCurrentPage[i].height;
                                var holderWidth = imagesonCurrentPage[i].width;
                                //alert(holder);
                                //alert(holder);
                                //alert(imagesonCurrentPage[i].style.height);
                                imagesonCurrentPage[i].style.height = matchingTargets[x].get("height") + "px";
                                imagesonCurrentPage[i].style.width = matchingTargets[x].get("width") + "px";
                                //alert(imagesonCurrentPage[i].height);
                                //imagesonCurrentPage[i].style.width = "458px";
                                //imagesonCurrentPage[i].style.border = "5px dotted black";
                            }


                    }

                    
        
                }

              });


        //end of then function
        });


    //end of load function method that calls parse
    });

function processURL(variable)
{       
        variable = variable.replace(window.location.protocol + "//" + window.location.host, "")
        variable = variable.replace(/&q=/g, ",");
        variable = variable.replace(/&oq/g, ",");
        variable = variable.replace(/=/g, ",");
        variable = variable.replace(/\+/g, ",");
        variable = variable.replace(/&/g, ",");
        variable = variable.replace(/\?/g, ",");
        variable = variable.split(",");

        //alert(variable);

        return variable;
}

function intersect(a, b) 
{
    var t;
    if (b.length > a.length) t = b, b = a, a = t; // indexOf to loop over shorter
    return a.filter(function (e) {
        if (b.indexOf(e) !== -1) return true;
    });
}

//function to load in the necessary libraries
function loadScript(url, callback)
{

    var script = document.createElement("script")
    script.type = "text/javascript";

    if (script.readyState){  //IE
        script.onreadystatechange = function(){
            if (script.readyState == "loaded" ||
                    script.readyState == "complete"){
                script.onreadystatechange = null;
                callback();
            }
        };
    } else {  //Others
        script.onload = function(){
            callback();
        };
    }

    script.src = url;
    document.getElementsByTagName("head")[0].appendChild(script);
}

/** Array Remove - By John Resig (MIT Licensed)
    removes the stated entry in an array
    note this shifts the others forward obvs **/
Array.prototype.remove = function(from, to) 
{
  var rest = this.slice((to || from) + 1 || this.length);
  this.length = from < 0 ? this.length + from : from;
  return this.push.apply(this, rest);
};

/**
 * Array.prototype.[method name] allows you to define/overwrite an objects method
 * needle is the item you are searching for
 * this is a special variable that refers to "this" instance of an Array.
 * returns true if needle is in the array, and false otherwise
 */
Array.prototype.contains = function ( needle ) 
{
   for (i in this) {
       if (this[i] == needle) return true;
   }
   return false;
};


