jQuery(document).ready ->
  jQuery.ajaxSetup cache: true

  fbUrl = "http://www.facebook.com/feeds/page.php?id=563011633772015&format=JSON"
  $.ajax
    url: "http://query.yahooapis.com/v1/public/yql"
    dataType: "jsonp"
    data:
      q: "select * from json where url=\"" + fbUrl + "\""
      format: "json"

    success: (data) ->
      console.log data.query.results.json.entries
      $.each data.query.results.json.entries, (i, v) ->
        $("#entries").append data.query.results.json.entries[i].title + "<br />"

