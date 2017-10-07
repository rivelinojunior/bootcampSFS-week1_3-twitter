function limitTextSize(e) {
  var max = 280
  var txt = $("#image_description").val();
  var left = txt.substring(0, max);
  var right = txt.substring(max);
  var html = left + '<span class="highlight">' + right + "</span>";
  $("#overflowText").html(html);
  $("#counter").html(max - txt.length);
  $("#tweet_button").attr("disabled", txt.length > max);
}
