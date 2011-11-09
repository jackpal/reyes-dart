double radians(double degrees)
{
    return degrees * 0.017453277;
}

void log(String message) {
  // the DOM library defines a global "window" variable
  HTMLDocument doc = window.document;
  HTMLParagraphElement p = doc.createElement('p');
  p.innerText = message;
  doc.body.appendChild(p);
}
