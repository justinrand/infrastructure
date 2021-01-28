function delay(level) {
  var DELAY = Math.pow(10, level);
  var i = 1;
  while (i < DELAY) i++;
  return "delay=" + i;
}

function create_response(req, res, type) {
  var content = "This page simulates a reponse that takes a " + type +
                " time to return. ";
  res.status = 200;
  res.contentType = "text/html; charset=utf-8";
  res.contentLength = content.length;
  res.sendHeader();
  res.send(content);
  res.finish();
}

function minimum_delay(req, res) {
  delay(7); create_response(req, res, "minimum");
};
function short_delay(req, res) {
  delay(7); create_response(req, res, "short");
};
function medium_delay(req, res) {
  delay(8); create_response(req, res, "medium");
};
function long_delay(req, res) {
  delay(9); create_response(req, res, "long");
};
