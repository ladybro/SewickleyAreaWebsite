jQuery(document).ready ->
  jQuery.ajaxSetup cache: true

  fbUrl = "http://www.facebook.com/feeds/page.php?id=563011633772015&format=JSON"
  jQuery.ajax
    url: "http://query.yahooapis.com/v1/public/yql"
    dataType: "jsonp"
    data:
      q: "select * from json where url=\"" + fbUrl + "\""
      format: "json"

    success: (data) ->
      source   = jQuery("#fb-post-template").html();
      template = Handlebars.compile(source);
      console.log data.query.results.json.entries
      jQuery.each data.query.results.json.entries, (i, v) ->
        post = data.query.results.json.entries[i]
        context =
          title:    post.title
          postId:   post.id
          date:     post.published
          imageSRC: "something"
          postURL:  post.alternate
          body:     post.content
        html    = template(context);
        console.log context
        jQuery("#posts").append html

