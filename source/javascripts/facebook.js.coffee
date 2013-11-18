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

      jQuery.each data.query.results.json.entries, (i, v) ->
        post = data.query.results.json.entries[i]
        oPost = organizePost(post)

        context =
          title:    oPost.title
          postId:   oPost.id
          date:     oPost.published
          imageSRC: oPost.firstImage
          postURL:  oPost.alternate
          body:     oPost.content

        html    = template(context);
        jQuery("#posts").append html

organizePost = (entry) ->
  entry.firstImage = jQuery(entry.content).find('img:first').attr('src')
  content = jQuery("<div></div>").append(entry.content)
  content.find('img:first').remove()
  entry.content = content.html()
  entry
