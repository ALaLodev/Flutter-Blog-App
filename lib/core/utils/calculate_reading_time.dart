int calculateReadingTime(String content) {
  // Contamos los espacios para estimar el número de palabras
  final wordCount = content.split(RegExp(r'\s+')).length;

  // Dividimos por la velocidad media de lectura (225 palabras/min)
  // Usamos ceil() para redondear hacia arriba (mínimo 1 min)
  final readingTime = wordCount / 225;

  return readingTime.ceil();
}
