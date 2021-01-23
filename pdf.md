# Handling PDFs

### OCR a pdf
```
ocrmypdf in.pdf out.pdf
```
With lossy compression:
```
ocrmypdf --optimize 2 in.pdf out.pdf
```

### Redo OCR on a pdf
```
ocrmypdf --redo-ocr in.pdf out.pdf
```
If that gives poor performance, try
```
ocrmypdf --force-ocr in.pdf out.pdf
```

### Split a scanned book into separate pages
```
brew install mupdf
mutool poster -y 2 input.pdf output.pdf
```

### Convert set of images into an OCR'd pdf
```
img2pdf my-images*.jpg | ocrmypdf - myfile.pdf
```
