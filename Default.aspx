<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ArtistResizeSaveRemoteImage.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>

    <title>Artist Resize/Save Remote Image</title>

    <link rel="icon"       type="image/x-icon" href="favicon.ico" />
    <link rel="stylesheet" type="text/css"     href="Site.css" />
    <link rel="stylesheet" type="text/css"     href="banner.css" />
    <link rel="stylesheet" type="text/css"     href="StandardStreams.css" />

    <script src="StandardStreams.js"           type="text/javascript"></script>
    <script src="WorkingWebBrowserServices.js" type="text/javascript"></script>
    <script src="WorkingWebBrowserServices99.js" type="text/javascript"></script>

    <script type="text/javascript">

        // <HEAD> GLOBAL VARIABLES:

        // This will be filled in main():
        var standard_streams_services;

        // This will be filled in get_save_remote_images_process():
        var artist_JSON_object;

        // NOTE: These values match the size of the artist images on the React.js artist
        // maintenance application.  This entire process was developed to handle the poor
        // performance of that process's loading of artist images for a large database
        // of data.
        var WIDTH = 83;
        var HEIGHT = 83;

        // Init:
        var artist_index = 0;

        // <HEAD> AVAILABLE FUNCTIONS:

        function main() {

            // NOTE: All output of all types will be handled by this service:
            standard_streams_services = new standard_streams();

            // Init:
            document.getElementById("image_width").value = WIDTH;
            document.getElementById("image_height").value = HEIGHT;

            // Handle the initial RadioButton value:
            cross_object_synchronize();

        }

        function ButtonAbout_onclick() {

            open_popup_window(
                "About.aspx",
                true, // modal dialog
                "no", // resizable
                "no", // scrollbars
                505,  // width
                660   // height
            );

        }

        function cross_object_synchronize() {

            // Show/hide fields that are dependent on other radiobuttons:

            if (document.getElementById("artist_input_jsondb").checked) {
                document.getElementById('artists_json').style.display = "none";
                document.getElementById('artists_json_label').style.display = "none";
            } else {
                document.getElementById('artists_json').style.display = "block";
                document.getElementById('artists_json_label').style.display = "block";
            }

        }

        function get_save_remote_images_process() {

            if (document.getElementById("artist_input_jsondb").checked) {
                artist_JSON_object = JSON.parse(
                    get_xml_http_request("http://www.workingweb.info/database/Artist/Get/")
                );
            } else {
                artist_JSON_object = JSON.parse(document.getElementById("artists_json").value);
            }

            // Start the loop:
            get_save_remote_images();

        }

        function get_save_remote_images() {

            if (artist_index < artist_JSON_object.artist.length) {

                // Loop:

                // NOTE: This timer is used to establish an async process (without having to employ ES6 async/await).  This is necessary because it
                // is a long-running process and I want to keep the user aware of what is going on and to avoid browser prompts to kill the process.
                setTimeout(function () { get_save_remote_image(artist_JSON_object.artist[artist_index].id, artist_JSON_object.artist[artist_index].image); }, 100); // 100 = 100 milliseconds
            }
            else {
                artist_index = 0; // reset
            }

        }

        function get_save_remote_image(artist, imageUrl) {

            // Since we will be modifying the argument, let's make a copy and work with that:
            var artist_edited = artist;

            // Inform the user of where we are in the loop:
            standard_streams_services.write("message", artist_edited);

            // NOTE: This object is below the message object which is being written to so, by scrolling to it, we will
            // always see the bottom of the message object:
            document.getElementById("error").scrollIntoView();

            var REMOTE_IMAGE_PREFIX = "http://www.workingweb.info/utility/WorkingWebWebServices/api/ResizeSaveRemoteImage/";

            // Create a valid file name:
            var file_name = get_file_name(artist_edited);

            // Prepare for transport:
            artist_edited = replace_all(artist_edited, " ", "%20");

            // Resize/Save Remote Image web service:
            // http://www.workingweb.info/utility/WorkingWebWebServices/api/ResizeSaveRemoteImage/?imageUrl=https://upload.wikimedia.org/wikipedia/commons/d/d1/Elton_John_2011_Shankbone_2.JPG&fileName=file_name&width=200&height=200

            var remote_image_url = REMOTE_IMAGE_PREFIX +
                "?imageUrl=" + imageUrl +
                "&fileName=" + file_name +
                "&width=" + WIDTH +
                "&height=" + HEIGHT;

            // Execute the web service:
            get_xml_http_request(remote_image_url);

            // Loop through again:
            artist_index++;
            get_save_remote_images();

        }

    </script>

</head>
<body class="BaseColor">

    <div id="bannerDiv">
        <img src="ArtistResizeSaveRemoteImage100x100.png" alt="" />
        <span id="bannerText">Artist Resize/Save Remote Image Utility</span>
    </div>

    <form id="form1" runat="server">

        <br />
        NOTE: Your resized images will be created on the GoDaddy server at:
        <br />
        http://www.workingweb.info/Utility/WorkingWebWebServices/ 
        <br />
        and may be subject to space limitations.
        <br />
        <br />

        <div id="artist_input_div" >

            <h4 class="AccentColor">Artists</h4>

            <input type="radio" name="artist_input" id="artist_input_jsondb" value="jsonDB"  onclick="cross_object_synchronize()" checked/>JSON DB<br>
            <input type="radio" name="artist_input" id="artist_input_user_input" value="userInput" onclick="cross_object_synchronize()"/>User Entered<br>


        </div>

        <br />
        Width: <input class="ImageSize" type="text" id="image_width"/>
        Height: <input class="ImageSize" type="text" id="image_height"/>
        <br />
        <br />

        <input id="run" type="button" onclick="get_save_remote_images_process()" value="Get/Save Artist Images"/>&nbsp;&nbsp;
        <input id="ButtonAbout" type="button" value="About" onclick="return ButtonAbout_onclick()"/><br/>
        <br/>
        
        <a href="http://www.workingweb.info/database/Artist/Get/" target="_blank">JSON DB Artists</a>
        <br />
        <br/>
        <a href="http://jsonformatter.curiousconcept.com/" target="_blank">JSON Formatter & Validator</a>        
        <br/>
        <br/>

        <span id="artists_json_label">Artist JSON:</span>
        <br />

        <textarea id="artists_json" cols="1"></textarea>
        <br />

        <%------------------------------------------------------------------------------------------------------------------%> 
        <!-- This shows the "standard footer" for my GUI forms. -->
        <!--#include file="StandardStreams.htm"-->
        <%------------------------------------------------------------------------------------------------------------------%>

        <script type="text/javascript">

            // <BODY> STARTUP PROCESSING:

            main();

        </script>

    </form>
</body>
</html>
